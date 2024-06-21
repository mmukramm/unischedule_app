import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/core/enums/snack_bar_type.dart';
import 'package:unischedule_app/features/data/models/user.dart';
import 'package:unischedule_app/core/extensions/context_extension.dart';
import 'package:unischedule_app/features/presentation/widget/loading.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';
import 'package:unischedule_app/features/presentation/admin/user/user_form_page.dart';
import 'package:unischedule_app/features/presentation/widget/ink_well_container.dart';
import 'package:unischedule_app/features/presentation/admin/user/bloc/users_cubit.dart';
import 'package:unischedule_app/features/presentation/admin/user/bloc/users_state.dart';
import 'package:unischedule_app/features/presentation/admin/user/user_detail_page.dart';
import 'package:unischedule_app/features/presentation/widget/custom_selector_dialog.dart';

class UsersManagementPage extends StatefulWidget {
  const UsersManagementPage({super.key});

  @override
  State<UsersManagementPage> createState() => _UsersManagementPageState();
}

class _UsersManagementPageState extends State<UsersManagementPage> {
  late final UsersCubit usersCubit;
  late List<User> users;

  @override
  void initState() {
    super.initState();

    users = [];
    usersCubit = context.read<UsersCubit>();
    usersCubit.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Daftar User",
        withBackButton: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.showCustomSelectorDialog(
            title: 'Pilih Role',
            message: 'Pilih role user',
            items: [
              SelectorDialogParams(
                label: 'Admin',
                onTap: () {
                  navigatorKey.currentState!.pop();
                  navigatorKey.currentState!.push(
                    MaterialPageRoute(
                      builder: (_) => const UserFormPage(
                        isEdit: false,
                        isAdmin: true,
                      ),
                    ),
                  );
                },
              ),
              SelectorDialogParams(
                label: 'User',
                onTap: () {
                  navigatorKey.currentState!.pop();
                  navigatorKey.currentState!.push(
                    MaterialPageRoute(
                      builder: (_) => const UserFormPage(
                        isEdit: false,
                        isAdmin: false,
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
        shape: const RoundedRectangleBorder(),
        backgroundColor: infoColor,
        child: SvgPicture.asset(
          AssetPath.getIcons('plus.svg'),
          colorFilter: const ColorFilter.mode(
            scaffoldColor,
            BlendMode.srcIn,
          ),
        ),
      ),
      body: BlocConsumer<UsersCubit, UsersState>(
        listener: (context, state) {
          if (state.isMutateDataSuccess) {
            context.showCustomSnackbar(
              message: state.message!,
              type: SnackBarType.success,
            );
          }
          if (state.isFailure) {
            context.showCustomSnackbar(
              message: state.message!,
              type: SnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          if (state.isInProgress) {
            return const Loading(
              color: secondaryTextColor,
            );
          }

          if (state.isSuccess) {
            users.clear();
            users.addAll(state.data as List<User>);
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: users.length,
                    padding: const EdgeInsets.only(bottom: 80),
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (_, index) {
                      final user = users[index];

                      return UserCardItem(
                        user: user,
                        onTap: () => navigatorKey.currentState!.push(
                          MaterialPageRoute(
                            builder: (context) => UserDetailPage(user: user),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class UserCardItem extends StatelessWidget {
  final User user;
  final VoidCallback? onTap;
  const UserCardItem({
    super.key,
    required this.user,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellContainer(
      border: Border.all(
        color: primaryColor,
        width: 3,
      ),
      padding: const EdgeInsets.all(12),
      borderRadiusGeometry: const BorderRadius.only(
        topRight: Radius.circular(32),
      ),
      containerBackgroundColor: scaffoldColor,
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 72,
            height: 72,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: secondaryTextColor,
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                strokeAlign: BorderSide.strokeAlignOutside,
                color: primaryColor,
              ),
            ),
            child: user.profileImage == null
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
                : CachedNetworkImage(
                    imageUrl: user.profileImage!,
                    placeholder: (_, __) => const Padding(
                      padding: EdgeInsets.all(12),
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
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium,
                ),
                Text(
                  user.email ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium!.copyWith(
                    color: primaryTextColor,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        user.stdCode ?? '',
                        style: textTheme.bodyMedium!.copyWith(
                          color: primaryTextColor,
                        ),
                      ),
                    ),
                    Text(
                      user.role ?? '',
                      style: textTheme.bodyMedium!.copyWith(
                        color: user.role == 'ADMIN' ? dangerColor : infoColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
