import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'incomplete_tasks_controller.dart';

class IncompleteTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IncompleteTasksController incompleteTasksController = Get.put(
        IncompleteTasksController()); // IncompleteTasksController'ı GetX ile al

    return Scaffold(
      appBar: AppBar(
        title: Text('Tamamlanmamış Görevler'), // Uygulama çubuğundaki başlık
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(kToolbarHeight), // AppBar boyutunu ayarla
          child: Padding(
            padding: EdgeInsets.all(8.0), // Padding ekle
            child: TextField(
              onChanged: (value) {
                incompleteTasksController.searchQuery.value =
                    value; // Arama sorgusunu güncelle
              },
              decoration: InputDecoration(
                hintText: 'Görev ara...', // Arama kutusu için yer tutucu metin
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0), // Kenarları yuvarla
                ),
                prefixIcon: Icon(Icons.search), // Arama simgesi
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (incompleteTasksController.tasks.isEmpty) {
          return Center(
              child: Text(
                  'Tamamlanmamış görev yok.')); // Görev listesi boşsa mesaj göster
        }
        return ListView.builder(
          itemCount:
              incompleteTasksController.tasks.length, // Görev sayısını belirle
          itemBuilder: (context, index) {
            var task = incompleteTasksController.tasks[index]; // Görevi al
            return ListTile(
              title: Text(task['title']), // Görev başlığını göster
              subtitle: Text(
                task['created_at']?.toDate().toString() ??
                    '', // Görev oluşturulma tarihini göster
              ),
            );
          },
        );
      }),
    );
  }
}
