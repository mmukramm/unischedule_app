import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/features/presentation/admin/home_page.dart';
import 'package:unischedule_app/features/presentation/bloc/is_sign_in/is_sign_in_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/is_sign_in/is_sign_in_state.dart';
import 'package:unischedule_app/features/presentation/user/user_main_menu.dart';
import 'package:unischedule_app/features/presentation/widget/loading.dart';

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
    isSignInCubit.userInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<IsSignInCubit, IsSignInState>(
        listener: (context, state) {
          if (state.isFailure) {
            navigatorKey.currentState!.pushReplacement(
              MaterialPageRoute(builder: (_) => const UserMainMenu()),
            );
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
