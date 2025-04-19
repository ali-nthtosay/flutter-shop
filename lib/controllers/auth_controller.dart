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
    } catch (e) {
      print("Registration error: $e");
      response = e.toString();
    }

    return response;
  }

  // Login user
  Future<String> loginUser(String email, String password) async {
    String res = 'Something went wrong';
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = "success";
    } catch (e) {
      print("Login error: $e");
      res = e.toString();
    }

    return res;
  }
}
