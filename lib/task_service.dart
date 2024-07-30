import 'package:cloud_firestore/cloud_firestore.dart';

class TaskService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Firestore instance'ını al

  // Görev ekleme
  Future<void> addTask(String uid, String title) async {
    try {
      await _firestore.collection('tasks').add({
        'uid': uid, // Kullanıcı ID'si
        'title': title, // Görev başlığı
        'completed': false, // Görev tamamlanmış değil
        'created_at': FieldValue
            .serverTimestamp(), // Oluşturulma tarihi (server timestamp)
      });
    } catch (e) {
      print('Error adding task: $e'); // Hata durumunda hata mesajını yazdır
    }
  }

  // Görevleri alma
  Stream<QuerySnapshot> getTasks(
      String uid, bool completed, String searchQuery) {
    var query = _firestore
        .collection('tasks')
        .where('uid', isEqualTo: uid) // Kullanıcı ID'sine göre filtrele
        .where('completed',
            isEqualTo: completed) // Tamamlanmışlık durumuna göre filtrele
        .orderBy('created_at',
            descending: true); // Oluşturulma tarihine göre sıralama

    if (searchQuery.isNotEmpty) {
      query = query
          .orderBy('title') // Başlığa göre sıralama
          .startAt([searchQuery]) // Arama sorgusunun başladığı yer
          .endAt([
        searchQuery + '\uf8ff'
      ]); // Arama sorgusunun bittiği yer (Unicode karakteri ile genişlet)
    }

    return query.snapshots(); // Veritabanı değişikliklerini dinle
  }

  // Görev güncelleme
  Future<void> updateTask(String taskId, bool completed) async {
    try {
      await _firestore.collection('tasks').doc(taskId).update({
        'completed': completed, // Görevin tamamlanmışlık durumunu güncelle
      });
    } catch (e) {
      print('Error updating task: $e'); // Hata durumunda hata mesajını yazdır
    }
  }

  // Görev başlığını güncelleme
  Future<void> updateTaskTitle(String taskId, String title) async {
    try {
      await _firestore.collection('tasks').doc(taskId).update({
        'title': title, // Görev başlığını güncelle
      });
    } catch (e) {
      print(
          'Error updating task title: $e'); // Hata durumunda hata mesajını yazdır
    }
  }

  // Görev silme
  Future<void> deleteTask(String taskId) async {
    try {
      await _firestore.collection('tasks').doc(taskId).delete(); // Görevi sil
    } catch (e) {
      print('Error deleting task: $e'); // Hata durumunda hata mesajını yazdır
    }
  }
}
