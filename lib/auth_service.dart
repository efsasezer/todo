import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth =
      FirebaseAuth.instance; // Firebase Authentication instance

  // Şu anki kullanıcıyı döndür
  User? currentUser() {
    return _auth.currentUser;
  }

  // E-posta ve şifre ile kullanıcı kaydı yap
  Future<User?> registerWithEmailAndPassword(
      String email, String password, String displayName) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await user!.updateDisplayName(displayName); // Kullanıcı adını güncelle
      return user;
    } catch (e) {
      print(
          'Error during registration: ${e.toString()}'); // Hata mesajını yazdır
      return null;
    }
  }

  // E-posta ve şifre ile kullanıcı girişi yap
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print('Error during sign-in: ${e.toString()}'); // Hata mesajını yazdır
      return null;
    }
  }

  // Kullanıcıyı çıkış yap
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error during sign-out: ${e.toString()}'); // Hata mesajını yazdır
    }
  }
}
