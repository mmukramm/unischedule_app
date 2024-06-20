import 'package:dartz/dartz.dart';
import 'package:unischedule_app/core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> signIn(Map<String, dynamic> params);

  Future<Either<Failure, bool>> deleteAccessToken();

  Future<Either<Failure, String>> signUp(Map<String, dynamic> params);

  Future<Either<Failure, bool>> whoAmI();

  Future<Either<Failure, String>> resendVerificationCode();

  Future<Either<Failure, String>> verificationEmail(Map<String, dynamic> pin);

  Future<Either<Failure, String>> registerFcpToken(String fcmToken);
}
