import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:retrofit/retrofit.dart';

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

  @MultiPart()
  @POST('/user')
  Future<ApiResponse> createUser(
    @Header('Authorization') String accessToken,
    @Part(name: 'name') String name,
    @Part(name: 'std_code') String? stdCode,
    @Part(name: 'gender') String gender,
    @Part(name: 'email') String email,
    @Part(name: 'phone_number') String phoneNumber,
    @Part(name: 'password') String password,
    @Part(name: 'role') String role,
    @Part(name: 'picture', contentType: "image/jpg") File picture,
  );

  @MultiPart()
  @POST('/user')
  Future<ApiResponse> createNoProfileUser(
    @Header('Authorization') String accessToken,
    @Part(name: 'name') String name,
    @Part(name: 'std_code') String? stdCode,
    @Part(name: 'gender') String gender,
    @Part(name: 'email') String email,
    @Part(name: 'phone_number') String phoneNumber,
    @Part(name: 'role') String role,
    @Part(name: 'password') String password,
  );
}

class CreateUserParams {
  final String name;
  final String? stdCode;
  final String gender;
  final String email;
  final String phoneNumber;
  final String password;
  final String role;
  final String? picture;

  CreateUserParams({
    required this.name,
    this.stdCode,
    required this.gender,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.role,
    this.picture,
  });
}
