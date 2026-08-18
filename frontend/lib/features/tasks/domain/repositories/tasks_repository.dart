import 'package:todo_list_fullstack/features/tasks/domain/entities/task.dart';

abstract class TasksRepository {
  Future<Task> getSpecificTask(int taskId);

  Future<List<Task>> getTasks();

  Future<Task> createTask(String taskTitle);

  Future<Task> updateTask(int taskId, String? taskTitle);

  // Future deleteTask(int taskId);

  Future deleteTasks();
}
