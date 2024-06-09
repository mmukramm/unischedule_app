import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unischedule_app/core/enums/snack_bar_type.dart';
import 'package:unischedule_app/core/extensions/context_extension.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/core/utils/credential_saver.dart';
import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/features/presentation/bloc/profile/profile_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/profile/profile_state.dart';
import 'package:unischedule_app/features/presentation/common/login_page.dart';
import 'package:unischedule_app/features/presentation/user/user_main_menu.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';
import 'package:unischedule_app/features/presentation/widget/loading.dart';

class ProfilePage extends StatefulWidget {
  final bool withBackButton;
  const ProfilePage({
    super.key,
    this.withBackButton = false,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileCubit profileCubit;

  @override
  void initState() {
    super.initState();
    profileCubit = context.read<ProfileCubit>();
    profileCubit.userInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        withBackButton: widget.withBackButton,
      ),
      backgroundColor: scaffoldColor,
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.isInfoLogin) {
            debugPrint(state.isLogin.toString());
            if (!state.isLogin) {
              navigatorKey.currentState!.push(
                MaterialPageRoute(
                  builder: (_) => const LoginPage(),
                ),
              );
            }
          }

          if (state.isFailure) {
            context.showCustomSnackbar(
              message: state.message!,
              type: SnackBarType.error,
            );
          }

          if (state.isLogout) {
            navigatorKey.currentState!.pop();
            navigatorKey.currentState!.push(
              MaterialPageRoute(
                builder: (_) => const UserMainMenu(),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isInProgress) {
            return const Loading(
              color: secondaryTextColor,
            );
          }
          if (CredentialSaver.userInfo != null) {
            return SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: secondaryTextColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3,
                          color: primaryColor,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          width: 80,
                          AssetPath.getIcons('user.svg'),
                          colorFilter: const ColorFilter.mode(
                            primaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      "19280483",
                      textAlign: TextAlign.center,
                      style: textTheme.titleLarge!,
                    ),
                    Text(
                      "Hamid Al-Hafidzurrahman",
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge!,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Laki-Laki",
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge!,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "08982791298482",
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge!,
                    ),
                    Text(
                      "hmd@gmail.com",
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge!,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Mahasiswa",
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge!.copyWith(
                        color: infoColor,
                      ),
                    ),
                    const SizedBox(
                      height: 120,
                    ),
                    // Column(
                    //   children: [
                    //     const SizedBox(
                    //       height: 40,
                    //     ),
                    //     Text(
                    //       "Verifikasi Email untuk mendaftar di acara",
                    //       style: textTheme.bodyMedium!.copyWith(
                    //         color: dangerColor,
                    //       ),
                    //     ),
                    //     const SizedBox(
                    //       height: 8,
                    //     ),
                    //     FilledButton(
                    //       style: FilledButton.styleFrom(
                    //           backgroundColor: warningColor,
                    //           shape: const RoundedRectangleBorder()),
                    //       onPressed: () {},
                    //       child: Text(
                    //         'Verifikasi Email',
                    //         style: textTheme.titleMedium!.copyWith(
                    //           color: primaryTextColor,
                    //         ),
                    //       ),
                    //     ),
                    //     const SizedBox(
                    //       height: 32,
                    //     ),
                    //   ],
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          FilledButton(
                            style: FilledButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                            ),
                            onPressed: () {
                              profileCubit.signOut();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  AssetPath.getIcons('logout.svg'),
                                  colorFilter: const ColorFilter.mode(
                                    dangerColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Logout',
                                  style: textTheme.titleLarge!.copyWith(
                                    color: dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
