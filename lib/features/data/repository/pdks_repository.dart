import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../product/constants/endpoints.dart';
import '../../../product/exceptions/server_exception.dart';
import '../../../product/utils/network_manager.dart';
import '../models/confirmation_document_model.dart';
import '../models/device_location_model.dart';
import '../models/last_entrance_model.dart';
import '../models/pdks_device_model.dart';
import '../models/pdks_duty_model.dart';
import '../models/pdks_entrance_model.dart';
import '../models/pdks_information_model.dart';

class PdksRepository {
  final NetworkManager networkManager;

  PdksRepository(this.networkManager);

  Future<Either<ServerException, List<LastEntrance>>> fetchLastEntrance() async {
    try {
      final response = await networkManager.post(Endpoints.lastEntrance);
      final data = LastEntranceModel.fromJson(response.data);
      return Right(data.lastEntrance!);
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }

  Future<Either<ServerException, ConfirmationDocument?>> fetchConfirmationDocument() async {
    try {
      final response = await networkManager.get(Endpoints.confirmationDocument);
      final data = ConfirmationDocumentModel.fromJson(response.data);
      final document = data.data;
      return Right(document);
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }

  Future<Either<ServerException, void>> confirmDocument(String documentId) async {
    try {
      await networkManager.post(
        Endpoints.confirmDocument,
        data: {
          "BELGE_ID": documentId,
        },
      );
      return const Right(null);
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }

  Future<Either<ServerException, AvailableDeviceLocationResponse>> fetchPdksDeviceLocations(double lat, double lng) async {
    try {
      final response = await networkManager.post(
        Endpoints.pdksLocations,
        data: {
          "KOORDINAT_X": lat.toString(),
          "KOORDINAT_Y": lng.toString(),
        },
      );
      final data = AvailableDeviceLocationResponse.fromJson(response.data);
      return Right(data);
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }

  Future<Either<ServerException, String>> pdksEntranceOperation(
    String entranceType,
    String deviceId,
  ) async {
    try {
      final response = await networkManager.post(
        Endpoints.pdksOperation,
        data: {
          "TARIH": "2022-02-01T08:37:39.437Z",
          "GIRIS": entranceType,
          "ACIKLAMA": "İBB-Mobil PDKS",
          "CIHAZ_ID": deviceId,
          "FOTOGRAF": "string"
        },
      );
      final data = PdksEntranceModel.fromJson(response.data);
      if (data.sonucKod == 0) {
        return const Right('İşlem Başarılı');
      } else {
        return Left(
          ServerException(data.sonucMesaj.toString()),
        );
      }
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }

  Future<Either<ServerException, PdksDutyModel>> fetchPdksDuties() async {
    try {
      final response = await networkManager.post(Endpoints.pdksDutyLocation);
      final data = PdksDutyModel.fromJson(response.data);
      // final mockData = PdksDutyModel(
      //   code: 0,
      //   message: 'Başarılı',
      //   duties: [
      //     PdksDuty(
      //       id: 03,
      //       baslamaTarihi: DateTime.now(),
      //       bitisTarihi: DateTime.now().add(Duration(days: 2)),
      //       basKoordinatX: 38.4733.toString(),
      //       basKoordinatY: 32.3436.toString(),
      //       bitKoordinatX: 38.473033.toString(),
      //       bitKoordinatY: 32.3336.toString(),
      //     ),
      //   ],
      // );
      // return Right(mockData);
      if (data.code == -1) {
        return Left(
          ServerException(data.message.toString()),
        );
      } else {
        return Right(data);
      }
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }

  Future<Either<ServerException, List<PdksInformation>>> fetchPdksInformations(
    String startDate,
    String endDate,
  ) async {
    try {
      final response = await networkManager.get(
        Endpoints.pdksInformations,
        queryParameters: {
          "baslangicTarihi": startDate,
          "bitisTarihi": endDate,
        },
      );
      final data = PdksInformationModel.fromJson(response.data);
      if (data.informations != null && data.informations!.isNotEmpty) {
        return Right(data.informations!);
      } else {
        return Left(
          ServerException('Girmiş olduğunuz tarih aralığında PDKS işlemi bulunamadı.'),
        );
      }
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }

  Future<Either<ServerException, List<PdksDevice>>> fetchNearbyDevices(LatLng position) async {
    try {
      final response = await networkManager.post(
        Endpoints.pdksNearbyDevices,
        data: {
          "KOORDINAT_X": position.latitude.toString(),
          "KOORDINAT_Y": position.longitude.toString(),
        },
      );
      final data = PdksDeviceModel.fromJson(response.data);
      // return Right([
      //   PdksDevice(
      //     adi: 'Konak',
      //     koordinatX: 38.423733.toString(),
      //     koordinatY: 27.3433.toString(),
      //   ),
      //   PdksDevice(
      //     adi: 'Konak',
      //     koordinatX: 38.423733.toString(),
      //     koordinatY: 27.3433.toString(),
      //   ),
      // ]);
      if (data.devices != null && data.devices!.isNotEmpty) {
        return Right(data.devices!);
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
