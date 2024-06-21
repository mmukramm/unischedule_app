import 'package:dartz/dartz.dart';

import 'package:unischedule_app/core/errors/failures.dart';
import 'package:unischedule_app/core/usecases/usecase.dart';
import 'package:unischedule_app/features/data/models/activity_participant.dart';
import 'package:unischedule_app/features/domain/repositories/activity_repository.dart';

class GetPostParticipants extends UseCase<ActivityParticipant, String> {
  final ActivityRepository activityRepository;
  GetPostParticipants(this.activityRepository);

  @override
  Future<Either<Failure, ActivityParticipant>> call(String params) =>
      activityRepository.getPostParticipants(params);
}
