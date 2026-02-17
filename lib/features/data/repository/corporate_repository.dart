import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geolocator/geolocator.dart';

import '../../../product/constants/app_strings.dart';
import '../../../product/constants/endpoints.dart';
import '../../../product/exceptions/server_exception.dart';
import '../../../product/utils/network_manager.dart';
import '../models/accident_report_model.dart';
import '../models/change_password_response_model.dart';
import '../models/fixture_model.dart';
import '../models/fixture_unit_model.dart';
import '../models/food_model.dart';
import '../models/movable_count_model.dart';
import '../models/movable_model.dart';
import '../models/movable_response_model.dart';
import '../models/phone_book_model.dart';
import '../models/service_model.dart';

class CorporateRepository {
  final NetworkManager networkManager;

  CorporateRepository(this.networkManager);

  Future<Either<ServerException, List<PhoneBook>>> fetchPhoneBook() async {
    try {
      final response = await networkManager.get(
        Endpoints.phoneBooks,
        queryParameters: {
          "page": 1.toString(),
        },
      );
      final data = PhoneBookModel.fromJson(response.data);
      if (data.phones != null && data.phones!.isNotEmpty) {
        return Right(data.phones!);
      } else {
        return Left(
          ServerException(data.message.toString()),
        );
      }
    } on DioException catch (err) {
      return Left(
        ServerException(
          err.response!.statusMessage.toString(),
        ),
      );
    }
  }

  Future<Either<ServerException, List<FoodData>>> fetchFoodList(String month, String type) async {
    try {
      final response = await networkManager.get(
        Endpoints.foodList,
        queryParameters: {
          "tarih": "-1",
          "ay": month,
          "menuTip": type,
        },
      );
      final data = FoodModel.fromJson(response.data);
      if (data.datas != null && data.datas!.isNotEmpty && data.datas!.first.details != null && data.datas!.first.details!.isNotEmpty) {
        return Right(data.datas!);
      } else {
        return Left(
          ServerException(
            AppStrings.notFoundFoodList,
          ),
        );
      }
    } on DioException catch (err) {
      return Left(
        ServerException(
          err.response!.statusMessage.toString(),
        ),
      );
    }
  }

  Future<Either<ServerException, Fixture>> queryWithBarcode(String barcode) async {
    final url = '${Endpoints.baseUrl}${Endpoints.queryWithBarcode}/$barcode';
    try {
      final response = await networkManager.get(url);
      final data = FixtureModel.fromJson(response.data);
      if (data.fixture != null) {
        return Right(data.fixture!);
      } else {
        return Left(
          ServerException(data.message.toString()),
        );
      }
    } on DioException catch (err) {
      return Left(
        ServerException(
          err.response!.statusMessage.toString(),
        ),
      );
    }
  }

  Future<Either<ServerException, Fixture>> queryWithSerialNo(String barcode) async {
    final url = '${Endpoints.baseUrl}${Endpoints.queryWithSerialNo}/$barcode';
    try {
      final response = await networkManager.get(url);
      final data = FixtureModel.fromJson(response.data);
      if (data.fixture != null) {
        return Right(data.fixture!);
      } else {
        return Left(
          ServerException(data.message.toString()),
        );
      }
    } on DioException catch (err) {
      return Left(
        ServerException(
          err.response!.statusMessage.toString(),
        ),
      );
    }
  }

  Future<Either<ServerException, List<FixtureUnit>>> fetchFixtureUnits() async {
    try {
      final response = await networkManager.get(Endpoints.fixtureUnit);
      final data = FixtureUnitModel.fromJson(response.data);
      if (data.units != null) {
        return Right(data.units!);
      } else {
        return Left(ServerException(data.message.toString()));
      }
    } on DioException catch (err) {
      return Left(
        ServerException(
          err.response!.statusMessage.toString(),
        ),
      );
    }
  }

  Future<Either<ServerException, Fixture>> queryWithFixture(String unitId, String fixtureNo) async {
    final url = '${Endpoints.baseUrl}${Endpoints.queryWithSerialNo}/$unitId/$fixtureNo';

    try {
      final response = await networkManager.get(url);
      final data = FixtureModel.fromJson(response.data);
      if (data.fixture != null) {
        return Right(data.fixture!);
      } else {
        return Left(
          ServerException(data.message.toString()),
        );
      }
    } on DioException catch (err) {
      return Left(
        ServerException(
          err.response!.statusMessage.toString(),
        ),
      );
    }
  }

  Future<Either<ServerException, List<ServiceData>>> fetchServices(String unitId) async {
    try {
      final response = await networkManager.get(
        '${Endpoints.services}/$unitId',
      );
      final data = ServiceModel.fromJson(response.data);
      if (data.services != null) {
        return Right(data.services!);
      } else {
        return Left(
          ServerException(data.sonucMesaj.toString()),
        );
      }
    } on DioException catch (err) {
      return Left(
        ServerException(
          err.response!.statusMessage.toString(),
        ),
      );
    }
  }

  Future<Either<ServerException, List<ServiceData>>> fetchRooms(String serviceId) async {
    try {
      final response = await networkManager.get(
        '${Endpoints.rooms}/$serviceId',
      );
      final data = ServiceModel.fromJson(response.data);
      if (data.services != null) {
        return Right(data.services!);
      } else {
        return Left(
          ServerException(data.sonucMesaj.toString()),
        );
      }
    } on DioException catch (err) {
      return Left(
        ServerException(
          err.response!.statusMessage.toString(),
        ),
      );
    }
  }

  Future<Either<ServerException, List<MovableData>>> fetchMovables(String query) async {
    try {
      final response = await networkManager.get(
        Endpoints.movable,
        queryParameters: {
          "tasinirAdi": query,
        },
      );
      final data = MovableModel.fromJson(response.data);
      return Right(data.data!);
    } on DioException catch (err) {
      return Left(
        ServerException(
          err.response!.statusMessage.toString(),
        ),
      );
    }
  }

  Future<Either<ServerException, String>> addMovable({
    required String name,
    required String unitId,
    required String fixtureNo,
    required String fixtureEkNo,
    required String roomId,
    required String tifDetailId,
    required String fixtureCodeId,
    required String comment,
  }) async {
    try {
      final response = await networkManager.post(
        Endpoints.addMovable,
        data: {
          "ADI": name,
          "AMBAR_ID": unitId,
          "KURUMSAL_ID": "",
          "DEMIRBAS_NO": fixtureNo,
          "DEMIRBAS_EK_NO": fixtureEkNo,
          "ODA_ID": roomId,
          "TIF_DETAY_ID": tifDetailId,
          "TASINIR_KODLARI_ID": fixtureCodeId,
          "ACIKLAMA": comment
        },
      );
      final data = MovableResponseModel.fromJson(response.data);
      if (data.data != null) {
        return Right(data.sonucMesaj.toString());
      } else {
        return Left(ServerException(data.sonucMesaj.toString()));
      }
    } on DioException catch (err) {
      return Left(
        ServerException(
          err.response!.statusMessage.toString(),
        ),
      );
    }
  }

  Future<Either<ServerException, MovableCountModelData>> fetchAddedMovables(String unitId) async {
    try {
      final response = await networkManager.get(
        '${Endpoints.movableCounts}/$unitId',
      );
      final data = MovableCountModel.fromJson(response.data);
      if (data.sonucKod == 0) {
        return Left(
          ServerException(data.sonucMesaj.toString()),
        );
      } else {
        if (data.data != null) {
          return Right(data.data!);
        } else {
          return Left(ServerException(data.sonucMesaj.toString()));
        }
      }
    } on DioException catch (err) {
      return Left(
        ServerException(
          err.response!.statusMessage.toString(),
        ),
      );
    }
  }

  Future<Either<ServerException, void>> deleteFixture(String id) async {
    try {
      final url = '${Endpoints.addMovable}/$id';
      await networkManager.delete(url);
      return const Right(null);
    } on DioException catch (err) {
      return Left(
        ServerException(
          err.response!.statusMessage.toString(),
        ),
      );
    }
  }

  Future<Either<ServerException, List<AccidentReport>>> fetchAccidentReports() async {
    try {
      final response = await networkManager.get(Endpoints.accidentReports);
      final data = AccidentReportModel.fromJson(response.data);
      if (data.reports != null && data.reports!.isNotEmpty) {
        return Right(data.reports!);
      } else {
        return Left(ServerException('Form bulunamadı'));
      }
    } on DioException catch (err) {
      return Left(
        ServerException(
          err.response!.statusMessage.toString(),
        ),
      );
    }
  }

  Future<Either<ServerException, String>> newAccidentReport({
    List<PlatformFile>? files,
    required DateTime date,
    required String comment,
    required Position location,
  }) async {
    try {
      String? base64str = files != null && files.isNotEmpty ? base64Encode(files.first.bytes!) : "";
      final response = await networkManager.post(
        Endpoints.newAccident,
        data: {
          "ID": 0,
          "OLAY_YERI": location.toString(),
          "OLAY_TARIHI": date.toString(),
          "ACIKLAMA": comment,
          "OLAY_LATITUDE": location.latitude.toString(),
          "OLAY_LONGITUDE": location.latitude.toString(),
          "OLAY_RESIM": base64str,
        },
      );
      final data = ChangePasswordResponseModel.fromJson(response.data);
      if (data.kod != -1) {
        return const Right('İşlem başarılı');
      } else {
        return Left(ServerException(data.mesaj.toString()));
      }
    } on DioException catch (err) {
      return Left(
        ServerException(
          err.response!.statusMessage.toString(),
        ),
      );
    }
  }
}
