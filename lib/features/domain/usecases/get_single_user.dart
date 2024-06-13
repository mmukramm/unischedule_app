import 'package:dartz/dartz.dart';
import 'package:unischedule_app/core/errors/failures.dart';
import 'package:unischedule_app/core/usecases/usecase.dart';
import 'package:unischedule_app/features/data/models/user.dart';
import 'package:unischedule_app/features/domain/repositories/user_repository.dart';

class GetSingleUser extends UseCase<User, String> {
  UserRepository userRepository;

  GetSingleUser(this.userRepository);

  @override
  Future<Either<Failure, User>> call(String params) =>
      userRepository.getSingleUser(params);
}
