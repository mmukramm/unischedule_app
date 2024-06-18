import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unischedule_app/core/theme/theme.dart';
import 'package:unischedule_app/core/utils/credential_saver.dart';
import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/features/presentation/admin/activity/bloc/activity_detail_cubit.dart';
import 'package:unischedule_app/features/presentation/admin/activity/bloc/activity_form_cubit.dart';
import 'package:unischedule_app/features/presentation/admin/activity/bloc/activity_management_cubit.dart';
import 'package:unischedule_app/features/presentation/admin/user/bloc/user_detail_cubit.dart';
import 'package:unischedule_app/features/presentation/admin/user/bloc/users_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/countdown/count_down_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/email_verification/email_verification_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/is_sign_in/is_sign_in_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/profile/profile_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/sign_in/sign_in_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/sign_up/sign_up_cubit.dart';
import 'package:unischedule_app/features/presentation/admin/user/bloc/user_form_cubit.dart';
import 'package:unischedule_app/features/presentation/common/splash_page.dart';
import 'package:unischedule_app/injection_container.dart' as di;
import 'package:unischedule_app/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await di.init();

  await CredentialSaver.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<CountDownCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<SignInCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<IsSignInCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<ProfileCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<SignUpCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<EmailVerificationCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<UsersCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<UserDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<UserFormCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<ActivityManagementCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<ActivityFormCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<ActivityDetailCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: scaffoldMessengerKey,
        theme: theme,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        ),
        supportedLocales: const [
          Locale('en', 'US'), // English
          Locale('id', 'ID'), // Indonesia
        ],
        home: const SplashPage(),
      ),
    );
  }
}
