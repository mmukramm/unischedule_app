import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:unischedule_app/core/errors/failures.dart';
import 'package:unischedule_app/core/utils/api_response.dart';
import 'package:unischedule_app/core/utils/const.dart';
import 'package:unischedule_app/features/data/datasources/activity_data_sources.dart';
import 'package:unischedule_app/features/data/models/post.dart';
import 'package:unischedule_app/features/domain/repositories/activity_repository.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityDataSources activityDataSources;

  ActivityRepositoryImpl({required this.activityDataSources});

  @override
  Future<Either<Failure, String>> createPost(
      CreatePostParams createPostParams) {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> deletePost(String id) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    try {
      final result = await activityDataSources.getPosts();

      final users = List<Post>.from(
        (result.data as List<dynamic>).map<Post>(
          (e) => Post.fromMap(e as Map<String, dynamic>),
        ),
      );

      return Right(users);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return const Left(ConnectionFailure(kNoInternetConnection));
      }

      if (e.response != null) {
        if (e.response?.statusCode == HttpStatus.internalServerError) {
          return Left(ServerFailure(e.message!));
        }
        return Left(failureMessageHandler(
            ApiResponse.fromJson(e.response?.data).message ?? ''));
      }

      return Left(ServerFailure(e.message ?? 'Unknown'));
    }
  }

  @override
  Future<Either<Failure, Post>> getSinglePost(String id) {
    // TODO: implement getSinglePost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> updatePost(
      CreatePostParams createPostParams) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}