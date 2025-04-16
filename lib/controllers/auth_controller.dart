import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> registerNewUser(
    String email,
    String fullName,
    String password,
  ) async {
    String response = "something went wrong";
    try {
      // Create user
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Set display name (username)
      await userCredential.user!.updateDisplayName(fullName);
      await userCredential.user!.reload(); // reload to apply changes

      response = "success";
    } catch (e) {
      print("Registration error: $e");
      return response;
    }
    return response;
  }
}
