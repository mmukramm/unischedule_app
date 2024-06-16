import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:unischedule_app/features/presentation/common/email_verification_page.dart';
import 'package:unischedule_app/features/presentation/common/image_view_page.dart';
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
          if (state.isFailure) {
            context.showCustomSnackbar(
              message: state.message!,
              type: SnackBarType.error,
            );
          }

          if (state.isLogout) {
            if (CredentialSaver.userInfo?.role == 'ADMIN') {
              navigatorKey.currentState!.pop();
            }
            navigatorKey.currentState!.pop();
            CredentialSaver.accessToken = null;
            CredentialSaver.userInfo = null;
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
                      child: CredentialSaver.userInfo!.profileImage == null
                          ? Padding(
                              padding: const EdgeInsets.all(12),
                              child: SvgPicture.asset(
                                width: 80,
                                AssetPath.getIcons('user.svg'),
                                colorFilter: const ColorFilter.mode(
                                  primaryColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                navigatorKey.currentState!.push(
                                  MaterialPageRoute(
                                    builder: (_) => ImageViewPage(
                                      imagePath: CredentialSaver
                                          .userInfo!.profileImage,
                                    ),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(500),
                              child: Container(
                                width: 160,
                                height: 160,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 3,
                                      color: primaryColor,
                                      strokeAlign:
                                          BorderSide.strokeAlignOutside),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      CredentialSaver.userInfo!.profileImage!,
                                  placeholder: (_, __) => const Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Loading(
                                      color: scaffoldColor,
                                    ),
                                  ),
                                  errorWidget: (_, __, ___) => Padding(
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
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      CredentialSaver.userInfo?.stdCode ?? '',
                      textAlign: TextAlign.center,
                      style: textTheme.titleLarge!,
                    ),
                    Text(
                      CredentialSaver.userInfo?.name ?? '',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge!,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      CredentialSaver.userInfo?.gender ?? '',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge!,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      CredentialSaver.userInfo?.phoneNumber ?? '',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge!,
                    ),
                    Text(
                      CredentialSaver.userInfo?.email ?? '',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge!,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      CredentialSaver.userInfo?.role ?? '',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge!.copyWith(
                        color: CredentialSaver.userInfo?.role == 'ADMIN'
                            ? dangerColor
                            : infoColor,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    if (CredentialSaver.userInfo!.role != 'ADMIN' &&
                        !CredentialSaver.userInfo!.emailVerified!)
                      Column(
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          Text(
                            "Verifikasi Email untuk mendaftar di acara",
                            style: textTheme.bodyMedium!.copyWith(
                              color: dangerColor,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          FilledButton(
                            style: FilledButton.styleFrom(
                                backgroundColor: warningColor,
                                shape: const RoundedRectangleBorder()),
                            onPressed: () {
                              navigatorKey.currentState!.push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const EmailVerificationPage(
                                          isSend: false),
                                ),
                              );
                            },
                            child: Text(
                              'Verifikasi Email',
                              style: textTheme.titleMedium!.copyWith(
                                color: primaryTextColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                        ],
                      ),
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
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Silahkan Login',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 12,
                ),
                FilledButton(
                  onPressed: () {
                    navigatorKey.currentState!
                        .push(
                      MaterialPageRoute(
                        builder: (_) => const LoginPage(),
                      ),
                    )
                        .then(
                      (_) {
                        profileCubit.userInfo();
                      },
                    );
                  },
                  child: Text(
                    'Login',
                    style:
                        textTheme.titleSmall!.copyWith(color: primaryTextColor),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
