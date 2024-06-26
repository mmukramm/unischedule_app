import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import 'package:unischedule_app/core/utils/const.dart';
import 'package:unischedule_app/core/errors/failures.dart';
import 'package:unischedule_app/core/errors/exceptions.dart';
import 'package:unischedule_app/core/utils/api_response.dart';
import 'package:unischedule_app/core/utils/credential_saver.dart';
import 'package:unischedule_app/features/data/models/user_info.dart';
import 'package:unischedule_app/features/data/datasources/auth_data_sources.dart';
import 'package:unischedule_app/features/domain/repositories/auth_repository.dart';
import 'package:unischedule_app/features/data/datasources/auth_preferences_helper.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSources authDataSources;
  final AuthPreferencesHelper authPreferencesHelper;

  AuthRepositoryImpl({
    required this.authDataSources,
    required this.authPreferencesHelper,
  });

  @override
  Future<Either<Failure, String>> signIn(Map<String, dynamic> params) async {
    try {
      final result = await authDataSources.signIn(params);

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
        if (e.response?.statusCode == HttpStatus.internalServerError) {
          return Left(ServerFailure(e.message!));
        }
        return Left(failureMessageHandler(
            ApiResponse.fromJson(e.response?.data).message ?? ''));
      }

      return Left(ServerFailure(e.message ?? 'Unknown'));
    }
  }

  @override
  Future<Either<Failure, bool>> whoAmI() async {
    try {
      final result = await authDataSources.whoAmI(
        'Bearer ${CredentialSaver.accessToken}',
      );

      if (result.data == null) {
        return const Left(ServerFailure(kUserInfoNull));
      }

      CredentialSaver.userInfo = UserInfo.fromMap(result.data);

      return Right(CredentialSaver.userInfo!.role == 'ADMIN');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return const Left(ConnectionFailure(kNoInternetConnection));
      }

      if (e.response != null) {
        if (e.response?.statusCode == HttpStatus.internalServerError) {
          return const Left(ServerFailure(kInternalServerError));
        }
        return Left(failureMessageHandler(
            ApiResponse.fromJson(e.response?.data).message ?? ''));
      }

      return Left(ServerFailure(e.message ?? 'Unknown'));
    }
  }

  @override
  Future<Either<Failure, String>> signUp(Map<String, dynamic> params) async {
    try {
      final result = await authDataSources.signUp(params);

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
        if (e.response?.statusCode == HttpStatus.internalServerError) {
          return Left(ServerFailure(e.message!));
        }
        return Left(failureMessageHandler(
            ApiResponse.fromJson(e.response?.data).message ?? ''));
      }

      return Left(ServerFailure(e.message ?? 'Unknown'));
    }
  }

  @override
  Future<Either<Failure, String>> resendVerificationCode() async {
    try {
      final result = await authDataSources.resendVerificationCode(
        'Bearer ${CredentialSaver.accessToken}',
      );

      return Right(result.data as String);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return const Left(ConnectionFailure(kNoInternetConnection));
      }

      if (e.response != null) {
        if (e.response?.statusCode == HttpStatus.internalServerError) {
          return Left(ServerFailure(e.message!));
        }
        return Left(failureMessageHandler(
            ApiResponse.fromJson(e.response?.data).message ?? ''));
      }

      return Left(ServerFailure(e.message ?? 'Unknown'));
    }
  }

  @override
  Future<Either<Failure, String>> verificationEmail(
    Map<String, dynamic> pin,
  ) async {
    try {
      final result = await authDataSources.verificationEmail(
        'Bearer ${CredentialSaver.accessToken}',
        pin,
      );

      return Right(result.message!);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return const Left(ConnectionFailure(kNoInternetConnection));
      }

      if (e.response != null) {
        if (e.response?.statusCode == HttpStatus.internalServerError) {
          return Left(ServerFailure(e.message!));
        }
        return Left(failureMessageHandler(
            ApiResponse.fromJson(e.response?.data).message ?? ''));
      }

      return Left(ServerFailure(e.message ?? 'Unknown'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteAccessToken() async {
    try {
      final result = await authPreferencesHelper.removeAccessToken();

      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, String>> registerFcpToken(String fcmToken) async {
    try {
      final result = await authDataSources.registerFcpToken(
        {'fcp_token': fcmToken},
      );

      return Right(result.data ?? result.message);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return const Left(ConnectionFailure(kNoInternetConnection));
      }

      if (e.response != null) {
        if (e.response?.statusCode == HttpStatus.internalServerError) {
          return Left(ServerFailure(e.message!));
        }
        return Left(failureMessageHandler(
            ApiResponse.fromJson(e.response?.data).message ?? ''));
      }

      return Left(ServerFailure(e.message ?? 'Unknown'));
    }
  }
}
