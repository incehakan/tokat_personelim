import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../product/constants/endpoints.dart';
import '../../../product/config/app_env.dart';
import '../../../product/exceptions/server_exception.dart';
import '../models/login_response_model.dart';
import '../models/service_error_model.dart';
import 'cache_repository.dart';

class TokenRepository {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: Endpoints.baseUrl,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    ),
  );

  Future<Either<ServerException, void>> login(String username, String password) async {
    if (AppEnv.useMock) {
      CacheRepository.setToken('mock_access_token', 'mock_refresh_token');
      return const Right(null);
    }
    try {
      final response = await dio.post(
        Endpoints.baseUrl + Endpoints.token,
        data: {
          'username': username,
          'password': password,
          'grant_type': 'password',
        },
      );
      final data = LoginResponseModel.fromJson(response.data);
      CacheRepository.setToken(
        data.accessToken,
        data.refreshToken,
      );
      return const Right(null);
    } on DioException catch (err) {
      final errorData = ServiceErrorModel.fromJson(err.response?.data);
      return Left(
        ServerException(
          errorData.errorDescription.toString(),
        ),
      );
    }
  }
}
