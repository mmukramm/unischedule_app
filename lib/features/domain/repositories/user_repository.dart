import 'package:dartz/dartz.dart';

import 'package:unischedule_app/core/errors/failures.dart';
import 'package:unischedule_app/features/data/models/user.dart';
import 'package:unischedule_app/features/data/datasources/user_data_sources.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getAllUsers();

  Future<Either<Failure, User>> getSingleUser(String id);

  Future<Either<Failure, String>> removeUser(String id);

  Future<Either<Failure, String>> createUser(CreateUserParams createUserParams);

  Future<Either<Failure, String>> updateUser(CreateUserParams createUserParams);
}