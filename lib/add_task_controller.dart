import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'task_service.dart';

class AddTaskController extends GetxController {
  final TaskService _taskService = TaskService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();

  Future<void> addTask(String userId) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await _taskService.addTask(userId, titleController.text.trim());
      Get.offNamed('/home'); // Görev eklendikten sonra ana sayfaya yönlendir
    }
  }
}
