import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'register_controller.dart';

class RegisterPage extends StatelessWidget {
  final RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kayıt Ol'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: registerController.formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen kullanıcı adınızı girin';
                  }
                  return null;
                },
                onSaved: (value) {
                  registerController.displayName.value = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'E-posta'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen e-posta adresinizi girin';
                  }
                  return null;
                },
                onSaved: (value) {
                  registerController.email.value = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Şifre'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen şifrenizi girin';
                  } else if (value.length < 8) {
                    return 'Şifreniz en az 8 karakter olmalıdır';
                  }
                  return null;
                },
                onSaved: (value) {
                  registerController.password.value = value!;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => registerController.register(),
                child: Text('Kayıt Ol'),
              ),
              SizedBox(height: 20.0),
              Obx(() => Text(
                    registerController.errorMessage.value,
                    style: TextStyle(color: Colors.red),
                  )),
              TextButton(
                onPressed: () {
                  Get.toNamed('/login');
                },
                child: Text('Giriş Yap'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
