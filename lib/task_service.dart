import 'package:cloud_firestore/cloud_firestore.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Görev ekleme
  Future<void> addTask(String uid, String title) async {
    try {
      await _firestore.collection('tasks').add({
        'uid': uid,
        'title': title,
        'completed': false,
        'created_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  // Görevleri alma
  Stream<QuerySnapshot> getTasks(
      String uid, bool completed, String searchQuery) {
    Query query = _firestore
        .collection('tasks')
        .where('uid', isEqualTo: uid)
        .where('completed', isEqualTo: completed)
        .orderBy('created_at', descending: true);

    if (searchQuery.isNotEmpty) {
      // Sorgu indekslerini kontrol edin
      query = query
          .orderBy(
              'title') // Firestore'da bir sıralama yapıldığında 'orderBy' ile birlikte kullanılmalıdır.
          .startAt([searchQuery]).endAt([searchQuery + '\uf8ff']);
    }

    return query.snapshots();
  }

  // Görev güncelleme
  Future<void> updateTask(String taskId, bool completed) async {
    try {
      await _firestore.collection('tasks').doc(taskId).update({
        'completed': completed,
      });
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  // Görev başlığını güncelleme
  Future<void> updateTaskTitle(String taskId, String title) async {
    try {
      await _firestore.collection('tasks').doc(taskId).update({
        'title': title,
      });
    } catch (e) {
      print('Error updating task title: $e');
    }
  }

  // Görev silme
  Future<void> deleteTask(String taskId) async {
    try {
      await _firestore.collection('tasks').doc(taskId).delete();
    } catch (e) {
      print('Error deleting task: $e');
    }
  }
}
