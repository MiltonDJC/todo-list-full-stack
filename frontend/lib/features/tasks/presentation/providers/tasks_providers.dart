import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_fullstack/core/network/api_client.dart';
import 'package:todo_list_fullstack/features/tasks/data/datasource/tasks_remote_datasource.dart';
import 'package:todo_list_fullstack/features/tasks/data/repositories/tasks_repository_impl.dart';
import 'package:todo_list_fullstack/features/tasks/domain/entities/task.dart';
import 'package:todo_list_fullstack/features/tasks/domain/repositories/tasks_repository.dart';

// Provider que sabe conectarse al backend
final apiClienteProvider = Provider((ref) => ApiClient());

// Provider que sabe hacer llamadas a endpoints específicos (getTasks del datasource.dart)
final tasksRemoteDatasourceProvider = Provider<TasksRemoteDatasource>(
  (ref) => TasksRemoteDatasource(ref.read(apiClienteProvider)),
);

// Provider que sabe obtener los datos del repository
final tasksRepositoryProvider = Provider<TasksRepository>(
  (ref) => TasksRepositoryImpl(ref.read(tasksRemoteDatasourceProvider)),
);

// Provider que entrega las tareas a la UI
final tasksProvider = FutureProvider<List<Task>>((ref) async {
  final repository = ref.read(tasksRepositoryProvider);
  return repository.getTasks();
});
