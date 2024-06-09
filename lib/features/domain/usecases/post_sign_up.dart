import 'package:dartz/dartz.dart';
import 'package:unischedule_app/core/errors/failures.dart';
import 'package:unischedule_app/core/usecases/usecase.dart';
import 'package:unischedule_app/features/domain/repositories/auth_repository.dart';

class PostSignUp extends UseCase<String, Map<String, dynamic>> {
  final AuthRepository authRepository;
  PostSignUp(this.authRepository);
  @override
  Future<Either<Failure, String>> call(Map<String, dynamic> params) =>
      authRepository.signUp(params);
}
