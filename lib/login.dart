import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController loginController =
      Get.put(LoginController()); // LoginController'ı GetX ile al

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giriş Yap'), // Uygulama çubuğundaki başlık
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0), // Etrafına boşluk ekle
        child: Form(
          key: loginController.formKey, // Form anahtarını ayarla
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'E-posta'), // E-posta için etiket
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen e-posta adresinizi girin'; // E-posta boşsa hata mesajı
                  }
                  return null;
                },
                onSaved: (value) {
                  loginController.email.value =
                      value!; // E-posta değerini controller'a kaydet
                },
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Şifre'), // Şifre için etiket
                obscureText: true, // Şifreyi gizle
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen şifrenizi girin'; // Şifre boşsa hata mesajı
                  }
                  return null;
                },
                onSaved: (value) {
                  loginController.password.value =
                      value!; // Şifre değerini controller'a kaydet
                },
              ),
              SizedBox(height: 20.0), // Alanlar arasında boşluk ekle
              ElevatedButton(
                onPressed: () =>
                    loginController.login(), // Giriş işlemini başlat
                child: Text('Giriş Yap'),
              ),
              SizedBox(
                  height: 20.0), // Buton ile hata mesajı arasında boşluk ekle
              Obx(() => Text(
                    loginController.errorMessage
                        .value, // Hata mesajını dinamik olarak göster
                    style: TextStyle(color: Colors.red),
                  )),
              TextButton(
                onPressed: () {
                  Get.toNamed('/register'); // Kayıt ol sayfasına geçiş yap
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
