import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../product/constants/endpoints.dart';
import '../../../../product/extensions/menu_route_extension.dart';
import '../../../../product/utils/api_error_helper.dart';
import '../../../../product/utils/network_manager.dart';
import '../../../data/models/menu_model.dart';
import '../../../data/models/popup_model.dart';
import '../../../data/models/user_info_model.dart';
import '../../../data/repository/cache_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.networkManager)
      : super(const HomeState(
          status: HomeStatus.initial,
        )) {
    on<GetMenuItems>((event, emit) => _onGetMenuItems(event, emit));
    on<GetActivePopUp>((event, emit) => _onGetActivePopUp(event, emit));
    on<SendFirebaseToken>((event, emit) => _onSendFirebasetoken(event, emit));
    on<InitializeFirebaseMessages>(
        (event, emit) => _onInitializeFirebaseMessages(event, emit));
    on<GetUserInfo>((event, emit) => _onGetUserInfo(event, emit));
  }

  final NetworkManager networkManager;

  /// Anasayfada gösterilecek menüleri getiren fonskiyon.
  Future<void> _onGetMenuItems(
    GetMenuItems event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final response = await networkManager.get(Endpoints.employeeMenus);
      final data = MenuModel.fromJson(requireJsonMap(response.data));
      final visibleMenus = (data.menu ?? [])
          .where((item) => item.isVisible && item.isSupportedInApp)
          .toList()
        ..sort((a, b) => (a.order ?? 0).compareTo(b.order ?? 0));
      emit(state.copyWith(
        status: HomeStatus.menuSuccess,
        menu: visibleMenus,
      ));
      add(const GetUserInfo());
      add(const GetActivePopUp());
      add(const SendFirebaseToken());
    } on DioException catch (_) {
      emit(state.copyWith(status: HomeStatus.menuFailed));
    } catch (_) {
      emit(state.copyWith(status: HomeStatus.menuFailed));
    }
  }

  /// Kullanıcıya gösterilmesi gereken bir bildirim olup olmadığını kontrol
  /// eden fonksiyon. Eğer gösterilmesi gereken bir bildirim varsa
  /// `HomeStatus` [popUpSuccess] olarak set edilir ve bildirim dialog olarak
  /// gösterilir.
  Future<void> _onGetActivePopUp(
    GetActivePopUp event,
    Emitter<HomeState> emit,
  ) async {
    const url = Endpoints.notificationsUrl + Endpoints.activePopUp;
    try {
      final response = await networkManager.get(url);
      final data = ActivePopUpModel.fromJson(requireJsonMap(response.data));
      if (data.data?.icerik != null) {
        emit(state.copyWith(
          status: HomeStatus.popUpSuccess,
          popUp: data.data,
        ));
      }
    } catch (_) {}
  }

  Future<void> _onSendFirebasetoken(
    SendFirebaseToken event,
    Emitter<HomeState> emit,
  ) async {
    const url = '${Endpoints.notificationsUrl}/api/myi/pushMesajKimligi';
    try {
      final token = await FirebaseMessaging.instance.getToken();
      await networkManager.post(
        url,
        data: {
          "FCMToken": token.toString(),
          "UygulamaKodu": "TOKATINTRANET2026",
          "IsletimSistemiId": Platform.isAndroid ? "2" : "1",
        },
      );
      print('TokenYollandı: $token');
    } on DioException catch (e) {
      // Push token endpoint may be unavailable in some environments.
      print('Token gönderimi atlandı: ${e.response?.statusCode}');
    } catch (_) {}
  }

  void _onInitializeFirebaseMessages(
    InitializeFirebaseMessages event,
    Emitter<HomeState> emit,
  ) {
    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? message) {
        if (message != null) {
          emit(state.copyWith(
            status: HomeStatus.firebaseMessageSuccess,
          ));
        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      emit(state.copyWith(
        status: HomeStatus.firebaseMessageSuccess,
      ));
    });
  }

  Future<void> _onGetUserInfo(
    GetUserInfo event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final response = await networkManager.get(Endpoints.userInfo);
      final data = UserInfoModel.fromJson(requireJsonMap(response.data));
      if (data.userInfo != null) {
        CacheRepository.saveUserInfo(data.userInfo!);
      }
    } catch (_) {
      // Kullanıcı bilgisi alınamazsa ana sayfa yine de çalışmaya devam eder.
    }
  }
}
