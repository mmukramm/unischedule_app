import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:unischedule_app/core/utils/credential_saver.dart';
import 'package:unischedule_app/features/data/datasources/auth_preferences_helper.dart';
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

    debugPrint('Token: $fcmToken');
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
  }
}
