import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../product/constants/endpoints.dart';
import '../../../product/exceptions/server_exception.dart';
import '../../../product/utils/network_manager.dart';
import '../models/leave.dart';
import '../models/subordinate_pdks_info_model.dart';
import '../models/subordinates_model.dart';
import '../models/user_info_model.dart';

class EmployeeRepository {
  final NetworkManager networkManager;

  EmployeeRepository(this.networkManager);

  Future<Either<ServerException, List<Subordinate>>> fetchSubordinates() async {
    try {
      final response = await networkManager.get(Endpoints.subordinates);
      final data = SubordinatesModel.fromJson(response.data);
      if (data.subordinates != null && data.subordinates!.isNotEmpty) {
        return Right(data.subordinates!);
      } else {
        return Left(ServerException(data.message.toString()));
      }
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }

  Future<Either<ServerException, UserInfo>> fetchSubordinateInfo(String registerNo) async {
    try {
      final resonse = await networkManager.get(
        Endpoints.subordinateInfo,
        queryParameters: {
          "sicilId": registerNo,
        },
      );
      final data = UserInfoModel.fromJson(resonse.data);
      if (data.userInfo != null) {
        return Right(data.userInfo!);
      } else {
        return Left(ServerException(data.sonucMesaj.toString()));
      }
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }

  //?sicilId=$sicilID
  Future<Either<ServerException, LeaveInfo>> fetchSubordinateLeaveInfo(String registerNo) async {
    try {
      final resonse = await networkManager.get(
        Endpoints.subordinateInfo,
        queryParameters: {
          "sicilId": registerNo,
        },
      );
      final data = LeaveModel.fromJson(resonse.data);
      if (data.leaveInfo != null) {
        return Right(data.leaveInfo!);
      } else {
        return Left(ServerException(data.message.toString()));
      }
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }

  Future<Either<ServerException, List<SubordinatePdksInfo>>> fetchSubordinatePdksInfo(String registerNo) async {
    try {
      final response = await networkManager.get(
        Endpoints.subordinatePdksInfo,
        queryParameters: {
          "sicilId": registerNo,
          "baslangicTarihi":
              '${DateTime.now().subtract(const Duration(days: 30)).day}.${DateTime.now().subtract(const Duration(days: 30)).month}.${DateTime.now().subtract(const Duration(days: 30)).year}',
          "bitisTarihi": '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}',
        },
      );
      final data = SubordinatePdksInfoModel.fromJson(response.data);
      if (data.pdksInfos != null && data.pdksInfos!.isNotEmpty) {
        return Right(data.pdksInfos!);
      } else {
        return Left(
          ServerException(data.message.toString()),
        );
      }
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }
}
