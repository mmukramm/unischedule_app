import 'package:dartz/dartz.dart';
import 'package:unischedule_app/core/errors/failures.dart';
import 'package:unischedule_app/core/usecases/usecase.dart';
import 'package:unischedule_app/features/domain/repositories/activity_repository.dart';

class DeleteActivity extends UseCase<String, String> {
  final ActivityRepository activityRepository;
  DeleteActivity(this.activityRepository);
  @override
  Future<Either<Failure, String>> call(String params) =>
      activityRepository.deletePost(params);
}
