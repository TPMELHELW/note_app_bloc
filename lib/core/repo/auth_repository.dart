import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  signUp(String email, password, firstName, lastName) async {
    try {
      //make an account
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //send verification link
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();

      //store user data
      await FirebaseFirestore.instance.collection('users').add({
        'firstName': firstName,
        'lastName': lastName,
      });
      return credential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    } catch (e) {
      throw FirebaseAuthException(code: "Unknown");
    }
  }

  logIn(String email, password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        // print('success');
        return credential;
      } else {
        throw FirebaseAuthException(code: 'not-verified');
      }
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    }
  }
}
