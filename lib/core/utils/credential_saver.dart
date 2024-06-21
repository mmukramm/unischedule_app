import 'package:unischedule_app/injection_container.dart';
import 'package:unischedule_app/features/data/models/user_info.dart';
import 'package:unischedule_app/features/data/datasources/auth_preferences_helper.dart';

class CredentialSaver {
  static String? accessToken;
  static String? fcmToken;
  static bool? isFcmTokenChange;
  static UserInfo? userInfo;

  static Future<void> init() async {
    if (accessToken == null) {
      AuthPreferencesHelper preferencesHelper = getIt();

      accessToken = await preferencesHelper.getAccessToken();
      fcmToken = await preferencesHelper.getFcmToken();
    }
  }
}