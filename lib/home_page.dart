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
              await homeController.signOut(); // Kullanıcıyı çıkış yapar
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
                !homeController
                    .showCompleted.value, // Tamamlanmamış görevleri göster
                homeController
                    .showCompleted.value // Tamamlanmış görevleri göster
              ],
              onPressed: (index) {
                homeController.showCompleted.value =
                    index == 1; // Seçilen sekmeye göre görevleri göster
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller:
                  homeController.searchController, // Arama giriş kontrolcüsü
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
                stream: homeController.getTasks(), // Görevleri dinleyen stream
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child:
                            CircularProgressIndicator()); // Veriler yükleniyorsa yüklenme göstergesi
                  }

                  var tasks = snapshot.data!.docs; // Görevleri al

                  return ListView.builder(
                    itemCount: tasks
                        .length, // Görev sayısına göre liste elemanı oluştur
                    itemBuilder: (context, index) {
                      var task = tasks[index];
                      return ListTile(
                        title: Text(task['title']), // Görev başlığını göster
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: task[
                                  'completed'], // Görevin tamamlanma durumunu göster
                              onChanged: (bool? value) {
                                if (value != null) {
                                  homeController.toggleTaskCompletion(task.id,
                                      value); // Görev tamamlanma durumunu güncelle
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
                                      taskId: task.id, // Görev ID'si
                                      initialTitle:
                                          task['title'], // Görev başlığı
                                    ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                await homeController
                                    .deleteTask(task.id); // Görevi sil
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
              builder: (context) => AddTaskPage(
                  userId: homeController.user?.uid ??
                      ''), // Yeni görev ekleme sayfasına yönlendir
            ),
          );
        },
        tooltip: 'Yeni Görev Ekle',
        child: Icon(Icons.add),
      ),
    );
  }
}
