import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_fullstack/features/tasks/domain/entities/task.dart';
import 'package:todo_list_fullstack/features/tasks/presentation/providers/tasks_providers.dart';
import 'package:todo_list_fullstack/features/tasks/presentation/screens/form_task_screen.dart';

class SpecificTaskScreen extends ConsumerWidget {
  const SpecificTaskScreen({super.key, required this.taskId});

  final int taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider).value;

    Task? task = (tasks!.isNotEmpty)
        ? tasks.firstWhere((specificTask) => specificTask.id == taskId)
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Specific Task',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        elevation: 0,
        scrolledUnderElevation: 10,
        backgroundColor: Colors.blueGrey,
        shadowColor: Colors.blueGrey.shade900,
        // scrolledUnderElevation: 10,
      ),
      body: Center(
        child: task != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ID: ${task.id}'),
                  Text('Titulo ${task.title}'),
                  Text(
                    'Estado: ${task.completed ? 'Completada' : 'Incompleta'}',
                  ),
                ],
              )
            : null,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => FormTaskScreen(task: task)),
        ),
        child: Icon(Icons.edit),
      ),
    );
  }
}
