import 'package:dartz/dartz.dart';

import 'package:unischedule_app/core/errors/failures.dart';
import 'package:unischedule_app/core/usecases/usecase.dart';
import 'package:unischedule_app/features/domain/repositories/auth_repository.dart';

class PostSignIn extends UseCase<String, Map<String, dynamic>> {
  final AuthRepository authRepository;

  PostSignIn(this.authRepository);

  @override
  Future<Either<Failure, String>> call(Map<String, dynamic> params) =>
      authRepository.signIn(params);
}
