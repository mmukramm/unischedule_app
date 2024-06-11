import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:unischedule_app/core/errors/exceptions.dart';
import 'package:unischedule_app/core/errors/failures.dart';
import 'package:unischedule_app/core/utils/api_response.dart';
import 'package:unischedule_app/core/utils/const.dart';
import 'package:unischedule_app/core/utils/credential_saver.dart';
import 'package:unischedule_app/features/data/datasources/auth_datasources.dart';
import 'package:unischedule_app/features/data/datasources/auth_preferences_helper.dart';
import 'package:unischedule_app/features/data/models/user_info.dart';
import 'package:unischedule_app/features/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  final AuthPreferencesHelper authPreferencesHelper;

  AuthRepositoryImpl({
    required this.authDataSource,
    required this.authPreferencesHelper,
  });

  @override
  Future<Either<Failure, String>> signIn(Map<String, dynamic> params) async {
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
        debugPrint(e.response.toString());
        return Left(failureMessageHandler(
            ApiResponse.fromJson(e.response!.data).message!));
      }

      return Left(ServerFailure(e.message ?? 'Unknown'));
    }
  }

  @override
  Future<Either<Failure, bool>> whoAmI() async {
    try {
      final result = await authDataSource.whoAmI(
        'Bearer ${CredentialSaver.accessToken}',
      );

      if (result.data == null) {
        return Left(ServerFailure(result.message!));
      }

      CredentialSaver.userInfo = UserInfo.fromMap(result.data);

      return Right(CredentialSaver.userInfo!.role == 'ADMIN');
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
  Future<Either<Failure, String>> signUp(Map<String, dynamic> params) async {
    try {
      final result = await authDataSource.signUp(params);

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
  Future<Either<Failure, String>> resendVerificationCode() async {
    try {
      final result = await authDataSource.resendVerificationCode(
        'Bearer ${CredentialSaver.accessToken}',
      );

      return Right(result.data as String);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return const Left(ConnectionFailure(kNoInternetConnection));
      }

      if (e.response != null) {
        return Left(failureMessageHandler(
            ApiResponse.fromJson(e.response!.data).message ?? ''));
      }

      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, String>> verificationEmail(
    Map<String, dynamic> pin,
  ) async {
    try {
      final result = await authDataSource.verificationEmail(
        'Bearer ${CredentialSaver.accessToken}',
        pin,
      );

      return Right(result.message!);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return const Left(ConnectionFailure(kNoInternetConnection));
      }

      if (e.response != null) {
        debugPrint(e.response.toString());
        if (e.response is String) {
          return Left(ServerFailure(e.message!));
        }
        return Left(failureMessageHandler(
            ApiResponse.fromJson(e.response?.data).message ?? ''));
      }

      return Left(ServerFailure(e.message!));
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
}
