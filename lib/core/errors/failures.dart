import 'package:unischedule_app/core/utils/const.dart';

abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

Failure failureMessageHandler(String errorMessage) {
  switch (errorMessage) {
    case kUsernameOrPasswordIncorrect:
      return const ServerFailure("Username atau Password salah");
    default:
      return ServerFailure(errorMessage);
  }
}
