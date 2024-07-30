import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/home_page.dart';
import 'package:todo/login.dart';
import 'package:todo/register_page.dart';
import 'package:todo/update_task_page.dart';
import 'auth_service.dart';
import 'task_service.dart';
import 'task_model.dart';
import 'add_task_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase'i başlat
  await GetStorage.init(); // GetStorage'i başlat
  runApp(MyApp()); // Uygulamayı başlat
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, // Debug banner'ı gizle
      title: 'Todo App',
      theme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(
          primary: Colors.blue,
          onPrimary: Colors.white,
          secondary: Colors.blueAccent,
          onSecondary: Colors.black,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
          ),
        ),
      ),
      home: TodoApp(), // Ana uygulama widget'ı
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final TaskService _taskService = TaskService(); // Task işlemleri için servis
  final AuthService _authService =
      AuthService(); // Yetkilendirme işlemleri için servis
  final String userId = 'Hjzdmauw1pc28l1JjR2zgJawHVC3'; // Kullanıcı ID'si
  String searchQuery = ""; // Arama sorgusu

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Todo App'),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await _authService.signOut(); // Kullanıcıyı çıkış yaptır
                Get.offAllNamed('/login'); // Giriş sayfasına yönlendir
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'Tamamlanmamış'), // İlk sekme
              Tab(text: 'Tamamlanmış'), // İkinci sekme
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildTaskList(false), // Tamamlanmamış görevler
            buildTaskList(true), // Tamamlanmış görevler
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => AddTaskPage(
                userId: userId)); // Görev ekleme sayfasına yönlendir
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget buildTaskList(bool completed) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Ara', // Arama kutusunun etiketi
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value; // Arama sorgusunu güncelle
              });
            },
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _taskService.getTasks(
                userId, completed, searchQuery), // Görevleri al
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child:
                        CircularProgressIndicator()); // Veri yoksa yükleniyor göstergesi
              }

              final tasks = snapshot.data!.docs
                  .map((doc) => Task.fromDocument(doc))
                  .toList();

              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    title: Text(task.title), // Görev başlığını göster
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: task.completed,
                          onChanged: (value) {
                            _taskService.updateTask(
                                task.id, value!); // Görevi güncelle
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Get.to(() => UpdateTaskPage(
                                  taskId: task.id,
                                  initialTitle: task.title,
                                )); // Görev düzenleme sayfasına yönlendir
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await _taskService
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
      ],
    );
  }
}
