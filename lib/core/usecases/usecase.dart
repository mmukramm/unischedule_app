import 'package:dartz/dartz.dart';

import 'package:unischedule_app/core/errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
