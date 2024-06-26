import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:unischedule_app/core/env/env.dart';
import 'package:unischedule_app/features/domain/usecases/put_user.dart';
import 'package:unischedule_app/features/domain/usecases/post_user.dart';
import 'package:unischedule_app/features/domain/usecases/delete_user.dart';
import 'package:unischedule_app/features/domain/usecases/put_activity.dart';
import 'package:unischedule_app/features/domain/usecases/post_sign_up.dart';
import 'package:unischedule_app/features/domain/usecases/post_sign_in.dart';
import 'package:unischedule_app/features/domain/usecases/post_activity.dart';
import 'package:unischedule_app/features/domain/usecases/get_user_info.dart';
import 'package:unischedule_app/features/domain/usecases/get_all_users.dart';
import 'package:unischedule_app/features/domain/usecases/get_activities.dart';
import 'package:unischedule_app/features/domain/usecases/get_single_user.dart';
import 'package:unischedule_app/features/domain/usecases/delete_activity.dart';
import 'package:unischedule_app/features/data/datasources/user_data_sources.dart';
import 'package:unischedule_app/features/data/datasources/auth_data_sources.dart';
import 'package:unischedule_app/features/domain/repositories/user_repository.dart';
import 'package:unischedule_app/features/domain/usecases/delete_access_token.dart';
import 'package:unischedule_app/features/domain/usecases/get_single_activity.dart';
import 'package:unischedule_app/features/domain/usecases/post_register_event.dart';
import 'package:unischedule_app/features/domain/repositories/auth_repository.dart';
import 'package:unischedule_app/features/domain/usecases/get_post_participants.dart';
import 'package:unischedule_app/features/domain/usecases/get_activities_by_user.dart';
import 'package:unischedule_app/features/data/datasources/activity_data_sources.dart';
import 'package:unischedule_app/features/data/repositories/auth_repository_impl.dart';
import 'package:unischedule_app/features/data/repositories/user_repository_impl.dart';
import 'package:unischedule_app/features/domain/usecases/post_register_fcp_token.dart';
import 'package:unischedule_app/features/domain/usecases/post_verification_email.dart';
import 'package:unischedule_app/features/domain/repositories/activity_repository.dart';
import 'package:unischedule_app/features/presentation/bloc/profile/profile_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/sign_in/sign_in_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/sign_up/sign_up_cubit.dart';
import 'package:unischedule_app/features/data/datasources/auth_preferences_helper.dart';
import 'package:unischedule_app/features/data/repositories/activity_repository_impl.dart';
import 'package:unischedule_app/features/presentation/admin/user/bloc/users_cubit.dart';
import 'package:unischedule_app/features/presentation/admin/user/bloc/user_form_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/countdown/count_down_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/is_sign_in/is_sign_in_cubit.dart';
import 'package:unischedule_app/features/domain/usecases/get_resend_email_verification.dart';
import 'package:unischedule_app/features/presentation/user/activity/bloc/activity_cubit.dart';
import 'package:unischedule_app/features/presentation/admin/user/bloc/user_detail_cubit.dart';
import 'package:unischedule_app/features/presentation/admin/activity/bloc/activity_form_cubit.dart';
import 'package:unischedule_app/features/presentation/admin/activity/bloc/activity_detail_cubit.dart';
import 'package:unischedule_app/features/presentation/admin/activity/bloc/event_participant_cubit.dart';
import 'package:unischedule_app/features/presentation/admin/activity/bloc/activity_management_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/email_verification/email_verification_cubit.dart';
import 'package:unischedule_app/features/presentation/user/activity_history/bloc/activity_history_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/user_activity_detail/user_activity_detail_cubit.dart';

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
    () => IsSignInCubit(getIt(), getIt(), getIt()),
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
  getIt.registerFactory(
    () => UsersCubit(getIt(), getIt(), getIt()),
  );
  getIt.registerFactory(
    () => UserDetailCubit(getIt()),
  );
  getIt.registerFactory(
    () => UserFormCubit(getIt(), getIt()),
  );
  getIt.registerFactory(
    () => ActivityManagementCubit(getIt()),
  );
  getIt.registerFactory(
    () => ActivityFormCubit(getIt(), getIt()),
  );
  getIt.registerFactory(
    () => ActivityDetailCubit(getIt(), getIt()),
  );
  getIt.registerFactory(
    () => ActivityCubit(getIt()),
  );
  getIt.registerFactory(
    () => ActivityHistoryCubit(getIt()),
  );
  getIt.registerFactory(
    () => UserActivityDetailCubit(getIt()),
  );
  getIt.registerFactory(
    () => EventParticipantCubit(getIt()),
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
  getIt.registerLazySingleton(
    () => GetAllUsers(getIt()),
  );
  getIt.registerLazySingleton(
    () => GetSingleUser(getIt()),
  );
  getIt.registerLazySingleton(
    () => DeleteUser(getIt()),
  );
  getIt.registerLazySingleton(
    () => PostUser(getIt()),
  );
  getIt.registerLazySingleton(
    () => PutUser(getIt()),
  );
  getIt.registerLazySingleton(
    () => GetActivities(getIt()),
  );
  getIt.registerLazySingleton(
    () => GetSingleActivity(getIt()),
  );
  getIt.registerLazySingleton(
    () => PostActivity(getIt()),
  );
  getIt.registerLazySingleton(
    () => DeleteActivity(getIt()),
  );
  getIt.registerLazySingleton(
    () => PutActivity(getIt()),
  );
  getIt.registerLazySingleton(
    () => GetPostParticipants(getIt()),
  );
  getIt.registerLazySingleton(
    () => PostRegisterEvent(getIt()),
  );
  getIt.registerLazySingleton(
    () => PostRegisterFcpToken(getIt()),
  );
  getIt.registerLazySingleton(
    () => GetActivitiesByUser(getIt()),
  );
}

void initRepositories() {
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authDataSources: getIt(),
      authPreferencesHelper: getIt(),
    ),
  );

  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      userDatasources: getIt(),
    ),
  );

  getIt.registerLazySingleton<ActivityRepository>(
    () => ActivityRepositoryImpl(
      activityDataSources: getIt(),
    ),
  );
}

void initDataSources() {
  getIt.registerLazySingleton(
    () => AuthDataSources(getIt(), baseUrl: Env.baseUrl),
  );

  getIt.registerLazySingleton<AuthPreferencesHelper>(
    () => AuthPreferencesHelperImpl(getIt()),
  );

  getIt.registerLazySingleton(
    () => UserDatasources(getIt(), baseUrl: Env.baseUrl),
  );

  getIt.registerLazySingleton(
    () => ActivityDataSources(getIt(), baseUrl: Env.baseUrl),
  );
}

Future<void> initExternal() async {
  final preference = await SharedPreferences.getInstance();

  getIt.registerLazySingleton(() => preference);

  getIt.registerLazySingleton(() => Dio());
}
