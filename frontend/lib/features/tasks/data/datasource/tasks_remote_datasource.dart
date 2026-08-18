import 'package:todo_list_fullstack/core/network/api_client.dart';
import 'package:todo_list_fullstack/features/tasks/data/models/task_model.dart';

class TasksRemoteDatasource {
  final ApiClient apiClient;

  TasksRemoteDatasource(this.apiClient);

  Future<TaskModel> getSpecificTask(int taskId) async {
    final response = await apiClient.dio.get('/tasks/$taskId');
    return TaskModel.fromJson(response.data);
  }

  Future<List<TaskModel>> getTasks() async {
    final response = await apiClient.dio.get('/tasks/');

    final List data = response.data;

    return data.map((json) => TaskModel.fromJson(json)).toList();
  }

  Future<TaskModel> createTask(String taskTitle) async {
    final response = await apiClient.dio.post(
      '/tasks/',
      data: {'title': taskTitle},
    );

    final Map<String, dynamic> json = response.data;

    return TaskModel.fromJson(json);
  }

  Future<TaskModel> updateTask(int taskId, String? taskTitle) async {
    final response = await apiClient.dio.put(
      '/tasks/$taskId',
      data: {"title": taskTitle},
    );

    final Map<String, dynamic> json = response.data;

    return TaskModel.fromJson(json);
  }

  Future deleteTasks() async => await apiClient.dio.delete('/tasks/');
}
