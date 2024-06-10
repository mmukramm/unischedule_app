import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import 'package:unischedule_app/core/utils/api_response.dart';

part 'auth_datasources.g.dart';

@RestApi(baseUrl: '')
abstract class AuthDataSource {
  factory AuthDataSource(Dio dio, {String baseUrl}) = _AuthDataSource;

  @POST('/login')
  Future<ApiResponse> signIn(
    @Body() Map<String, dynamic> param,
  );

  @POST('/register')
  Future<ApiResponse> signUp(
    @Body() Map<String, dynamic> param,
  );

  @GET('/whoami')
  Future<ApiResponse> whoAmI(
    @Header('Authorization') String accessToken,
  );

  @GET('/send-verif')
  Future<ApiResponse> resendVerificationCode(
    @Header('Authorization') String accessToken,
  );

  @POST('/verif-email')
  Future<ApiResponse> verificationEmail(
    @Header('Authorization') String accessToken,
    @Body() Map<String, dynamic> param,
  );
}

class SignUpParams {
  final String name;
  final String stdCode;
  final String gender;
  final String email;
  final String phoneNumber;
  final String password;
  SignUpParams({
    required this.name,
    required this.stdCode,
    required this.gender,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'std_code': stdCode,
      'gender': gender,
      'email': email,
      'phone_number': phoneNumber,
      'password': password,
    };
  }
}
