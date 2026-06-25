import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tokatpersonelim/firebase_options.dart';

import 'features/data/repository/cache_repository.dart';
import 'features/data/repository/firebase_repository.dart';
import 'features/presentation/accident/cubit/accident_cubit.dart';
import 'features/presentation/accident/cubit/selected_files_cubit.dart';
import 'features/presentation/appointment/tab_screens/make_appointment/cubit/make_appointment_cubit.dart';
import 'features/presentation/auth/forgot_password/cubit/change_password_cubit.dart';
import 'features/presentation/entrance/cubit/entrance_cubit.dart';
import 'features/presentation/movable/tab_screens/fixture/cubit/fixture_cubit.dart';
import 'features/presentation/movable_count/cubit/movable_active_page_cubit.dart';
import 'features/presentation/movable_count/cubit/movable_count_cubit.dart';
import 'features/presentation/salary/bloc/corporate_salary_bloc.dart';
import 'product/constants/app_theme.dart';
import 'product/router/app_router.dart';
import 'product/utils/dependency_injection.dart';
import 'product/utils/network_manager.dart';

Future<void> main() async {
  if (kDebugMode) {
    print('Uygulama başlatılıyor...');
  }

  WidgetsFlutterBinding.ensureInitialized();

  // Hive ve DI başlatmaları
  if (kDebugMode) {
    print('Hive ve DI başlatılıyor...');
  }
  await Hive.initFlutter();
  await CacheRepository.openAllBoxes();
  setDI();
  if (kDebugMode) {
    print('Hive ve DI başlatıldı');
  }

  // Önce Firebase'i başlat
  try {
    if (kDebugMode) {
      print('Firebase başlatılıyor...');
    }

    // Firebase'i başlat - zaten başlatılmışsa duplicate app hatası verir, o zaman devam et
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      if (kDebugMode) {
        print('Firebase [DEFAULT] app olarak başlatıldı');
      }
    } else {
      if (kDebugMode) {
        print('Firebase zaten başlatılmış');
      }
    }

    // Arka plan mesaj işleyicisini ayarla
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Bildirim sistemini başlat
    if (kDebugMode) {
      print('Firebase bildirimleri başlatılıyor...');
    }
    await FirebaseRepository.initNotificitations();
    if (kDebugMode) {
      print('Firebase bildirimleri başlatıldı');
    }
  } catch (e, stackTrace) {
    // Duplicate app hatası normal bir durum olabilir (iOS'ta native başlatma)
    if (e.toString().contains('duplicate-app')) {
      if (kDebugMode) {
        print('Firebase zaten başlatılmış (duplicate-app hatası normal)');
      }
      // Firebase zaten başlatılmış, bildirimleri başlatmaya devam et
      try {
        await FirebaseRepository.initNotificitations();
        if (kDebugMode) {
          print('Firebase bildirimleri başlatıldı');
        }
      } catch (notifError) {
        if (kDebugMode) {
          print('Firebase bildirimleri başlatılırken hata: $notifError');
        }
      }
    } else {
      if (kDebugMode) {
        print('Firebase başlatılırken hata: $e');
        print('Hata detayı: $stackTrace');
      }
    }
  }

  initializeDateFormatting();

  HttpOverrides.global = MyHttpOverrides();

  if (kDebugMode) {
    print('Uygulama çalıştırılıyor...');
  }
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt.get<MakeAppointmentCubit>()),
        BlocProvider(create: (context) => getIt.get<FixtureCubit>()),
        BlocProvider(create: (context) => getIt.get<EntranceCubit>()),
        BlocProvider(create: (context) => getIt.get<ChangePasswordCubit>()),
        BlocProvider(create: (context) => getIt.get<MovableCountCubit>()),
        BlocProvider(create: (context) => MovableActivePageCubit()),
        BlocProvider(create: (context) => getIt.get<AccidentCubit>()),
        BlocProvider(create: (context) => SelectedFilesCubit()),
        BlocProvider(
            create: (context) => CorporateSalaryBloc(NetworkManager(Dio()))),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Tokat Personelim',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
  playSound: true,
);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  if (kDebugMode) {
    print('A bg message just showed up :  ${message.messageId}');
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
