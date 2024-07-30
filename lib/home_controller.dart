import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_service.dart';
import 'task_service.dart';

class HomeController extends GetxController {
  final AuthService _authService = AuthService();
  final TaskService _taskService = TaskService();
  final TextEditingController taskController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  User? user;
  var showCompleted = false.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    user = _authService.currentUser();
    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });
  }

  Future<void> addTask() async {
    String title = taskController.text.trim();
    if (title.isNotEmpty && user != null) {
      await _taskService.addTask(user!.uid, title);
      taskController.clear();
    }
  }

  Future<void> toggleTaskCompletion(String taskId, bool completed) async {
    await _taskService.updateTask(taskId, completed);
  }

  Future<void> deleteTask(String taskId) async {
    await _taskService.deleteTask(taskId);
  }

  Future<void> signOut() async {
    await _authService.signOut();
    Get.offAllNamed('/login');
  }

  Stream<QuerySnapshot> getTasks() {
    return _taskService.getTasks(
      user?.uid ?? '',
      showCompleted.value,
      searchQuery.value,
    );
  }
}
