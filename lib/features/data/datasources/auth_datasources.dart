import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:unischedule_app/core/env/env.dart';
import 'package:unischedule_app/core/utils/api_response.dart';

part 'auth_datasources.g.dart';

@RestApi(baseUrl: Env.baseUrl)
abstract class AuthDataSource {
  factory AuthDataSource(Dio dio, {String baseUrl}) = _AuthDataSource;

  @POST('/login')
  Future<ApiResponse> signIn(@Body() Map<String, String> param);

  @POST('/register')
  Future<ApiResponse> signUp(@Body() Map<String, String> param);
}