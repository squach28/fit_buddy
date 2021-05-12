import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_buddy/models/SignUpResult.dart';
class AuthenticationService {
  final auth = FirebaseAuth.instance;

  /* signs a user up with firebase
     params: firstName - user's first name
             email - user's email
             password - user's password
   
     return: SignUpResult - result of the sign up process (SUCCESS, WEAK_PASSWORD, EMAIL_IN_USE, FAIL)
  */
  Future<SignUpResult> _signUp(String firstName, String email, String password) async{
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
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
  }
}