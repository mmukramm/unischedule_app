import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:unischedule_app/core/utils/api_response.dart';

part 'user_data_sources.g.dart';

@RestApi(baseUrl: '')
abstract class UserDatasources {
  factory UserDatasources(Dio dio, {String baseUrl}) = _UserDatasources;

  @GET('/users')
  Future<ApiResponse> getUsers(
    @Header('Authorization') String accessToken,
  );

  @GET('/user/{id}')
  Future<ApiResponse> getSingleUser(
    @Header('Authorization') String accessToken,
    @Path('id') userId,
  );

  @DELETE('/user/{id}')
  Future<ApiResponse> removeUser(
    @Header('Authorization') String accessToken,
    @Path('id') userId,
  );
}
