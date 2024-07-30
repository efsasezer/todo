import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_service.dart';

class RegisterController extends GetxController {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final email = ''.obs;
  final password = ''.obs;
  final displayName = ''.obs;
  final errorMessage = ''.obs;

  GlobalKey<FormState> get formKey => _formKey;

  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var user = await _authService.registerWithEmailAndPassword(
        email.value,
        password.value,
        displayName.value,
      );
      if (user == null) {
        errorMessage.value = 'Kayıt başarısız. Lütfen tekrar deneyin.';
      } else {
        Get.offAllNamed('/home');
      }
    }
  }
}
