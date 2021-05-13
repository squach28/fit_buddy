import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_buddy/models/SignInResult.dart';
import 'package:fit_buddy/models/SignUpResult.dart';
class AuthenticationService {
  final auth = FirebaseAuth.instance;

  /* signs a user up with firebase
     params: firstName - user's first name
             email - user's email
             password - user's password
   
     return: SignUpResult - result of the sign up process (SUCCESS, WEAK_PASSWORD, EMAIL_IN_USE, FAIL)
  */
  Future<SignUpResult> signUp(String firstName, String email, String password) async{
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      auth.currentUser.updateProfile(displayName: firstName);
      return SignUpResult.SUCCESS;
    } on FirebaseAuthException catch(e) {
      print(e);
      if(e.code == 'weak-password') {
        return SignUpResult.WEAK_PASSWORD;
      } else if(e.code == 'email-already-in-use') {
        return SignUpResult.EMAIL_IN_USE;
      }
    } catch(e) {
      print(e);
      return SignUpResult.FAIL;
    }
    return SignUpResult.FAIL;
  }

  Future<SignInResult> logIn(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      return SignInResult.SUCCESS;
    } on FirebaseAuthException catch(e) {
      if(e.code == 'user-not-found') {
        return SignInResult.USER_NOT_FOUND;
      } else if(e.code == 'wrong-password') {
        return SignInResult.WRONG_PASSWORD;
      } else {
        return SignInResult.FAIL;
      }
    } on Exception catch(e) {
      return SignInResult.FAIL;
    }
  }
}