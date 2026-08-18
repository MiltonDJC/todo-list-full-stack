import 'package:todo_list_fullstack/features/tasks/data/datasource/tasks_remote_datasource.dart';
import 'package:todo_list_fullstack/features/tasks/domain/entities/task.dart';
import 'package:todo_list_fullstack/features/tasks/domain/repositories/tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TasksRemoteDatasource tasksRemoteDatasource;

  TasksRepositoryImpl(this.tasksRemoteDatasource);

  @override
  Future<Task> getSpecificTask(int taskId) async {
    final getSpecificTaskLikeTaskModel = await tasksRemoteDatasource
        .getSpecificTask(taskId);

    return Task(
      id: getSpecificTaskLikeTaskModel.id,
      title: getSpecificTaskLikeTaskModel.title,
      completed: getSpecificTaskLikeTaskModel.completed,
    );
  }

  @override
  Future<List<Task>> getTasks() async {
    // implement getTasks
    final models = await tasksRemoteDatasource.getTasks();

    return models
        .map(
          (model) => Task(
            id: model.id,
            title: model.title,
            completed: model.completed,
          ),
        )
        .toList();
  }

  @override
  Future<Task> createTask(String taskTitle) async {
    final createdTaskLikeTaskModel = await tasksRemoteDatasource.createTask(
      taskTitle,
    );

    return Task(
      id: createdTaskLikeTaskModel.id,
      title: createdTaskLikeTaskModel.title,
      completed: createdTaskLikeTaskModel.completed,
    );
  }

  @override
  Future<Task> updateTask(int taskId, String? taskTitle) async {
    final updatedTaskLikeTaskModel = await tasksRemoteDatasource.updateTask(
      taskId,
      taskTitle,
    );

    return Task(
      id: updatedTaskLikeTaskModel.id,
      title: updatedTaskLikeTaskModel.title,
      completed: updatedTaskLikeTaskModel.completed,
    );
  }

  @override
  Future deleteTasks() async => await tasksRemoteDatasource.deleteTasks();
}
