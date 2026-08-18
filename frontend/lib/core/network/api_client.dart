import 'package:dio/dio.dart';
import 'package:todo_list_fullstack/core/constants/api_constants.dart';

class ApiClient {
  final Dio dio;

  ApiClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          // Tiempo de espera para establecer la conexión con el servidor
          connectTimeout: const Duration(seconds: 5),
          // Tiempo de espera para recibir respuestas del servidor
          receiveTimeout: const Duration(seconds: 5),
        ),
      );
}
