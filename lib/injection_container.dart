import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unischedule_app/core/env/env.dart';
import 'package:unischedule_app/features/data/datasources/auth_datasources.dart';
import 'package:unischedule_app/features/data/datasources/auth_preferences_helper.dart';
import 'package:unischedule_app/features/data/repositories/auth_repository_impl.dart';
import 'package:unischedule_app/features/domain/repositories/auth_repository.dart';
import 'package:unischedule_app/features/domain/usecases/delete_access_token.dart';
import 'package:unischedule_app/features/domain/usecases/get_resend_email_verification.dart';
import 'package:unischedule_app/features/domain/usecases/get_user_info.dart';
import 'package:unischedule_app/features/domain/usecases/post_sign_in.dart';
import 'package:unischedule_app/features/domain/usecases/post_sign_up.dart';
import 'package:unischedule_app/features/domain/usecases/post_verification_email.dart';
import 'package:unischedule_app/features/presentation/bloc/countdown/count_down_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/email_verification/email_verification_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/is_sign_in/is_sign_in_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/profile/profile_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/sign_in/sign_in_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/sign_up/sign_up_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  initBlocs();
  initUseCases();
  initRepositories();
  initDataSources();
  await initExternal();
}

void initBlocs() {
  getIt.registerFactory(() => CountDownCubit());
  getIt.registerFactory(
    () => SignInCubit(getIt(), getIt()),
  );
  getIt.registerFactory(
    () => IsSignInCubit(getIt()),
  );
  getIt.registerFactory(
    () => ProfileCubit(getIt(), getIt()),
  );
  getIt.registerFactory(
    () => SignUpCubit(getIt(), getIt()),
  );
  getIt.registerFactory(
    () => EmailVerificationCubit(getIt(), getIt()),
  );
}

void initUseCases() {
  getIt.registerLazySingleton(
    () => PostSignIn(getIt()),
  );
  getIt.registerLazySingleton(
    () => GetUserInfo(getIt()),
  );
  getIt.registerLazySingleton(
    () => DeleteAccessToken(getIt()),
  );
  getIt.registerLazySingleton(
    () => PostSignUp(getIt()),
  );
  getIt.registerLazySingleton(
    () => GetResendEmailVerification(getIt()),
  );
  getIt.registerLazySingleton(
    () => PostVerificationEmail(getIt()),
  );
}

void initRepositories() {
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authDataSource: getIt(),
      authPreferencesHelper: getIt(),
    ),
  );
}

void initDataSources() {
  getIt.registerLazySingleton(
    () => AuthDataSource(getIt(), baseUrl: Env.baseUrl),
  );

  getIt.registerLazySingleton<AuthPreferencesHelper>(
    () => AuthPreferencesHelperImpl(getIt()),
  );
}

Future<void> initExternal() async {
  final preference = await SharedPreferences.getInstance();

  getIt.registerLazySingleton(() => preference);

  getIt.registerLazySingleton(() => Dio());
}
