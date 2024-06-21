import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/core/utils/const.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/enums/snack_bar_type.dart';
import 'package:unischedule_app/core/utils/credential_saver.dart';
import 'package:unischedule_app/core/extensions/context_extension.dart';
import 'package:unischedule_app/features/presentation/widget/loading.dart';
import 'package:unischedule_app/features/presentation/admin/home_page.dart';
import 'package:unischedule_app/features/presentation/user/user_main_menu.dart';
import 'package:unischedule_app/features/presentation/bloc/is_sign_in/is_sign_in_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/is_sign_in/is_sign_in_state.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  late final IsSignInCubit isSignInCubit;

  @override
  void initState() {
    super.initState();
    isSignInCubit = context.read<IsSignInCubit>();
    if (CredentialSaver.isFcmTokenChange!) {
      isSignInCubit.registerFcpToken(CredentialSaver.fcmToken!);
    } else {
      isSignInCubit.userInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<IsSignInCubit, IsSignInState>(
        listener: (context, state) {
          if (state.isFailure) {
            if (state.message == kJwtMalformed ||
                state.message == kThisUserIsNotLoggedIn) {
              navigatorKey.currentState!.pushReplacement(
                MaterialPageRoute(builder: (_) => const UserMainMenu()),
              );
            } else if (state.message == kNoInternetConnection) {
              context.showCustomSnackbar(
                message: state.message!,
                type: SnackBarType.error,
              );
              context.showNoInternetConnectionDialog(
                title: 'Tidak Terhubung ke Jaringan ',
                withCloseButton: false,
                message:
                    'Pastikan perangkat Anda terhubung ke jaringan, lalu silahkan soba lagi.',
                onTapPrimaryButton: () {
                  navigatorKey.currentState!.pop();
                  isSignInCubit.userInfo();
                },
                primaryButtonText: 'Refresh',
              );
            } else if (state.message == kInternalServerError) {
              context.showServerErrorDialog(
                title: 'Terjadi Kesalahan',
                message:
                    'Terjadi kesalahan saat menghubungkan ke server. Silahkan coba lagi.',
                withCloseButton: false,
                onTapPrimaryButton: () {
                  navigatorKey.currentState!.pop();
                  isSignInCubit.userInfo();
                },
                primaryButtonText: 'Refresh',
              );
            } else {
              context.showServerErrorDialog(
                title: 'Terjadi Kesalahan',
                message:
                    'Terjadi kesalahan saat menghubungkan ke server. Silahkan coba lagi.',
                withCloseButton: false,
                onTapPrimaryButton: () {
                  navigatorKey.currentState!.pop();
                  isSignInCubit.userInfo();
                },
                primaryButtonText: 'Refresh',
              );
            }
          }

          if (state.isFcmTokenChange) {
            context.showCustomSnackbar(
              message: state.message!,
              type: SnackBarType.success,
            );
            isSignInCubit.userInfo();
          }

          if (state.isSuccess) {
            if (state.data as bool) {
              navigatorKey.currentState!.pushReplacement(
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
            } else {
              navigatorKey.currentState!.pushReplacement(
                MaterialPageRoute(builder: (_) => const UserMainMenu()),
              );
            }
          }
        },
        child: const Center(
          child: Loading(
            color: secondaryTextColor,
          ),
        ),
      ),
    );
  }
}
