import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import '../../../firebase_options.dart';
import '../../../product/constants/endpoints.dart';
import '../../../product/router/app_router.dart';
import '../../../product/router/app_routes.dart';
import 'cache_repository.dart';

class FirebaseRepository {
  // Firebase instance'larını getter ile alalım
  static FirebaseMessaging get _firebaseMessaging => FirebaseMessaging.instance;
  static String? _fcmToken; // FCM token'ı saklamak için değişken

  static const AndroidNotificationChannel _androidNotificationChannel =
      AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'High Importance Notifications',
    importance: Importance.high,
    playSound: true,
  );

  static final _localNotifications = FlutterLocalNotificationsPlugin();

  static Future<void> initNotificitations() async {
    // Firebase başlatma kontrolü - kaldırıldı çünkü main.dart içinde başlatılıyor

    try {
      // main.dart'ta Firebase başlatılmış olmalı

      if (kDebugMode) {
        print('Firebase bildirim izinleri isteniyor');
      }
      await _firebaseMessaging.requestPermission();
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

      if (Platform.isIOS) {
        final apnsToken = await _firebaseMessaging.getAPNSToken();
        if (kDebugMode) {
          print('APNS Token: $apnsToken');
        }
      }

      final fcmToken = await _firebaseMessaging.getToken();
      if (kDebugMode) {
        print('FCM Token: $fcmToken');
      }

      if (fcmToken != null) {
        _fcmToken = fcmToken; // Token'ı sakla
        if (kDebugMode) {
          print('FCM Token saklandı, giriş yapıldıktan sonra gönderilecek');
        }
      }

      initPushNotifications();
      initLocalNotifications();
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Firebase bildirimleri başlatılırken hata: $e');
        print('Hata detayı: $stackTrace');
      }
    }
  }

  static Future<void> FCMtokenYolla(String token) async {
    try {
      final accessToken = CacheRepository.getAccessToken();
      if (kDebugMode) {
        print('Access Token: $accessToken');
      }

      if (accessToken == null) {
        if (kDebugMode) {
          print('Access Token bulunamadı, FCM token gönderilemedi');
        }
        return;
      }

      final url = "${Endpoints.notificationsUrl}/api/myi/pushMesajKimligi";
      if (kDebugMode) {
        print('İstek URL: $url');
      }

      final body = {
        "FCMToken": token,
        "UygulamaKodu": "KBAGLARINTRANET2023",
        "IsletimSistemiId": Platform.isAndroid ? "2" : "1"
      };
      if (kDebugMode) {
        print('İstek Body: $body');
      }

      var res = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
        body: body,
      );

      if (kDebugMode) {
        print('Sunucu yanıtı - Status Code: ${res.statusCode}');
        print('Sunucu yanıtı - Body: ${res.body}');
      }

      if (res.statusCode == 200) {
        if (kDebugMode) {
          print("FCM Token başarıyla gönderildi");
        }
      } else {
        if (kDebugMode) {
          print(
              "FCM Token gönderilirken hata oluştu - Status Code: ${res.statusCode}");
        }
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("FCM Token gönderilirken hata oluştu: $e");
        print("Hata detayı: $stackTrace");
      }
    }
  }

  static Future<void> initLocalNotifications() async {
    const DarwinInitializationSettings darwinSettings =
        DarwinInitializationSettings();
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('mipmap/ic_launcher');
    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
    );

    await _localNotifications.initialize(
      settings,
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidNotificationChannel);
  }

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    // Burada Firebase.initializeApp gerekli çünkü background handler'da Firebase başlatılmış olmalı
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
    if (kDebugMode) {
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
    }
  }

  static void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    final router = appRouter;

    router.pushNamed(
      AppRoutes.firebaseNotification,
      extra: message,
    );
  }

  static void initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen(
      (message) {
        final notification = message.notification;
        if (notification == null) return;

        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidNotificationChannel.id,
              _androidNotificationChannel.name,
              channelDescription: _androidNotificationChannel.description,
              icon: 'mipmap/ic_launcher',
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  // Giriş yapıldıktan sonra FCM token'ı göndermek için yeni metod
  static Future<void> sendFCMTokenAfterLogin() async {
    if (_fcmToken == null) {
      if (kDebugMode) {
        print('Gönderilecek FCM Token bulunamadı');
      }
      return;
    }

    if (kDebugMode) {
      print('Giriş yapıldı, FCM Token gönderiliyor...');
    }
    await FCMtokenYolla(_fcmToken!);
  }

  static Future<void> createNotificationChannel() async {
    if (Platform.isAndroid) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel',
        'Yüksek Öncelikli Bildirimler',
        description: 'Bu kanal yüksek öncelikli bildirimler için kullanılır',
        importance: Importance.high,
      );

      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      if (kDebugMode) {
        print('Bildirim kanalı başarıyla oluşturuldu');
      }
    }
  }

  static Future<void> initNotifications() async {
    await createNotificationChannel();
    await initNotificitations();
  }
}
