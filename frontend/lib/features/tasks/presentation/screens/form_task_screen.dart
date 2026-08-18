import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_fullstack/features/tasks/domain/entities/task.dart';
import 'package:todo_list_fullstack/features/tasks/presentation/providers/tasks_providers.dart';
import 'package:todo_list_fullstack/features/tasks/presentation/screens/task_list_screen.dart';

class FormTaskScreen extends ConsumerStatefulWidget {
  const FormTaskScreen({super.key, this.task});

  final Task? task;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FormTaskScreenState();
}

class _FormTaskScreenState extends ConsumerState<FormTaskScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: Text(
            widget.task == null ? 'Crear tarea' : 'Actualizar tarea',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          elevation: 0,
          scrolledUnderElevation: 10,
          backgroundColor: Colors.blueGrey,
          shadowColor: Colors.blueGrey.shade900,
          // scrolledUnderElevation: 10,
        ),
        body: Center(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: _controller,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: widget.task == null
                          ? 'Nueva tarea:'
                          : 'Tarea anterior: ${widget.task!.title}',
                      labelStyle: TextStyle(fontSize: 24),
                    ),
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (widget.task == null) {
                      await ref
                          .read(tasksRepositoryProvider)
                          .createTask(_controller.value.text);
                      ref.invalidate(tasksProvider);
                    } else {
                      final taskToUpdate = ref
                          .watch(tasksProvider)
                          .value!
                          .firstWhere((task) => task.id == widget.task!.id);

                      await ref
                          .read(tasksRepositoryProvider)
                          .updateTask(taskToUpdate.id, _controller.value.text);
                      ref.invalidate(tasksProvider);
                    }

                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TaskListScreen()),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      widget.task == null ? 'Crear' : 'Actualizar',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
