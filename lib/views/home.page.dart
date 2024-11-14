import 'package:flutter/material.dart';
import 'package:projectfleet/models/task.model.dart';
import 'package:projectfleet/widgets/add_task_form.dart';
import 'package:projectfleet/widgets/task_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.userName});
  final String userName; // Nom de l'utilisateur connecté

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _taskTabController;

  List<Task> ongoingTasks = [
    Task(
      title: 'Tâche one',
      description: 'Description de la tâche 1',
      date: DateTime.now(),
      status: 'en cours',
    ),
    Task(
      title: 'Tâche two',
      description: 'Description de la tâche 2',
      date: DateTime.now().add(const Duration(days: 1)),
      status: 'en cours',
    ),
  ];

  List<Task> completedTasks = [
    Task(
      title: 'Tâche 3 ',
      description: 'Description de la tâche 1',
      date: DateTime.now(),
      status: 'terminée',
    ),
    Task(
      title: 'Tâche 4 ',
      description: 'Description de la tâche 2',
      date: DateTime.now().add(const Duration(days: 1)),
      status: 'terminée',
    ),
  ];

  List<Task> archivedTasks = [
    Task(
      title: 'Tâche 5',
      description: 'Description de la tâche 2',
      date: DateTime.now().add(const Duration(days: 1)),
      status: 'archivée',
    ),
    Task(
      title: 'Tâche 6',
      description: 'Description de la tâche 2',
      date: DateTime.now().add(const Duration(days: 1)),
      status: 'archivée',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _taskTabController = TabController(length: 3, vsync: this);

    _taskTabController.addListener(() {
      setState(() {});
    });
  }

  void _addTask(Task newTask) {
    setState(() {
      ongoingTasks.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF378CE7),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Icon(Icons.person, color: Colors.blueAccent), // Remplacer par une image de profil
            ),
            const SizedBox(width: 10),
            Text(
              'Hello, ${widget.userName}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Tâches',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${DateTime.now()}'.split(' ')[0],
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      builder: (context) {
                        return AddTaskForm(onTaskAdded: _addTask);
                      },
                    );
                  },
                  icon: const Icon(Icons.add, color: Colors.blue),
                  label: const Text(
                    'New tâche',
                    style: TextStyle(color: Colors.blue),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC6E7FF),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _taskTabButton('Open', 0),
                _taskTabButton('Done', 1),
                _taskTabButton('Archived', 2),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _taskTabController,
              children: [
                ListView.builder(
                  itemCount: ongoingTasks.length,
                  itemBuilder: (context, index) {
                    var task = ongoingTasks[index];
                    return TaskCard(task: task);
                  },
                ),
                ListView.builder(
                  itemCount: completedTasks.length,
                  itemBuilder: (context, index) {
                    var task = completedTasks[index];
                    return TaskCard(task: task);
                  },
                ),
                ListView.builder(
                  itemCount: archivedTasks.length,
                  itemBuilder: (context, index) {
                    var task = archivedTasks[index];
                    return TaskCard(task: task);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _taskTabButton(String label, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ElevatedButton(
        onPressed: () {
          _taskTabController.animateTo(index);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _taskTabController.index == index
              ? const Color.fromARGB(255, 155, 197, 242)
              : const Color.fromARGB(255, 255, 253, 253),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: _taskTabController.index == index ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
