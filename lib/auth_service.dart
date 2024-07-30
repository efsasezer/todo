import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? currentUser() {
    return _auth.currentUser;
  }

  Future<User?> registerWithEmailAndPassword(
      String email, String password, String displayName) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await user!.updateDisplayName(displayName);
      return user;
    } catch (e) {
      print('Error during registration: ${e.toString()}');
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print('Error during sign-in: ${e.toString()}');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error during sign-out: ${e.toString()}');
    }
  }
}
