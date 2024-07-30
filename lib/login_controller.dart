import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_service.dart';

class LoginController extends GetxController {
  final AuthService _authService =
      AuthService(); // AuthService ile kimlik doğrulama işlemlerini yap
  final _formKey =
      GlobalKey<FormState>(); // Form durumunu takip etmek için anahtar
  final email = ''.obs; // E-posta adresini takip eden reaktif değişken
  final password = ''.obs; // Şifreyi takip eden reaktif değişken
  final errorMessage = ''.obs; // Hata mesajını takip eden reaktif değişken

  GlobalKey<FormState> get formKey => _formKey; // Form anahtarını dışarıya aç

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      // Form geçerli mi kontrol et
      _formKey.currentState!.save(); // Formu kaydet
      var user = await _authService.signInWithEmailAndPassword(
          email.value, password.value); // E-posta ve şifre ile giriş yap
      if (user == null) {
        errorMessage.value =
            'Giriş başarısız. Lütfen tekrar deneyin.'; // Giriş başarısızsa hata mesajını ayarla
      } else {
        Get.offAllNamed(
            '/home'); // Başarılı giriş sonrası ana sayfaya yönlendir
      }
    }
  }
}
