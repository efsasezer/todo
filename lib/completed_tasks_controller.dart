import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompletedTasksController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var tasks = <QueryDocumentSnapshot>[].obs; // Tamamlanmış görevlerin listesi
  var filteredTasks =
      <QueryDocumentSnapshot>[].obs; // Filtrelenmiş görevlerin listesi
  var searchQuery = ''.obs; // Arama sorgusu

  @override
  void onInit() {
    super.onInit();
    _fetchCompletedTasks(); // Başlangıçta tamamlanmış görevleri getir
    // Arama sorgusu değiştiğinde görevleri tekrar getir
    ever(searchQuery, (_) => _fetchCompletedTasks());
  }

  void _fetchCompletedTasks() {
    var query = _firestore
        .collection('tasks')
        .where('completed', isEqualTo: true) // Tamamlanmış görevleri filtrele
        .orderBy('created_at',
            descending: true); // Görevleri tarihine göre sırala

    if (searchQuery.value.isNotEmpty) {
      query = query
          .orderBy('title') // Başlığa göre sırala
          .startAt([searchQuery.value]).endAt([
        searchQuery.value + '\uf8ff'
      ]); // Arama terimini kullanarak filtrele
    }

    query.snapshots().listen((snapshot) {
      tasks.value = snapshot.docs; // Tamamlanmış görevleri güncelle
      filteredTasks.value = snapshot.docs; // Filtrelenmiş görevleri güncelle
    });
  }

  void searchTasks(String query) {
    searchQuery.value = query; // Arama sorgusunu güncelle
  }
}
