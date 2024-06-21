import 'package:dartz/dartz.dart';

import 'package:unischedule_app/core/errors/failures.dart';
import 'package:unischedule_app/core/usecases/usecase.dart';
import 'package:unischedule_app/features/data/models/post.dart';
import 'package:unischedule_app/features/domain/repositories/activity_repository.dart';

class GetSingleActivity extends UseCase<Post, String> {
  final ActivityRepository activityRepository;
  GetSingleActivity(this.activityRepository);
  @override
  Future<Either<Failure, Post>> call(String params) =>
      activityRepository.getSinglePost(params);
}
