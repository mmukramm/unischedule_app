import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unischedule_app/features/data/datasources/auth_datasources.dart';
import 'package:unischedule_app/features/data/datasources/auth_preferences_helper.dart';
import 'package:unischedule_app/features/data/repositories/auth_repository_impl.dart';
import 'package:unischedule_app/features/domain/repositories/auth_repository.dart';
import 'package:unischedule_app/features/domain/usecases/post_sign_in.dart';
import 'package:unischedule_app/features/presentation/bloc/countdown/count_down_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/sign_in/sign_in_cubit.dart';

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
  getIt.registerFactory(() => SignInCubit(
        getIt(),
      ));
}

void initUseCases() {
  getIt.registerLazySingleton(
    () => PostSignIn(getIt()),
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
    () => AuthDataSource(getIt()),
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
