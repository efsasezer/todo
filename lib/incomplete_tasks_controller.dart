import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IncompleteTasksController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var tasks = <QueryDocumentSnapshot>[].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchIncompleteTasks();
    ever(searchQuery, (_) => _fetchIncompleteTasks());
  }

  void _fetchIncompleteTasks() {
    _firestore
        .collection('tasks')
        .where('completed', isEqualTo: false)
        .orderBy('created_at', descending: true)
        .snapshots()
        .listen((snapshot) {
      if (searchQuery.value.isNotEmpty) {
        tasks.value = snapshot.docs.where((doc) {
          return doc['title']
              .toString()
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase());
        }).toList();
      } else {
        tasks.value = snapshot.docs;
      }
    });
  }
}
