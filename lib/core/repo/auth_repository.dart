import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  signUp(String email, password) async {
    try {
      //make an account
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //send verification link
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      return credential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    } catch (e) {
      throw FirebaseAuthException(code: "Unknown");
    }
  }

  logIn(String email, password) async {
    try {
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        return credential;
      } else {
        throw FirebaseAuthException(code: 'not-verified');
      }
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    }
  }
}
