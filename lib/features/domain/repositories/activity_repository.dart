import 'package:dartz/dartz.dart';
import 'package:unischedule_app/core/errors/failures.dart';
import 'package:unischedule_app/features/data/datasources/activity_data_sources.dart';
import 'package:unischedule_app/features/data/models/post.dart';

abstract class ActivityRepository {
  Future<Either<Failure, List<Post>>> getPosts();

  Future<Either<Failure, Post>> getSinglePost(String id);

  Future<Either<Failure, String>> deletePost(String id);

  Future<Either<Failure, String>> createPost(CreatePostParams createPostParams);

  Future<Either<Failure, String>> updatePost(CreatePostParams createPostParams);
}
