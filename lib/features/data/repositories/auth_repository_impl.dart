import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:unischedule_app/core/errors/exceptions.dart';
import 'package:unischedule_app/core/errors/failures.dart';
import 'package:unischedule_app/core/utils/api_response.dart';
import 'package:unischedule_app/core/utils/const.dart';
import 'package:unischedule_app/core/utils/credential_saver.dart';
import 'package:unischedule_app/features/data/datasources/auth_datasources.dart';
import 'package:unischedule_app/features/data/datasources/auth_preferences_helper.dart';
import 'package:unischedule_app/features/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  final AuthPreferencesHelper authPreferencesHelper;
  AuthRepositoryImpl({
    required this.authDataSource,
    required this.authPreferencesHelper,
  });

  @override
  Future<Either<Failure, String>> signIn(Map<String, String> params) async {
    try {
      final result = await authDataSource.signIn(params);

      final isSet = await authPreferencesHelper.setAccessToken(result.token!);

      CredentialSaver.accessToken = result.token;

      if (isSet) {
        return Right(result.message!);
      } else {
        throw throw CacheException(result.message!);
      }

    } on DioException catch (e) {
      
      if (e.type == DioExceptionType.connectionError) {
        return const Left(ConnectionFailure(kNoInternetConnection));
      }
      
      if (e.response != null) {
        return Left(failureMessageHandler(
            ApiResponse.fromJson(e.response!.data).message!));
      }

      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, String>> signUp(Map<String, String> params) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}