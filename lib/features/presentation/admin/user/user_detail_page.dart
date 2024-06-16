import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unischedule_app/core/enums/snack_bar_type.dart';
import 'package:unischedule_app/core/extensions/context_extension.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/features/data/models/user.dart';
import 'package:unischedule_app/features/presentation/admin/user/bloc/user_detail_cubit.dart';
import 'package:unischedule_app/features/presentation/admin/user/bloc/users_cubit.dart';
import 'package:unischedule_app/features/presentation/admin/user/bloc/users_state.dart';
import 'package:unischedule_app/features/presentation/admin/user/user_form_page.dart';
import 'package:unischedule_app/features/presentation/common/image_view_page.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';
import 'package:unischedule_app/features/presentation/widget/loading.dart';

class UserDetailPage extends StatefulWidget {
  final User user;
  const UserDetailPage({super.key, required this.user});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  late final UserDetailCubit userDetailCubit;
  late final UsersCubit usersCubit;
  @override
  void initState() {
    super.initState();
    userDetailCubit = context.read<UserDetailCubit>();
    usersCubit = context.read<UsersCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserDetailCubit, UsersState>(
      listener: (_, state) {
        if (state.isInProgress) {
          context.showLoadingDialog();
        }
        if (state.isFailure) {
          navigatorKey.currentState!.pop();
          context.showCustomSnackbar(
            message: state.message!,
            type: SnackBarType.error,
          );
        }
        if (state.isMutateDataSuccess) {
          navigatorKey.currentState!.pop();
          navigatorKey.currentState!.pop();
          usersCubit.getUsers();
          context.showCustomSnackbar(
            message: state.message!,
            type: SnackBarType.success,
          );
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          withBackButton: true,
          withDeleteButton: true,
          onTapDeleteButton: () {
            context.showCustomConfirmationDialog(
              title: 'HAPUS USER',
              message:
                  'Yakin ingin menghapus data? Data yang dihapus tidak dapat dipulihkan.',
              onTapDeleteButton: () {
                navigatorKey.currentState!.pop();
                userDetailCubit.removeUser(widget.user.id!);
              },
            );
          },
        ),
        backgroundColor: scaffoldColor,
        body: SingleChildScrollView(
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
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: secondaryTextColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 3,
                      color: primaryColor,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                  ),
                  child: widget.user.profileImage == null
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
                      : GestureDetector(
                          onTap: () => navigatorKey.currentState!.push(
                            MaterialPageRoute(
                              builder: (_) => ImageViewPage(
                                imagePath: widget.user.profileImage,
                              ),
                            ),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: widget.user.profileImage!,
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
                const SizedBox(
                  height: 32,
                ),
                Text(
                  widget.user.stdCode ?? '',
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge!,
                ),
                Text(
                  widget.user.name ?? '',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge!,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.user.gender == 'MALE' ? 'Laki-Laki' : 'Perempuan',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge!,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.user.phoneNumber ?? '',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge!,
                ),
                Text(
                  widget.user.email ?? '',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge!,
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  widget.user.role ?? '',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge!.copyWith(
                    color:
                        widget.user.role == 'ADMIN' ? dangerColor : infoColor,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                FilledButton(
                  onPressed: () {
                    navigatorKey.currentState!.push(
                      MaterialPageRoute(
                        builder: (_) => UserFormPage(
                          isAdmin: widget.user.role == 'ADMIN',
                          isEdit: true,
                          user: widget.user,
                        ),
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    'Edit Data',
                    style: textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
