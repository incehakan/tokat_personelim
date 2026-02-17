import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../product/constants/endpoints.dart';
import '../../../product/exceptions/server_exception.dart';
import '../../../product/utils/network_manager.dart';
import '../models/change_password_response_model.dart';
import '../models/login_response_model.dart';
import '../models/otp_model.dart';
import '../models/service_error_model.dart';
import 'cache_repository.dart';

class AuthRepository {
  final Dio dio;
  final NetworkManager networkManager;

  AuthRepository(this.dio, this.networkManager) {
    dio.options.headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
      ),
    );
  }

  Future<Either<ServerException, void>> login(String username, String password) async {
    try {
      // var basicHeader = base64Encode(utf8.encode('$username:$password'));
      // dio.options.headers = {'Authorization': 'Basic $basicHeader'};
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
      String errorMessage = 'Giriş yapılırken bir hata oluştu';
      
      if (err.response?.data != null) {
        try {
          final errorData = ServiceErrorModel.fromJson(err.response!.data);
          if (errorData.errorDescription != null && errorData.errorDescription!.isNotEmpty) {
            errorMessage = errorData.errorDescription!;
          } else if (errorData.error != null) {
            errorMessage = errorData.error!;
          }
        } catch (e) {
          // JSON parse hatası durumunda response data'yı direkt kullan
          if (err.response!.data is Map) {
            final data = err.response!.data as Map;
            if (data.containsKey('error_description')) {
              errorMessage = data['error_description'].toString();
            } else if (data.containsKey('error')) {
              errorMessage = data['error'].toString();
            }
          } else if (err.response!.data is String) {
            errorMessage = err.response!.data.toString();
          }
        }
      } else if (err.message != null) {
        errorMessage = err.message!;
      }
      
      return Left(
        ServerException(errorMessage),
      );
    }
  }

  Future<Either<ServerException, String>> sendOtpCode() async {
    try {
      final response = await networkManager.post(Endpoints.otp);
      final data = OtpModel.fromJson(response.data);
      return Right(data.pkId!.toInt().toString());
    } on DioException catch (err) {
      return Left(
        ServerException(
          err.response!.data.toString(),
        ),
      );
    }
  }

  Future<void> refreshToken() async {
    try {
      final response = await dio.post(
        Endpoints.baseUrl + Endpoints.token,
        data: {
          "refresh_token": CacheRepository.getRefreshToken(),
          "grant_type": "refresh_token",
        },
      );
      final data = LoginResponseModel.fromJson(response.data);
      CacheRepository.setToken(
        data.accessToken,
        data.refreshToken,
      );
    } on DioException catch (_) {
      // final errorData = ServiceErrorModel.fromJson(err.response?.data);
    }
  }

  Future<Either<ServerException, void>> forgotPasswordCode(String username, String identity) async {
    try {
      final header = base64Encode(
        utf8.encode('$username:$identity'),
      );
      dio.options.headers = {
        "Authorization": 'Basic $header',
      };

      final response = await dio.post(
        Endpoints.notificationsUrl + Endpoints.forgotPasswordCode,
        data: {
          "KULLANICI_KODU": username,
          "TC_KIMLIK_NO": identity,
        },
      );
      final data = ChangePasswordResponseModel.fromJson(response.data);
      if (data.kod == 0) {
        return const Right(null);
      } else {
        return Left(ServerException(data.mesaj.toString()));
      }
    } on DioException catch (err) {
      return Left(
        ServerException(
          err.response!.data.toString(),
        ),
      );
    }
  }

  Future<Either<ServerException, String>> changePassword({
    required String identity,
    required String code,
    required String password,
    required String confirmPassword,
    required String username,
  }) async {
    try {
      final header = base64Encode(utf8.encode('$code:$password'));
      dio.options.headers = {
        "Authorization": 'Basic $header',
      };
      final response = await dio.post(
        Endpoints.notificationsUrl + Endpoints.changePassword,
        data: {
          "KULLANICI_KODU": username,
          "TC_KIMLIK_NO": identity,
          "ONAY_KODU": code,
          "SIFRE": password,
          "SIFRE_TEKRAR": confirmPassword,
        },
      );
      final data = ChangePasswordResponseModel.fromJson(response.data);
      if (data.kod == 0) {
        return const Right("Şifreniz başarıyla değiştirilmiştir");
      } else {
        return Left(ServerException(data.mesaj.toString()));
      }
    } on DioException catch (err) {
      return Left(
        ServerException(
          err.response!.data.toString(),
        ),
      );
    }
  }

  Future<Either<ServerException, String>> createUser(String identity) async {
    try {
      final response = await dio.post(
        Endpoints.notificationsUrl + Endpoints.createUser,
        data: {
          "TC_KIMLIK_NO": identity,
        },
      );

      final data = ChangePasswordResponseModel.fromJson(response.data);
      if (data.kod == 0) {
        return const Right("Kullanıcı oluşturma kodu telefonunuza gönderildi");
      } else {
        return Left(
          ServerException(data.mesaj.toString()),
        );
      }
    } on DioException catch (err) {
      return Left(
        ServerException(
          err.response!.data.toString(),
        ),
      );
    }
  }

  Future<Either<ServerException, String>> createUserConfirmRequest(String identity, String code) async {
    try {
      final response = await dio.post(
        Endpoints.notificationsUrl + Endpoints.createUserConfirm,
        data: {
          "TC_KIMLIK_NO": identity,
          "ONAY_KODU": code,
        },
      );
      final data = ChangePasswordResponseModel.fromJson(response.data);
      if (data.kod == 0) {
        return const Right(
          'Kullanıcı oluşturma talebiniz ilgili birime iletilmiştir.',
        );
      } else {
        return Left(
          ServerException('Kullanıcı oluşturma talebi iletilirken hata oluştu.'),
        );
      }
    } on DioException catch (err) {
      return Left(
        ServerException(
          err.response!.data.toString(),
        ),
      );
    }
  }
}
