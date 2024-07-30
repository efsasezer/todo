import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'task_service.dart';

class AddTaskController extends GetxController {
  final TaskService _taskService =
      TaskService(); // TaskService sınıfı ile görev işlemleri
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(); // Form durumunu izlemek için anahtar
  final TextEditingController titleController =
      TextEditingController(); // Başlık için metin denetleyicisi

  // Görev ekleme fonksiyonu
  Future<void> addTask(String userId) async {
    // Formun geçerli olup olmadığını kontrol et
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save(); // Formu kaydet
      await _taskService.addTask(
          userId, titleController.text.trim()); // Görevi ekle
      Get.offNamed('/home'); // Görev eklendikten sonra ana sayfaya yönlendir
    }
  }
}
