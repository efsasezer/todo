import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_service.dart';

class LoginController extends GetxController {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final email = ''.obs;
  final password = ''.obs;
  final errorMessage = ''.obs;

  GlobalKey<FormState> get formKey => _formKey;

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var user = await _authService.signInWithEmailAndPassword(
          email.value, password.value);
      if (user == null) {
        errorMessage.value = 'Giriş başarısız. Lütfen tekrar deneyin.';
      } else {
        Get.offAllNamed('/home');
      }
    }
  }
}
