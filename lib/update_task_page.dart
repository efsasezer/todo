import 'package:flutter/material.dart';
import 'task_service.dart';

class UpdateTaskPage extends StatefulWidget {
  final String taskId;
  final String initialTitle;

  UpdateTaskPage({required this.taskId, required this.initialTitle});

  @override
  _UpdateTaskPageState createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  final TaskService _taskService = TaskService();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Görev Güncelle'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Görev Başlığı'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Görev başlığı boş olamaz';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _taskService.updateTaskTitle(
                        widget.taskId, _titleController.text);
                    Navigator.pop(context);
                  }
                },
                child: Text('Güncelle'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await _taskService.deleteTask(widget.taskId);
                  Navigator.pop(context);
                },
                child: Text('Sil'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
