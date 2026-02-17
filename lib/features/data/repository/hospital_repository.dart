import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../product/constants/app_strings.dart';
import '../../../product/constants/endpoints.dart';
import '../../../product/exceptions/server_exception.dart';
import '../../../product/utils/network_manager.dart';
import '../models/appointment_model.dart';
import '../models/early_registration_model.dart';
import '../models/employee_relative_model.dart';
import '../models/hospital_token_model.dart';
import '../models/kiosk_model.dart';
import '../models/lab_result_detail_model.dart';
import '../models/lab_result_model.dart';
import '../models/pathology_result_detail_model.dart';
import '../models/pathology_result_model.dart';
import '../models/patient_acceptance_control_model.dart';
import '../models/patient_appointment_model.dart';
import '../models/patient_information_model.dart';
import '../models/service_acceptance_control_model.dart';
import '../models/view_result_model.dart';
import 'cache_repository.dart';

class HospitalRepository {
  final NetworkManager networkManager;
  final HospitalNetworkManager hospitalNetworkManager;
  final Dio dio;

  HospitalRepository(this.networkManager, this.dio, this.hospitalNetworkManager) {
    dio.options.headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      // ignore: prefer_interpolation_to_compose_strings
      'Authorization': 'Basic ' +
          base64Encode(
            utf8.encode('2CAD1598E407DD376AD8CEC8710661DF:'),
          )
    };
    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(InterceptorsWrapper(
      onError: (e, handler) {},
    ));
  }

  Future<Either<ServerException, void>> fetchHospitalToken() async {
    try {
      const path = Endpoints.hospitalUrl + Endpoints.token;

      final response = await dio.post(
        path,
        data: {
          'grant_type': 'password',
          'username': '2CAD1598E407DD376AD8CEC8710661DF',
          'password': '',
        },
      );
      final data = HospitalTokenModel.fromJson(response.data);
      CacheRepository.setHospitalToken(data.accessToken ?? "");
      return const Right(null);
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }

  Future<Either<ServerException, List<Relative>>> fetchEmployeeRelatives() async {
    try {
      final response = await networkManager.get(Endpoints.relatives);
      final data = EmployeeRelativeModel.fromJson(response.data);
      return Right(data.relatives!);
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }

  Future<Either<ServerException, PatientInformation>> fetchPatientInformation(String registryNo) async {
    try {
      final response = await hospitalNetworkManager.post(
        Endpoints.patientInformation,
        data: {
          'TC_KIMLIK_NO': registryNo,
        },
      );
      final data = PatientInformationModel.fromJson(response.data);
      if (data.code == "1") {
        final patientInfo = data.patientInformations!.first.table!.first;
        CacheRepository.setPatientNo(patientInfo.hastaNo.toString());
        return Right(patientInfo);
      } else {
        return Left(
          ServerException(AppStrings.generalErrorMessage),
        );
      }
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }

  Future<Either<ServerException, void>> fetchEarlyRegistration(String patientNo) async {
    try {
      final response = await hospitalNetworkManager.post(
        Endpoints.earlyRegistration,
        data: {
          "HASTA_NO": patientNo,
        },
      );
      final data = EarlyRegistrationModel.fromJson(response.data);
      if (data.code == "1") {
        return const Right(null);
      } else {
        return Left(ServerException(AppStrings.generalErrorMessage));
      }
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }

  Future<Either<ServerException, List<Kiosk>>> fetchKiosks() async {
    try {
      final response = await hospitalNetworkManager.post(
        Endpoints.kiosks,
        data: {
          'ISLEM_TARIHI': '',
        },
      );
      final data = KioskModel.fromJson(response.data);
      if (data.code == "1" && data.kioskList != null && data.kioskList!.isNotEmpty) {
        return Right(data.kioskList!.first.kiosks!);
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

  Future<Either<ServerException, ServiceAcceptanceControlModel>> serviceAcceptanceControl(
    String policlinicCode,
    String patientNo,
  ) async {
    try {
      final response = await hospitalNetworkManager.post(
        Endpoints.serviceAcceptanceControl,
        data: {
          "POL_KODU": policlinicCode,
          "HASTA_NO": patientNo,
          "ISLEM_TARIHI": "",
        },
      );
      final data = ServiceAcceptanceControlModel.fromJson(response.data);
      if (data.code == "0" || data.admissionResults!.first.table!.first.protokolNo != null) {
        return Left(ServerException(data.message.toString()));
      } else {
        return Right(data);
      }
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }

  Future<Either<ServerException, void>> patientAcceptanceControl(
    String policlinicCode,
    String patientNo,
  ) async {
    try {
      final response = await hospitalNetworkManager.post(
        Endpoints.patientAcceptanceControl,
        data: {
          "POL_KODU": policlinicCode,
          "HASTA_NO": patientNo,
          "ISLEM_TARIHI": "",
        },
      );
      final data = PatientAcceptanceControlModel.fromJson(response.data);
      if (data.code == "0") {
        return Left(
          ServerException(data.message.toString()),
        );
      } else {
        return const Right(null);
      }
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }

  Future<Either<ServerException, PatientAppointmentModel>> fetchPatientAppointments(
    String policlinicCode,
    String patientNo,
  ) async {
    try {
      // hastaGelisBilgisi.sonucKodu == "0" && hastaGelisBilgisi.sonucListe.toString() == "[]"
      final response = await hospitalNetworkManager.post(
        Endpoints.patientAcceptanceControl,
        data: {
          "POL_KODU": policlinicCode,
          "HASTA_NO": patientNo,
          "ISLEM_TARIHI": "",
        },
      );
      final data = PatientAppointmentModel.fromJson(response.data);
      if (data.code == "0") {
        return Left(
          ServerException(data.message.toString()),
        );
      } else {
        return Right(data);
      }
      // else if (data.results!.first.table!.first.girisTipi == "YENI_GIRIS" || data.results!.first.table!.first.girisTipi == "VAKA") {
      //   return Right(data);
      // } else {
      //   return Right(data);
      // }
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }

  Future<Either<ServerException, List<Appointment>>> fetchAppointments(String registryNo) async {
    try {
      final response = await hospitalNetworkManager.post(
        Endpoints.appointments,
        data: {
          'TC_KIMLIK_NO': registryNo,
        },
      );
      final data = AppointmentModel.fromJson(response.data);
      if (data.appointmentList != null && data.appointmentList!.isNotEmpty) {
        return Right(data.appointmentList!.first.appointments!);
      } else {
        return Left(
          ServerException(AppStrings.noAppointmentMessage),
        );
      }
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }

  Future<Either<ServerException, void>> cancelAppointment(
    String protocolNo,
    String protocolId,
    String registryNo,
  ) async {
    try {
      await hospitalNetworkManager.post(
        Endpoints.cancelAppointment,
        data: {
          "PROTOKOL_NO": protocolNo,
          "PROTOKOL_ID": protocolId,
          "TC_KIMLIK_NO": registryNo,
        },
      );
      return const Right(null);
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }

  Future<Either<ServerException, void>> makeAppointment(
    String policlinicCode,
    String patientNo,
    String doctorCode,
  ) async {
    try {
      await hospitalNetworkManager.post(
        Endpoints.makeAppointment,
        data: {
          "SERVIS_KODU": policlinicCode,
          "DOKTOR_KODU": doctorCode,
          "HASTA_NO": patientNo,
          "PROTOKOL_NO": "",
          "ISLEM_TARIHI": "",
          "PROVIZYON_NO": ""
        },
      );
      return const Right(null);
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }

  Future<Either<ServerException, List<LabResult>>> fetchLabResults(String registryNo) async {
    try {
      final response = await hospitalNetworkManager.post(
        Endpoints.labResults,
        data: {
          'TC_KIMLIK_NO': registryNo,
        },
      );
      final data = LabResultModel.fromJson(response.data);
      if (data.labResult != null && data.labResult!.isNotEmpty) {
        return Right(data.labResult!);
      } else {
        return Left(ServerException(AppStrings.noResultMessage));
      }
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }

  Future<Either<ServerException, List<LabResultDetail>>> fetchLabResultDetails(String protocolNo, String patientNo) async {
    try {
      final response = await hospitalNetworkManager.post(
        Endpoints.labResultDetail,
        data: {
          'prt': protocolNo,
          'id': patientNo,
        },
      );
      final data = LabResultDetailModel.fromJson(response.data);
      if (data.resultDetails != null && data.resultDetails!.isNotEmpty) {
        return Right(data.resultDetails!);
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

  Future<Either<ServerException, List<PathologyResult>>> fetchPatResults(String registryNo) async {
    try {
      final response = await hospitalNetworkManager.post(
        Endpoints.patResults,
        data: {
          'TC_KIMLIK_NO': registryNo,
        },
      );
      final data = PathologyResultModel.fromJson(response.data);
      if (data.results != null && data.results!.isNotEmpty) {
        return Right(data.results!);
      } else {
        return Left(ServerException(AppStrings.noResultMessage));
      }
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }

  Future<Either<ServerException, List<PatResultDetail>>> fetchPatResultDetails(String pathologyId, String patientNo) async {
    try {
      final response = await hospitalNetworkManager.post(
        Endpoints.patResultDetail,
        data: {
          'ptlid': pathologyId,
          'id': patientNo,
        },
      );
      final data = PatResultDetailModel.fromJson(response.data);
      if (data.results != null && data.results!.isNotEmpty) {
        return Right(data.results!);
      } else {
        return Left(ServerException(AppStrings.noResultMessage));
      }
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }

  Future<Either<ServerException, List<ViewResult>>> fetchViewResults(String registryNo) async {
    try {
      final response = await hospitalNetworkManager.post(
        Endpoints.viewResult,
        data: {
          'TC_KIMLIK_NO': registryNo,
          'skrs_kurum_id': '900182',
        },
      );
      final data = ViewResultModel.fromJson(response.data);
      if (data.results != null && data.results!.isNotEmpty) {
        return Right(data.results!);
      } else {
        return Left(
          ServerException(AppStrings.noResultMessage),
        );
      }
    } on DioException catch (err) {
      return Left(
        ServerException(err.response!.statusMessage.toString()),
      );
    }
  }
}

class HospitalNetworkManager {
  final Dio dio;

  HospitalNetworkManager(this.dio) {
    _initializeDio();
  }

  void _initializeDio() {
    dio
      ..options.baseUrl = Endpoints.hospitalUrl
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            final token = CacheRepository.getHospitalToken();
            options.headers = {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            };
            return handler.next(options);
          },
          // onError: (e, handler) async {
          //   if (e.response?.statusCode == 401) {
          //     await getIt.get<RemoteAuthRepository>().refreshToken();

          //     var accessToken = await getIt.get<LocalAuthRepository>().getToken();

          //     e.requestOptions.headers['Authorization'] = 'Bearer $accessToken';

          //     return handler.resolve(e.response!);
          //   }
          //   return handler.next(e);
          // },
        ),
      )
      ..interceptors.add(
        LogInterceptor(
          request: true,
          requestBody: true,
          responseBody: true,
        ),
      )

      //  'Content-Type': 'application/json',
      ..options.headers['Content-Type'] = 'application/json';
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
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
}
