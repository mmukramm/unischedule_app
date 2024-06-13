import 'package:dartz/dartz.dart';
import 'package:unischedule_app/core/errors/failures.dart';
import 'package:unischedule_app/core/usecases/usecase.dart';
import 'package:unischedule_app/features/domain/repositories/user_repository.dart';

class DeleteUser extends UseCase<String, String> {
  UserRepository userRepository;

  DeleteUser(this.userRepository);

  @override
  Future<Either<Failure, String>> call(String params) =>
      userRepository.removeUser(params);
}
