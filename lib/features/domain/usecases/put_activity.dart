import 'package:dartz/dartz.dart';
import 'package:unischedule_app/core/errors/failures.dart';
import 'package:unischedule_app/core/usecases/usecase.dart';
import 'package:unischedule_app/features/data/datasources/activity_data_sources.dart';
import 'package:unischedule_app/features/domain/repositories/activity_repository.dart';

class PutActivity extends UseCase<String, CreatePostParams> {
  final ActivityRepository activityRepository;
  PutActivity(this.activityRepository);

  @override
  Future<Either<Failure, String>> call(CreatePostParams params) =>
      activityRepository.updatePost(params);
}
