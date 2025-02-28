import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:workmanager/workmanager.dart';
import 'notification_heper.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  late Dio dio;
  late String? token;

  Future<String?> getToken() async {
    token = await messaging.getToken();
    return token;
  }

  static Future init() async {
    await messaging.requestPermission();

    messaging.onTokenRefresh.listen((value) {
      sendTokenToServer(value);
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    handleForegroundMessage();

    // تهيئة WorkManager لتشغيل إشعار كل 15 دقيقة
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    Workmanager().registerPeriodicTask(
      "reminderTask",
      "sendNotificationTask",
      frequency: Duration(minutes: 1),
    );
  }

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    log(message.notification?.title ?? 'null');
  }

  static void handleForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotificationService.showBasicNotification(message);
    });
  }

  static void sendTokenToServer(String token) {
    log("New token: $token");
  }

  Future<String> getAccessToken() async {
    final serviceAccountKey =
    await rootBundle.loadString('assets/your-service-account.json');
    final credentials =
    ServiceAccountCredentials.fromJson(json.decode(serviceAccountKey));

    final scopes = ['https://www.googleapis.com/auth/cloud-platform'];
    final client = await clientViaServiceAccount(credentials, scopes);

    final accessToken = (await client.credentials).accessToken.data;
    log("Access Token: $accessToken");
    return accessToken;
  }

  Future<void> sendNotification({ String? title, String? body}) async {
    try {
      dio = Dio();
      String accessToken = await getAccessToken();
      await getToken();

      log(token ?? "null");
      log(title ?? "empty");
      log(body ?? "empty");


      var response = await dio.post(
        "https://fcm.googleapis.com/v1/projects/islami-b06af/messages:send",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        }),
        data: {
          "message": {

            "notification": {
              "title": title,
              "body": body,
            }
          }
        },
      );

      if (response.statusCode == 200) {
        log("Notification sent successfully!");
      } else {
        log("Failed: ${response.statusCode} - ${response.data}");
      }
    } catch (e) {
      log("Error sending notification: ${e.toString()}");
    }
  }
}

// دالة تنفيذ WorkManager لإرسال إشعار كل 15 دقيقة
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    List<String> adhkar = [
      "سبحان الله وبحمده",
      "لا إله إلا الله",
      "أستغفر الله",
      "اللهم صلِّ على محمد",
      "سبحان الله العظيم",
    ];
    String randomDhikr = (adhkar..shuffle()).first;

    await PushNotificationsService().sendNotification(
      title: "ذكر الله",
      body: randomDhikr,
    );




    return Future.value(true);
  });
}
