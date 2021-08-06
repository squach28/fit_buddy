import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_buddy/models/SignInResult.dart';
import 'package:fit_buddy/models/SignUpResult.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fit_buddy/services/PointsService.dart';

class AuthenticationService {
  final auth = FirebaseAuth.instance;
  final pointsService = PointsService();

  /* signs a user up with firebase
     params: firstName - user's first name
             email - user's email
             password - user's password
   
     return: SignUpResult - result of the sign up process (SUCCESS, WEAK_PASSWORD, EMAIL_IN_USE, FAIL)
  */
  Future<SignUpResult> signUp(
      String firstName, String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      auth.currentUser.updateProfile(displayName: firstName).then((value) {
        pointsService.createProfile(
            auth.currentUser.uid, auth.currentUser.displayName);
      }); // change the display name in authentication to the first name
      return SignUpResult.SUCCESS;
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'weak-password') {
        return SignUpResult.WEAK_PASSWORD;
      } else if (e.code == 'email-already-in-use') {
        return SignUpResult.EMAIL_IN_USE;
      }
    } catch (e) {
      print(e);
      return SignUpResult.FAIL;
    }
    return SignUpResult.FAIL;
  }

  Future<SignInResult> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return SignInResult.SUCCESS;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return SignInResult.USER_NOT_FOUND;
      } else if (e.code == 'wrong-password') {
        return SignInResult.WRONG_PASSWORD;
      } else {
        return SignInResult.FAIL;
      }
    } on Exception catch (e) {
      return SignInResult.FAIL;
    }
  }

  Future<UserCredential> googleSignin() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential = await auth.signInWithCredential(credential);
      bool pointsProfileExists = await pointsService.profileExists(auth.currentUser.uid);
      if (!pointsProfileExists) {
        pointsService.createProfile(
            auth.currentUser.uid, auth.currentUser.displayName);
      }

      return userCredential;
    } catch (Exception) {
      return null;
    }
  }

  Future<GoogleSignInAccount> googleSignOut() async {
    return await GoogleSignIn().signOut();
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  // returns the uid of the current user that is logged in 
  String retrieveCurrentUserUid() {
    return auth.currentUser.uid;
  }
}
