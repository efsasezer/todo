import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';
import 'add_task_page.dart';
import 'update_task_page.dart';

class HomePage extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ana Sayfa'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await homeController.signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(
            () => ToggleButtons(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Tamamlanmamış'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Tamamlanmış'),
                ),
              ],
              isSelected: [
                !homeController.showCompleted.value,
                homeController.showCompleted.value
              ],
              onPressed: (index) {
                homeController.showCompleted.value = index == 1;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: homeController.searchController,
              decoration: InputDecoration(
                labelText: 'Ara',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                homeController.searchQuery.value =
                    value; // Arama terimini güncelle
              },
            ),
          ),
          Expanded(
            child: Obx(
              () => StreamBuilder<QuerySnapshot>(
                stream: homeController.getTasks(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var tasks = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      var task = tasks[index];
                      return ListTile(
                        title: Text(task['title']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: task['completed'],
                              onChanged: (bool? value) {
                                if (value != null) {
                                  homeController.toggleTaskCompletion(
                                      task.id, value);
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateTaskPage(
                                      taskId: task.id,
                                      initialTitle: task['title'],
                                    ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                await homeController.deleteTask(task.id);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddTaskPage(userId: homeController.user?.uid ?? ''),
            ),
          );
        },
        tooltip: 'Yeni Görev Ekle',
        child: Icon(Icons.add),
      ),
    );
  }
}
