import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompletedTasksController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var tasks = <QueryDocumentSnapshot>[].obs;
  var filteredTasks = <QueryDocumentSnapshot>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchCompletedTasks();
  }

  void _fetchCompletedTasks() {
    _firestore
        .collection('tasks')
        .where('completed', isEqualTo: true)
        .orderBy('created_at', descending: true)
        .snapshots()
        .listen((snapshot) {
      tasks.value = snapshot.docs;
      filteredTasks.value = snapshot.docs;
    });
  }

  void searchTasks(String query) {
    if (query.isEmpty) {
      filteredTasks.value = tasks;
    } else {
      filteredTasks.value = tasks
          .where((task) =>
              task['title'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
