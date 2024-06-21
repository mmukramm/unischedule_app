import 'package:shared_preferences/shared_preferences.dart';

import 'package:unischedule_app/core/utils/const.dart';
import 'package:unischedule_app/core/errors/exceptions.dart';
import 'package:unischedule_app/core/utils/credential_saver.dart';

abstract class AuthPreferencesHelper {
  // Access Token
  Future<String?> getAccessToken();
  Future<bool> setAccessToken(String accessToken);
  Future<bool> removeAccessToken();

  // FCM Token
  Future<String?> getFcmToken();
  Future<bool> setFcmToken(String fcmToken);
  Future<bool> removeFcmToken();
}

class AuthPreferencesHelperImpl implements AuthPreferencesHelper {
  final SharedPreferences sharedPreferences;

  AuthPreferencesHelperImpl(this.sharedPreferences);

  @override
  Future<String?> getAccessToken() async {
    try {
      if (sharedPreferences.containsKey(accessTokenKey)) {
        final token = sharedPreferences.getString(accessTokenKey);

        CredentialSaver.accessToken ??= token;

        return token;
      } else {
        return null;
      }
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<bool> setAccessToken(String accessToken) async {
    try {
      return await sharedPreferences.setString(accessTokenKey, accessToken);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<bool> removeAccessToken() async {
    try {
      return await sharedPreferences.remove(accessTokenKey);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<String?> getFcmToken() async {
    try {
      if (sharedPreferences.containsKey(fcmTokenKey)) {
        final token = sharedPreferences.getString(fcmTokenKey);

        return token;
      } else {
        return null;
      }
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<bool> setFcmToken(String fcmToken) async {
    try {
      return await sharedPreferences.setString(fcmTokenKey, fcmToken);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<bool> removeFcmToken() async {
    try {
      return await sharedPreferences.remove(fcmTokenKey);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
