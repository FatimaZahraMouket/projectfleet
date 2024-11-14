import 'package:flutter/material.dart';
import 'package:projectfleet/models/task.model.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        title: Text(
          task.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              color: Color.fromARGB(255, 227, 226, 226),
              thickness: 2,
            ),
            Row(
              children: [
                const Icon(Icons.calendar_today, color: Color(0xFF378CE7)),
                const SizedBox(width: 5),
                Text(
                  '${task.date.toLocal()}'.split(' ')[0],
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            Text(
              task.description,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        trailing: Icon(
          task.status == 'en cours'
              ? Icons.hourglass_empty
              : task.status == 'terminée'
                  ? Icons.check_circle
                  : Icons.archive,
          color: task.status == 'en cours'
              ? Colors.orange
              : task.status == 'terminée'
                  ? Colors.green
                  : Colors.grey,
        ),
      ),
    );
  }
}
