import 'package:dartz/dartz.dart';

import 'package:unischedule_app/core/errors/failures.dart';
import 'package:unischedule_app/features/data/models/post.dart';
import 'package:unischedule_app/features/data/models/post_by_user.dart';
import 'package:unischedule_app/features/data/models/activity_participant.dart';
import 'package:unischedule_app/features/data/datasources/activity_data_sources.dart';

abstract class ActivityRepository {
  // Post / Activity
  Future<Either<Failure, List<Post>>> getPosts();

  Future<Either<Failure, Post>> getSinglePost(String id);

  Future<Either<Failure, String>> deletePost(String id);

  Future<Either<Failure, String>> createPost(CreatePostParams createPostParams);

  Future<Either<Failure, String>> updatePost(CreatePostParams createPostParams);

  // Participant
  Future<Either<Failure, ActivityParticipant>> getPostParticipants(
      String postId);

  Future<Either<Failure, String>> registerEvent(String postId);

  Future<Either<Failure, List<PostByUser>>> getPostsByUserId();
}
