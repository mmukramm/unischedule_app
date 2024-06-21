import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/core/utils/const.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/core/utils/date_formatter.dart';
import 'package:unischedule_app/features/data/models/post.dart';
import 'package:unischedule_app/core/enums/snack_bar_type.dart';
import 'package:unischedule_app/core/utils/credential_saver.dart';
import 'package:unischedule_app/core/extensions/context_extension.dart';
import 'package:unischedule_app/features/presentation/widget/loading.dart';
import 'package:unischedule_app/features/presentation/common/image_view_page.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';
import 'package:unischedule_app/features/presentation/bloc/user_activity_detail/user_activity_detail_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/user_activity_detail/user_activity_detail_state.dart';

class UserActivityDetailPage extends StatefulWidget {
  final Post activity;
  final bool isRegistered;
  const UserActivityDetailPage({
    super.key,
    required this.activity,
    this.isRegistered = false,
  });

  @override
  State<UserActivityDetailPage> createState() => _UserActivityDetailPageState();
}

class _UserActivityDetailPageState extends State<UserActivityDetailPage> {
  late final UserActivityDetailCubit userActivityDetailCubit;
  late final bool isLogin;
  late final bool isEmailVerified;

  @override
  void initState() {
    super.initState();
    userActivityDetailCubit = context.read<UserActivityDetailCubit>();
    isLogin = CredentialSaver.accessToken != null;
    isEmailVerified = (CredentialSaver.userInfo != null &&
        CredentialSaver.userInfo!.emailVerified!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Detail Postingan',
        withBackButton: true,
      ),
      body: BlocListener<UserActivityDetailCubit, UserActivityDetailState>(
        listener: (context, state) {
          if (state.isInProgress) {
            context.showLoadingDialog();
          }
          if (state.isFailure) {
            navigatorKey.currentState!.pop();
            if (state.message == kYouAlreadyRegisteredThisEvent) {
              context.showCustomSnackbar(
                message: "Anda sudah terdaftar dalam kegiatan ini",
                type: SnackBarType.primary,
              );
            } else {
              context.showCustomSnackbar(
                message: state.message!,
                type: SnackBarType.error,
              );
            }
          }
          if (state.isSuccess) {
            navigatorKey.currentState!.pop();
            context.showCustomSnackbar(
              message: state.data == 'OK'
                  ? 'Berhasil mendaftar kegiatan.'
                  : state.data,
              type: SnackBarType.success,
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Foto ${(widget.activity.isEvent ?? true) ? 'Kegiatan' : 'Mading'} ',
                  style: textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: () => navigatorKey.currentState!.push(
                    MaterialPageRoute(
                      builder: (_) => ImageViewPage(
                        imagePath: widget.activity.picture,
                      ),
                    ),
                  ),
                  child: CachedNetworkImage(
                    height: 320,
                    width: double.infinity,
                    imageUrl: widget.activity.picture ?? '',
                    placeholder: (_, __) => const Padding(
                      padding: EdgeInsets.all(12),
                      child: Loading(
                        color: secondaryTextColor,
                      ),
                    ),
                    errorWidget: (_, __, ___) => Image.asset(
                      width: double.infinity,
                      height: 320,
                      AssetPath.getImages('no-image.jpg'),
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Nama Kegiatan',
                            style: textTheme.titleMedium,
                          ),
                        ),
                        Text(
                          ':',
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            widget.activity.title ?? '',
                            style: textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Penyelenggara',
                            style: textTheme.titleMedium,
                          ),
                        ),
                        Text(
                          ':',
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            widget.activity.organizer ?? '',
                            style: textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            (widget.activity.isEvent ?? true)
                                ? 'Waktu'
                                : 'Waktu Dibuat',
                            style: textTheme.titleMedium,
                          ),
                        ),
                        Text(
                          ':',
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            formatDateTime(widget.activity.eventDate ?? ''),
                            style: textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Deskripsi',
                      style: textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      widget.activity.content ?? '',
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    if (!widget.isRegistered)
                      if (widget.activity.isEvent ?? true)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (!isLogin)
                              Text(
                                'Silahkan login terlebih dahulu',
                                textAlign: TextAlign.center,
                                style: textTheme.bodySmall!.copyWith(
                                  color: dangerColor,
                                ),
                              ),
                            if (!isEmailVerified && isLogin)
                              Text(
                                'Anda tidak bisa mendaftar sebelum email Anda aktif',
                                textAlign: TextAlign.center,
                                style: textTheme.bodySmall!.copyWith(
                                  color: dangerColor,
                                ),
                              ),
                            FilledButton(
                              onPressed: isEmailVerified && isLogin
                                  ? () {
                                      context.showCustomConfirmationDialog(
                                        title: 'Daftar Kegiatan?',
                                        message:
                                            'Apakah Anda yakin ingin mendaftar pada kegiatan ini?',
                                        primaryButtonText: 'Daftar',
                                        onTapPrimaryButton: () {
                                          navigatorKey.currentState!.pop();
                                          userActivityDetailCubit.registerEvent(
                                            widget.activity.id!,
                                          );
                                        },
                                      );
                                    }
                                  : null,
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.all(12),
                                shape: const RoundedRectangleBorder(),
                                backgroundColor: isEmailVerified && isLogin
                                    ? primaryColor
                                    : greyColor,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    AssetPath.getIcons('users-group.svg'),
                                    colorFilter: ColorFilter.mode(
                                      isEmailVerified && isLogin
                                          ? secondaryTextColor
                                          : scaffoldColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    "Daftar Kegiatan",
                                    style: textTheme.titleMedium!.copyWith(
                                      color: isEmailVerified && isLogin
                                          ? secondaryTextColor
                                          : scaffoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
