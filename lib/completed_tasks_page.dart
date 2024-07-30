import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'completed_tasks_controller.dart';

class CompletedTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // CompletedTasksController'ı GetX ile bağla
    final CompletedTasksController completedTasksController =
        Get.put(CompletedTasksController());
    final TextEditingController searchController =
        TextEditingController(); // Arama için kontrolcü

    return Scaffold(
      appBar: AppBar(
        title: Text('Tamamlanmış Görevler'), // Uygulama çubuğu başlığı
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController, // Arama kontrolcüsünü ata
              decoration: InputDecoration(
                labelText: 'Ara', // Arama metni
                border: OutlineInputBorder(), // Kenarlık
              ),
              onChanged: (query) {
                completedTasksController
                    .searchTasks(query); // Arama sorgusunu güncelle
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (completedTasksController.tasks.isEmpty) {
                return Center(
                    child: Text(
                        'Tamamlanmış görev yok.')); // Görev yoksa mesaj göster
              }
              return ListView.builder(
                itemCount: completedTasksController.filteredTasks.length,
                itemBuilder: (context, index) {
                  var task = completedTasksController.filteredTasks[index];
                  return ListTile(
                    title: Text(task['title']), // Görev başlığı
                    subtitle: Text(
                      task['created_at']?.toDate().toString() ??
                          '', // Görev oluşturulma tarihi
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
