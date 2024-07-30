import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_task_controller.dart';

class AddTaskPage extends StatelessWidget {
  final String userId;

  // Constructor
  AddTaskPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    final AddTaskController addTaskController = Get.put(AddTaskController());

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Yeni Görev Ekle'), // Uygulama çubuğunda gösterilecek başlık
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Form için iç boşluk
        child: Form(
          key: addTaskController.formKey, // Form anahtarı
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: addTaskController
                    .titleController, // Başlık için metin denetleyicisi
                decoration:
                    InputDecoration(labelText: 'Görev Başlığı'), // Etiket
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen görev başlığını girin'; // Boş başlık için hata mesajı
                  }
                  return null;
                },
              ),
              SizedBox(
                  height: 20.0), // Buton ile form elemanları arasındaki boşluk
              ElevatedButton(
                onPressed: () => addTaskController
                    .addTask(userId), // Görev ekleme fonksiyonu
                child: Text('Ekle'), // Buton üzerindeki metin
              ),
            ],
          ),
        ),
      ),
    );
  }
}
