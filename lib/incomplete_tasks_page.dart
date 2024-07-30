import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'incomplete_tasks_controller.dart';

class IncompleteTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IncompleteTasksController incompleteTasksController =
        Get.put(IncompleteTasksController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Tamamlanmamış Görevler'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                incompleteTasksController.searchQuery.value = value;
              },
              decoration: InputDecoration(
                hintText: 'Görev ara...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (incompleteTasksController.tasks.isEmpty) {
          return Center(child: Text('Tamamlanmamış görev yok.'));
        }
        return ListView.builder(
          itemCount: incompleteTasksController.tasks.length,
          itemBuilder: (context, index) {
            var task = incompleteTasksController.tasks[index];
            return ListTile(
              title: Text(task['title']),
              subtitle: Text(
                task['created_at']?.toDate().toString() ?? '',
              ),
            );
          },
        );
      }),
    );
  }
}
