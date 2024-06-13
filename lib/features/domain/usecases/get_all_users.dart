import 'package:dartz/dartz.dart';
import 'package:unischedule_app/core/errors/failures.dart';
import 'package:unischedule_app/core/usecases/no_params.dart';
import 'package:unischedule_app/core/usecases/usecase.dart';
import 'package:unischedule_app/features/data/models/user.dart';
import 'package:unischedule_app/features/domain/repositories/user_repository.dart';

class GetAllUsers extends UseCase<List<User>, NoParams> {
  final UserRepository userRepository;

  GetAllUsers(this.userRepository);

  @override
  Future<Either<Failure, List<User>>> call(NoParams params) =>
      userRepository.getAllUsers();
}
