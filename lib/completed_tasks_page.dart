import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'completed_tasks_controller.dart';

class CompletedTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CompletedTasksController completedTasksController =
        Get.put(CompletedTasksController());
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Tamamlanmış Görevler'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Ara',
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                completedTasksController.searchTasks(query);
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (completedTasksController.tasks.isEmpty) {
                return Center(child: Text('Tamamlanmış görev yok.'));
              }
              return ListView.builder(
                itemCount: completedTasksController.filteredTasks.length,
                itemBuilder: (context, index) {
                  var task = completedTasksController.filteredTasks[index];
                  return ListTile(
                    title: Text(task['title']),
                    subtitle: Text(
                      task['created_at']?.toDate().toString() ?? '',
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
