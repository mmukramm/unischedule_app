import 'package:dartz/dartz.dart';
import 'package:unischedule_app/core/errors/failures.dart';
import 'package:unischedule_app/core/usecases/no_params.dart';
import 'package:unischedule_app/core/usecases/usecase.dart';
import 'package:unischedule_app/features/domain/repositories/auth_repository.dart';

class GetResendEmailVerification extends UseCase<String, NoParams> {
  final AuthRepository authRepository;
  GetResendEmailVerification(this.authRepository);

  @override
  Future<Either<Failure, String>> call(NoParams params) =>
      authRepository.resendVerificationCode();
}
