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
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
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
      home: TodoApp(),
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
  final TaskService _taskService = TaskService();
  final AuthService _authService = AuthService();
  final String userId = 'Hjzdmauw1pc28l1JjR2zgJawHVC3';
  String searchQuery = "";

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
                await _authService.signOut();
                Get.offAllNamed('/login');
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'Tamamlanmamış'),
              Tab(text: 'Tamamlanmış'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildTaskList(false),
            buildTaskList(true),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => AddTaskPage(userId: userId));
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
              labelText: 'Ara',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _taskService.getTasks(userId, completed, searchQuery),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              final tasks = snapshot.data!.docs
                  .map((doc) => Task.fromDocument(doc))
                  .toList();

              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    title: Text(task.title),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: task.completed,
                          onChanged: (value) {
                            _taskService.updateTask(task.id, value!);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Get.to(() => UpdateTaskPage(
                                  taskId: task.id,
                                  initialTitle: task.title,
                                ));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await _taskService.deleteTask(task.id);
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
