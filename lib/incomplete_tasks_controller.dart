import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IncompleteTasksController extends GetxController {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Firestore örneği
  var tasks = <QueryDocumentSnapshot>[]
      .obs; // Tamamlanmamış görevlerin listesi (observable)
  var searchQuery = ''.obs; // Arama sorgusunu tutan observable değişken

  @override
  void onInit() {
    super.onInit();
    _fetchIncompleteTasks(); // Başlangıçta tamamlanmamış görevleri al
    ever(
        searchQuery,
        (_) =>
            _fetchIncompleteTasks()); // Arama sorgusu değiştiğinde görevleri tekrar al
  }

  void _fetchIncompleteTasks() {
    var query = _firestore
        .collection('tasks')
        .where('completed',
            isEqualTo: false) // Tamamlanmamış görevleri filtrele
        .orderBy('created_at',
            descending: true); // Görevleri oluşturulma tarihine göre sırala

    if (searchQuery.value.isNotEmpty) {
      query = query
          .orderBy('title') // Görev başlığına göre sırala
          .startAt([searchQuery.value]).endAt(
              [searchQuery.value + '\uf8ff']); // Arama yap
    }

    query.snapshots().listen((snapshot) {
      tasks.value = snapshot.docs; // Görevleri güncelle
    });
  }
}
