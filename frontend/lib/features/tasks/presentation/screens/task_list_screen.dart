import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_fullstack/features/tasks/domain/entities/task.dart';
import 'package:todo_list_fullstack/features/tasks/presentation/providers/tasks_providers.dart';
import 'package:todo_list_fullstack/features/tasks/presentation/screens/form_task_screen.dart';
import 'package:todo_list_fullstack/features/tasks/presentation/screens/specific_task_screen.dart';
import 'package:todo_list_fullstack/features/tasks/presentation/widgets/task_tile.dart';

class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(tasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tasks',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        elevation: 0,
        scrolledUnderElevation: 10,
        backgroundColor: Colors.blueGrey,
        shadowColor: Colors.blueGrey.shade900,
        // scrolledUnderElevation: 10,
      ),
      body: tasksAsync.when(
        loading: () => const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                strokeAlign: 5,
                strokeWidth: 5,
                padding: EdgeInsets.only(bottom: 50),
              ),
              Text('Cargando tareas...', style: TextStyle(fontSize: 24)),
            ],
          ),
        ),
        error: (error, stackTrace) {
          print('Error: $error');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No se pudieron cargar las tareas',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 10),
                Icon(Icons.error_outline, size: 40),
              ],
            ),
          );
        },
        data: (tasks) => ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            Task task = tasks[index];
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SpecificTaskScreen(taskId: tasks[index].id),
                ),
              ),
              child: Card.outlined(
                child: TaskTile(
                  id: task.id,
                  title: task.title,
                  completed: task.completed,
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'navigateToFormTaskScreen',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FormTaskScreen()),
            ),
            child: Icon(Icons.add),
          ),

          SizedBox(height: 10),

          FloatingActionButton(
            heroTag: 'deleteTask',
            onPressed: () async {
              await ref.read(tasksRepositoryProvider).deleteTasks();
              ref.invalidate(tasksProvider);
            },
            child: Icon(Icons.delete),
          ),

          SizedBox(height: 10),

          FloatingActionButton(
            heroTag: 'refreshTasks',
            onPressed: () => ref.invalidate(tasksProvider),
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
