import 'package:dartz/dartz.dart';
import 'package:unischedule_app/core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> signIn(Map<String, String> params);

  Future<Either<Failure, String>> signUp(Map<String, String> params);
}