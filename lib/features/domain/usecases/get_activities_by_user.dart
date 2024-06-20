import 'package:dartz/dartz.dart';
import 'package:unischedule_app/core/errors/failures.dart';
import 'package:unischedule_app/core/usecases/no_params.dart';
import 'package:unischedule_app/core/usecases/usecase.dart';
import 'package:unischedule_app/features/data/models/post_by_user.dart';
import 'package:unischedule_app/features/domain/repositories/activity_repository.dart';

class GetActivitiesByUser extends UseCase<List<PostByUser>, NoParams> {
  final ActivityRepository activityRepository;
  GetActivitiesByUser(this.activityRepository);
  @override
  Future<Either<Failure, List<PostByUser>>> call(NoParams params) =>
      activityRepository.getPostsByUserId();
}
