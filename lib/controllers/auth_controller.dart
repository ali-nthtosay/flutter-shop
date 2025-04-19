import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register new user
  Future<String> registerNewUser(
    String email,
    String fullName,
    String password,
  ) async {
    String response = "Something went wrong";
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore.collection('buyers').doc(userCredential.user!.uid).set({
        'fullname': fullName,
        'email': email,
        'profileImage': "",
        'uid': userCredential.user!.uid,
        'pinCode': "",
        'locality': "",
        'city': "",
      });

      response = "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        response = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        response = 'The account already exists for that email.';
      } else {
        response = e.message ?? response;
      }
    } catch (e) {
      response = 'An error occurred. Please try again.';
    }

    return response;
  }

  // Login user
  Future<String> loginUser(String email, String password) async {
    String res = 'Something went wrong';
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        res = 'Wrong password provided.';
      } else {
        res = e.message ?? res;
      }
    } catch (e) {
      res = 'An error occurred. Try again.';
    }

    return res;
  }
}
