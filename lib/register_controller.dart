import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_service.dart';

class RegisterController extends GetxController {
  final AuthService _authService =
      AuthService(); // Yetkilendirme işlemleri için servis
  final _formKey =
      GlobalKey<FormState>(); // Form durumunu takip etmek için anahtar
  final email = ''.obs; // Kullanıcı e-posta adresi
  final password = ''.obs; // Kullanıcı şifresi
  final displayName = ''.obs; // Kullanıcı adı
  final errorMessage = ''.obs; // Hata mesajları

  GlobalKey<FormState> get formKey => _formKey; // Form anahtarını al

  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      // Form geçerli mi kontrol et
      _formKey.currentState!.save(); // Form verilerini kaydet

      // E-posta ve şifre ile kayıt ol
      var user = await _authService.registerWithEmailAndPassword(
        email.value,
        password.value,
        displayName.value,
      );
      if (user == null) {
        errorMessage.value =
            'Kayıt başarısız. Lütfen tekrar deneyin.'; // Hata mesajını ayarla
      } else {
        Get.offAllNamed(
            '/home'); // Başarıyla kayıt olduktan sonra ana sayfaya yönlendir
      }
    }
  }
}
