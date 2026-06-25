import 'package:dio/dio.dart';

import '../constants/endpoints.dart';

class MockApi {
  MockApi._();

  static Response<dynamic>? mockGet(String path, {Map<String, dynamic>? queryParameters}) {
    final key = _normalizePath(path);
    final requestOptions = RequestOptions(path: path, queryParameters: queryParameters);

    switch (key) {
      case Endpoints.employeeMenus:
        return Response(
          requestOptions: requestOptions,
          statusCode: 200,
          data: {
            'SonucKod': 0,
            'SonucMesaj': 'Mock menu data',
            'Data': [
              {
                'ID': 1,
                'MENU_DETAY_ID': 101,
                'MENU_ADI': 'Izinlerim',
                'MENU_URL': 'PermissionScreen()',
                'MENU_DINAMIK_URL': null,
                'SIRA': 1,
                'IKON': '/assets/mock/icon.png',
                'OKUMA': true,
                'EKLEME': false,
                'GUNCELLEME': false,
                'SILME': false,
                'RAPOR': false,
                'TIP': 0,
              },
              {
                'ID': 2,
                'MENU_DETAY_ID': 102,
                'MENU_ADI': 'Maas',
                'MENU_URL': 'SalaryScreen()',
                'MENU_DINAMIK_URL': null,
                'SIRA': 2,
                'IKON': '/assets/mock/icon.png',
                'OKUMA': true,
                'EKLEME': false,
                'GUNCELLEME': false,
                'SILME': false,
                'RAPOR': false,
                'TIP': 0,
              },
              {
                'ID': 3,
                'MENU_DETAY_ID': 103,
                'MENU_ADI': 'Telefon Rehberi',
                'MENU_URL': 'PhoneBook()',
                'MENU_DINAMIK_URL': null,
                'SIRA': 3,
                'IKON': '/assets/mock/icon.png',
                'OKUMA': true,
                'EKLEME': false,
                'GUNCELLEME': false,
                'SILME': false,
                'RAPOR': false,
                'TIP': 1,
              },
            ],
          },
        );
      case Endpoints.userInfo:
        return Response(
          requestOptions: requestOptions,
          statusCode: 200,
          data: {
            'SonucKod': 0,
            'SonucMesaj': 'Mock user info',
            'Data': {
              'ADI': 'Test',
              'SOYADI': 'Kullanici',
              'FOTOGRAF': '',
              'CEP_TELEFONU': '5555555555',
              'E_POSTA': 'test@example.com',
              'ADRES': 'Mock adres',
              'DOGUM_TARIHI': '01.01.1990',
              'ISYERI_ADI': 'Mock Belediye',
              'SICIL_NO': 12345,
              'TC_KIMLIK_NO': 12345678901,
              'UNVAN': 'Personel',
              'KADRO_YERI_BASKANLIK': 'Bilgi Islem',
              'KADRO_YERI_ADI': 'Yazilim',
              'FIILI_YERI_BASKANLIK': 'Bilgi Islem',
              'PERSONEL_TURU_ADI': 'MEMUR',
              'SGK_MESLEK_KODU': '0000.00',
              'SGK_ISYERI': 'Mock Isyeri',
              'GOREV_YERI_ADI': 'Merkez',
              'FIILI_GOREVI': 'Yazilim Gelistirme',
              'KADRO_GOREVI': 'Yazilim Uzmani',
              'DAHILI_NO': '1234',
              'KURUM_BASLANGIC_TARIHI': '01.01.2020',
            },
          },
        );
      case Endpoints.activePopUp:
        return Response(
          requestOptions: requestOptions,
          statusCode: 200,
          data: {
            'SonucKod': 0,
            'SonucMesaj': 'Mock popup',
            'Data': null,
          },
        );
      case Endpoints.jobTracking:
        return Response(
          requestOptions: requestOptions,
          statusCode: 200,
          data: 'https://mock-istakip.example.com',
        );
      default:
        return null;
    }
  }

  static Response<dynamic>? mockPost(String path, {Map<String, dynamic>? data}) {
    final key = _normalizePath(path);
    final requestOptions = RequestOptions(path: path);

    switch (key) {
      case Endpoints.otp:
        return Response(
          requestOptions: requestOptions,
          statusCode: 200,
          data: {
            'Kod': 0,
            'Mesaj': 'Mock OTP generated',
            'PkId': 123456,
            'Ekran': 1,
          },
        );
      default:
        return null;
    }
  }

  static String _normalizePath(String path) {
    if (path.startsWith(Endpoints.baseUrl)) {
      return path.replaceFirst(Endpoints.baseUrl, '');
    }
    if (path.startsWith(Endpoints.notificationsUrl)) {
      return path.replaceFirst(Endpoints.notificationsUrl, '');
    }
    if (path.startsWith(Endpoints.hospitalUrl)) {
      return path.replaceFirst(Endpoints.hospitalUrl, '');
    }
    return path;
  }
}
