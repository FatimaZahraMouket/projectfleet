import 'package:flutter/material.dart';
import 'package:projectfleet/models/task.model.dart';

class AddTaskForm extends StatefulWidget {
  final Function(Task) onTaskAdded; // Fonction pour ajouter une tâche

  const AddTaskForm({super.key, required this.onTaskAdded});

  @override
  _AddTaskFormState createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 62, 65, 75),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Ajouter une tâche",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF378CE7),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Titre',
              prefixIcon: const Icon(Icons.title, color: Color(0xFF378CE7)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Color(0xFF378CE7)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _designationController,
            decoration: InputDecoration(
              labelText: 'Désignation',
              prefixIcon: const Icon(Icons.description, color: Color(0xFF378CE7)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Color(0xFF378CE7)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _commentController,
            maxLines: 1,
            decoration: InputDecoration(
              labelText: 'Commentaire',
              prefixIcon: const Icon(Icons.comment, color: Color(0xFF378CE7)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Color(0xFF378CE7)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _dateController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Date',
              prefixIcon: const Icon(Icons.calendar_today, color: Color(0xFF378CE7)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Color(0xFF378CE7)),
              ),
              hintText: _selectedDate == null
                  ? 'Sélectionner une date'
                  : 'Date: ${_selectedDate!.toLocal()}'.split(' ')[0],
            ),
            onTap: _pickDate,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _addTask,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF378CE7),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text('Ajouter', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  void _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = '${_selectedDate!.toLocal()}'.split(' ')[0];
      });
    }
  }

  void _addTask() {
    if (_titleController.text.isNotEmpty &&
        _designationController.text.isNotEmpty &&
        _selectedDate != null) {
      Task newTask = Task(
        title: _titleController.text,
        description: _designationController.text,
        date: _selectedDate!,
        status: 'en cours',
      );
      widget.onTaskAdded(newTask); 
      Navigator.pop(context); 
    }
  }
}
