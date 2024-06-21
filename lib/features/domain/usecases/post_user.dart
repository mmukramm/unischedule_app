import 'package:dartz/dartz.dart';

import 'package:unischedule_app/core/errors/failures.dart';
import 'package:unischedule_app/core/usecases/usecase.dart';
import 'package:unischedule_app/features/data/datasources/user_data_sources.dart';
import 'package:unischedule_app/features/domain/repositories/user_repository.dart';

class PostUser extends UseCase<String, CreateUserParams> {
  final UserRepository userRepository;
  PostUser(this.userRepository);
  @override
  Future<Either<Failure, String>> call(CreateUserParams params) =>
      userRepository.createUser(params);
}
