import 'package:dio/dio.dart';

import '../../features/data/repository/cache_repository.dart';
import '../../features/data/repository/token_repository.dart';
import '../config/app_env.dart';
import '../constants/endpoints.dart';
import '../router/app_router.dart';
import '../router/app_routes.dart';
import 'mock_api.dart';

class NetworkManager {
  final Dio dio;

  NetworkManager(this.dio) {
    _initializeDio();
  }

  void _initializeDio() {
    dio
      ..options.baseUrl = Endpoints.baseUrl
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            final token = CacheRepository.getAccessToken();
            options.headers = {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            };
            return handler.next(options);
          },
          onError: (e, handler) async {
            if (e.response?.statusCode == 401) {
              final tokenRepository = TokenRepository();

              final username = CacheRepository.getUsername();
              final password = CacheRepository.getPassword();

              if (username == null || password == null) {
                appRouter.pushReplacementNamed(AppRoutes.login);
                return handler.next(e);
              }

              final refreshResult = await tokenRepository.login(username, password);
              return refreshResult.fold(
                (_) async {
                  appRouter.pushReplacementNamed(AppRoutes.login);
                  return handler.next(e);
                },
                (_) async {
                  final token = CacheRepository.getAccessToken();
                  if (token != null) {
                    e.requestOptions.headers['Authorization'] = 'Bearer $token';
                    return handler.resolve(
                      await dio.fetch(e.requestOptions),
                    );
                  }
                  appRouter.pushReplacementNamed(AppRoutes.login);
                  return handler.next(e);
                },
              );
            }
            return handler.next(e);
          },
        ),
      )
      ..interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
      ))

      //  'Content-Type': 'application/json',
      ..options.headers['Content-Type'] = 'application/json';
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    if (AppEnv.useMock) {
      final mockResponse = MockApi.mockGet(path, queryParameters: queryParameters);
      if (mockResponse != null) {
        return mockResponse;
      }
    }
    try {
      final Response<dynamic> response = await dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    if (AppEnv.useMock) {
      final mockResponse = MockApi.mockPost(path, data: data);
      if (mockResponse != null) {
        return mockResponse;
      }
    }
    try {
      final Response<dynamic> response = await dio.post(
        path,
        data: data,
      );
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<Response> delete(String path) async {
    try {
      final Response<dynamic> response = await dio.delete(
        path,
      );
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }
}
