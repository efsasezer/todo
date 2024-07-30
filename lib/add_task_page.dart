import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_task_controller.dart';

class AddTaskPage extends StatelessWidget {
  final String userId;

  AddTaskPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    final AddTaskController addTaskController = Get.put(AddTaskController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Yeni Görev Ekle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: addTaskController.formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: addTaskController.titleController,
                decoration: InputDecoration(labelText: 'Görev Başlığı'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen görev başlığını girin';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => addTaskController.addTask(userId),
                child: Text('Ekle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
