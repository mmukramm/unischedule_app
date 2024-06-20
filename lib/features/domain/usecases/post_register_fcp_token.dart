import 'package:dartz/dartz.dart';
import 'package:unischedule_app/core/errors/failures.dart';
import 'package:unischedule_app/core/usecases/usecase.dart';
import 'package:unischedule_app/features/domain/repositories/auth_repository.dart';

class PostRegisterFcpToken extends UseCase<String, String> {
  final AuthRepository authRepository;
  PostRegisterFcpToken(this.authRepository);
  @override
  Future<Either<Failure, String>> call(String params) =>
      authRepository.registerFcpToken(params);
}
