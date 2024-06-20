import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:unischedule_app/core/utils/credential_saver.dart';
import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/features/data/datasources/auth_preferences_helper.dart';
import 'package:unischedule_app/features/presentation/common/wrapper.dart';
import 'package:unischedule_app/injection_container.dart';

class FirebaseMessagingConfig {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final fcmToken = await _firebaseMessaging.getToken();

    if (fcmToken != null) {
      AuthPreferencesHelper preferencesHelper = getIt();

      if (await preferencesHelper.getFcmToken() != fcmToken) {
        CredentialSaver.isFcmTokenChange = true;
        preferencesHelper.setFcmToken(fcmToken);
      } else {
        CredentialSaver.isFcmTokenChange = false;
      }
    }

    // iOS Foreground Notification
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // For Android Notification in foreground
    FirebaseMessaging.onMessage.listen(handleForegroundMessage);

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    debugPrint('Token: $fcmToken');
  }

  void handleForegroundMessage(RemoteMessage message) async {
    final notification = message.notification;

    if (notification == null) return;

    const channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    final localNotifications = FlutterLocalNotificationsPlugin();

    await localNotifications.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@drawable/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: (details) {
        if (CredentialSaver.userInfo != null) {
          navigatorKey.currentState!.push(
            MaterialPageRoute(builder: (_) => const Wrapper()),
          );
        }
      },
    );

    await localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: channel.importance,
          icon: '@drawable/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      payload: jsonEncode(message.toMap()),
    );
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {}
