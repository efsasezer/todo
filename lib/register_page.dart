import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'register_controller.dart';

class RegisterPage extends StatelessWidget {
  final RegisterController registerController =
      Get.put(RegisterController()); // RegisterController'ı GetX ile yönet

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kayıt Ol'), // Uygulama çubuğundaki başlık
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0), // Etrafına boşluk ekle
        child: Form(
          key: registerController.formKey, // Form anahtarını ayarla
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    labelText:
                        'Kullanıcı Adı'), // Kullanıcı adı girişi için etiket
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen kullanıcı adınızı girin'; // Boş kullanıcı adı için hata mesajı
                  }
                  return null;
                },
                onSaved: (value) {
                  registerController.displayName.value =
                      value!; // Kullanıcı adını kaydet
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'E-posta'), // E-posta girişi için etiket
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen e-posta adresinizi girin'; // Boş e-posta için hata mesajı
                  }
                  return null;
                },
                onSaved: (value) {
                  registerController.email.value =
                      value!; // E-posta adresini kaydet
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Şifre'), // Şifre girişi için etiket
                obscureText: true, // Şifreyi gizle
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen şifrenizi girin'; // Boş şifre için hata mesajı
                  } else if (value.length < 8) {
                    return 'Şifreniz en az 8 karakter olmalıdır'; // Kısa şifre için hata mesajı
                  }
                  return null;
                },
                onSaved: (value) {
                  registerController.password.value = value!; // Şifreyi kaydet
                },
              ),
              SizedBox(
                  height: 20.0), // Buton ile hata mesajı arasına boşluk ekle
              ElevatedButton(
                onPressed: () =>
                    registerController.register(), // Kayıt olma işlemini başlat
                child: Text('Kayıt Ol'),
              ),
              SizedBox(
                  height:
                      20.0), // Kayıt butonu ile hata mesajı arasına boşluk ekle
              Obx(() => Text(
                    registerController
                        .errorMessage.value, // Hata mesajını göster
                    style: TextStyle(
                        color: Colors.red), // Kırmızı renk ile hata mesajı
                  )),
              TextButton(
                onPressed: () {
                  Get.toNamed('/login'); // Giriş sayfasına yönlendir
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
