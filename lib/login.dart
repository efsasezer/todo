import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giriş Yap'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: loginController.formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'E-posta'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen e-posta adresinizi girin';
                  }
                  return null;
                },
                onSaved: (value) {
                  loginController.email.value = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Şifre'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen şifrenizi girin';
                  }
                  return null;
                },
                onSaved: (value) {
                  loginController.password.value = value!;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => loginController.login(),
                child: Text('Giriş Yap'),
              ),
              SizedBox(height: 20.0),
              Obx(() => Text(
                    loginController.errorMessage.value,
                    style: TextStyle(color: Colors.red),
                  )),
              TextButton(
                onPressed: () {
                  Get.toNamed('/register');
                },
                child: Text('Kayıt Ol'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
