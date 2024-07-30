import 'package:flutter/material.dart';
import 'task_service.dart';

class UpdateTaskPage extends StatefulWidget {
  final String taskId; // Güncellenmek veya silinmek istenen görev ID'si
  final String initialTitle; // Başlangıçta görünen görev başlığı

  UpdateTaskPage({required this.taskId, required this.initialTitle});

  @override
  _UpdateTaskPageState createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  final _formKey =
      GlobalKey<FormState>(); // Form durumunu takip etmek için anahtar
  late TextEditingController _titleController; // Başlık kontrolörü
  final TaskService _taskService = TaskService(); // Görev işlemleri için servis

  @override
  void initState() {
    super.initState();
    // Başlangıç başlığı ile kontrolörü başlat
    _titleController = TextEditingController(text: widget.initialTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Görev Güncelle'), // Uygulama çubuğundaki başlık
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0), // Etrafına boşluk ekle
        child: Form(
          key: _formKey, // Form anahtarını ayarla
          child: Column(
            children: [
              TextFormField(
                controller: _titleController, // Başlık kontrolörü kullan
                decoration: InputDecoration(
                    labelText: 'Görev Başlığı'), // Başlık için etiket
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Görev başlığı boş olamaz'; // Boş başlık için hata mesajı
                  }
                  return null;
                },
              ),
              SizedBox(
                  height:
                      16.0), // Başlık ve Güncelle butonu arasına boşluk ekle
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Form geçerli mi kontrol et
                    await _taskService.updateTaskTitle(widget.taskId,
                        _titleController.text); // Görev başlığını güncelle
                    Navigator.pop(context); // Önceki sayfaya dön
                  }
                },
                child: Text('Güncelle'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await _taskService.deleteTask(widget.taskId); // Görevi sil
                  Navigator.pop(context); // Önceki sayfaya dön
                },
                child: Text('Sil'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .red, // Silme butonunun arka plan rengini kırmızı yap
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
