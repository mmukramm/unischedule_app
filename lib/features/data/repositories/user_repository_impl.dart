import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:unischedule_app/core/errors/failures.dart';
import 'package:unischedule_app/core/utils/api_response.dart';
import 'package:unischedule_app/core/utils/const.dart';
import 'package:unischedule_app/core/utils/credential_saver.dart';
import 'package:unischedule_app/features/data/datasources/user_data_sources.dart';
import 'package:unischedule_app/features/data/models/user.dart';
import 'package:unischedule_app/features/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasources userDatasources;

  UserRepositoryImpl({required this.userDatasources});

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    try {
      final result = await userDatasources.getUsers(
        'Bearer ${CredentialSaver.accessToken}',
      );

      final users = List<User>.from(
        (result.data as List<dynamic>).map<User>(
          (e) => User.fromMap(e as Map<String, dynamic>),
        ),
      );

      return Right(users);
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
  Future<Either<Failure, User>> getSingleUser(String id) async {
    try {
      final result = await userDatasources.getSingleUser(
        'Bearer ${CredentialSaver.accessToken}',
        id,
      );

      return Right(result.data as User);
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
  Future<Either<Failure, String>> removeUser(String id) async {
    try {
      final result = await userDatasources.removeUser(
        'Bearer ${CredentialSaver.accessToken}',
        id,
      );

      return Right(result.message ?? 'Data berhasil dihapus');
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
  Future<Either<Failure, String>> createUser(
      CreateUserParams createUserParams) async {
    try {
      ApiResponse result;
      debugPrint(createUserParams.picture.toString());
      if (createUserParams.picture != null) {
        result = await userDatasources.createUser(
          'Bearer ${CredentialSaver.accessToken}',
          createUserParams.name,
          createUserParams.stdCode,
          createUserParams.gender,
          createUserParams.email,
          createUserParams.phoneNumber,
          createUserParams.password,
          createUserParams.role,
          File(createUserParams.picture!),
        );
      } else {
        result = await userDatasources.createNoProfileUser(
          'Bearer ${CredentialSaver.accessToken}',
          createUserParams.name,
          createUserParams.stdCode,
          createUserParams.gender,
          createUserParams.email,
          createUserParams.phoneNumber,
          createUserParams.password,
          createUserParams.role,
        );
      }

      return Right(result.message ?? 'Data berhasil ditambahkan');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return const Left(ConnectionFailure(kNoInternetConnection));
      }

      if (e.response != null) {
        debugPrint(e.response?.data.toString());
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
