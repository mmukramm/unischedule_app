import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:retrofit/retrofit.dart';

import 'package:unischedule_app/core/utils/api_response.dart';

part 'activity_data_sources.g.dart';

@RestApi(baseUrl: '')
abstract class ActivityDataSources {
  factory ActivityDataSources(Dio dio, {String baseUrl}) = _ActivityDataSources;

  @GET('/posts')
  Future<ApiResponse> getPosts();

  @GET('/post/{id}')
  Future<ApiResponse> getSinglePost(
    @Header('Authorization') String accessToken,
    @Path('id') String id,
  );

  @POST('/post')
  @MultiPart()
  Future<ApiResponse> createPost(
    @Header('Authorization') String accessToken,
    @Part(name: 'title') String title,
    @Part(name: 'content') String content,
    @Part(name: 'organizer') String organizer,
    @Part(name: 'eventDate') String eventDate,
    @Part(name: 'is_event') String isEvent,
    @Part(name: 'picture', contentType: 'image/jpg') File picture,
  );

  @PUT('/post/{id}')
  @MultiPart()
  Future<ApiResponse> updatePost(
    @Header('Authorization') String accessToken,
    @Path('id') String id,
    @Part(name: 'title') String? title,
    @Part(name: 'content') String? content,
    @Part(name: 'organizer') String? organizer,
    @Part(name: 'eventDate') String? eventDate,
    @Part(name: 'is_event') String? isEvent,
    @Part(name: 'picture', contentType: 'image/jpg') File picture,
  );

  @PUT('/post/{id}')
  @MultiPart()
  Future<ApiResponse> updatePostWihoutPicture(
    @Header('Authorization') String accessToken,
    @Path('id') String id,
    @Part(name: 'title') String? title,
    @Part(name: 'content') String? content,
    @Part(name: 'organizer') String? organizer,
    @Part(name: 'eventDate') String? eventDate,
    @Part(name: 'is_event') String? isEvent,
  );

  @DELETE('/post/{id}')
  Future<ApiResponse> deletePost(
    @Header('Authorization') String accessToken,
    @Path('id') String id,
  );
}

class CreatePostParams {
  final String? id;
  final String? title;
  final String? content;
  final String? organizer;
  final String? eventDate;
  final bool? isEvent;
  final File? file;

  CreatePostParams({
    this.id,
    this.title,
    this.content,
    this.organizer,
    this.eventDate,
    this.isEvent,
    this.file,
  });
}
