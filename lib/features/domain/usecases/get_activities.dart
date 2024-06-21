import 'package:dartz/dartz.dart';

import 'package:unischedule_app/core/errors/failures.dart';
import 'package:unischedule_app/core/usecases/usecase.dart';
import 'package:unischedule_app/core/usecases/no_params.dart';
import 'package:unischedule_app/features/data/models/post.dart';
import 'package:unischedule_app/features/domain/repositories/activity_repository.dart';

class GetActivities extends UseCase<List<Post>, NoParams> {
  final ActivityRepository activityRepository;
  GetActivities(this.activityRepository);
  @override
  Future<Either<Failure, List<Post>>> call(NoParams params) =>
      activityRepository.getPosts();
}
