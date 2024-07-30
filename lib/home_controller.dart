import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_service.dart';
import 'task_service.dart';

class HomeController extends GetxController {
  final AuthService _authService = AuthService(); // Auth işlemleri için servis
  final TaskService _taskService = TaskService(); // Task işlemleri için servis
  final TextEditingController taskController =
      TextEditingController(); // Görev ekleme için kontrolcü
  final TextEditingController searchController =
      TextEditingController(); // Arama için kontrolcü
  User? user; // Mevcut kullanıcı
  var showCompleted = false.obs; // Tamamlanmış görevlerin gösterim durumu
  var searchQuery = ''.obs; // Arama sorgusu

  @override
  void onInit() {
    super.onInit();
    user = _authService.currentUser(); // Mevcut kullanıcıyı al
    searchController.addListener(() {
      searchQuery.value = searchController.text; // Arama sorgusunu güncelle
    });
  }

  Future<void> addTask() async {
    String title = taskController.text.trim(); // Görev başlığını al
    if (title.isNotEmpty && user != null) {
      await _taskService.addTask(user!.uid, title); // Görevi ekle
      taskController.clear(); // Giriş alanını temizle
    }
  }

  Future<void> toggleTaskCompletion(String taskId, bool completed) async {
    await _taskService.updateTask(
        taskId, completed); // Görev tamamlanma durumunu güncelle
  }

  Future<void> deleteTask(String taskId) async {
    await _taskService.deleteTask(taskId); // Görevi sil
  }

  Future<void> signOut() async {
    await _authService.signOut(); // Kullanıcıyı çıkış yap
    Get.offAllNamed('/login'); // Giriş sayfasına yönlendir
  }

  Stream<QuerySnapshot> getTasks() {
    return _taskService.getTasks(
      user?.uid ?? '', // Kullanıcı ID'sini al
      showCompleted.value, // Tamamlanmış görevlerin gösterim durumu
      searchQuery.value, // Arama sorgusu
    );
  }
}
