import 'package:dartz/dartz.dart';

import 'package:unischedule_app/core/errors/failures.dart';
import 'package:unischedule_app/core/usecases/usecase.dart';
import 'package:unischedule_app/core/usecases/no_params.dart';
import 'package:unischedule_app/features/domain/repositories/auth_repository.dart';

class GetUserInfo extends UseCase<bool, NoParams> {
  final AuthRepository authRepository;

  GetUserInfo(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) =>
      authRepository.whoAmI();
}
