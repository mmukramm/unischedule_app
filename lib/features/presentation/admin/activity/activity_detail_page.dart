import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/core/enums/snack_bar_type.dart';
import 'package:unischedule_app/core/utils/date_formatter.dart';
import 'package:unischedule_app/features/data/models/post.dart';
import 'package:unischedule_app/core/extensions/context_extension.dart';
import 'package:unischedule_app/features/presentation/widget/loading.dart';
import 'package:unischedule_app/features/presentation/common/image_view_page.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';
import 'package:unischedule_app/features/presentation/admin/activity/activity_form_page.dart';
import 'package:unischedule_app/features/presentation/admin/activity/bloc/activity_detail_cubit.dart';
import 'package:unischedule_app/features/presentation/admin/activity/bloc/activity_management_cubit.dart';
import 'package:unischedule_app/features/presentation/admin/activity/bloc/activity_management_state.dart';
import 'package:unischedule_app/features/presentation/admin/activity/event_participant_page.dart';

class ActivityDetailPage extends StatefulWidget {
  final String postId;
  const ActivityDetailPage({
    super.key,
    required this.postId,
  });

  @override
  State<ActivityDetailPage> createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  late final ActivityDetailCubit activityDetailCubit;
  late Post activity;

  @override
  void initState() {
    super.initState();

    activityDetailCubit = context.read<ActivityDetailCubit>();
    activityDetailCubit.getActivity(widget.postId);

    activity = Post();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Detail Postingan',
        withBackButton: true,
        withDeleteButton: true,
        onTapDeleteButton: () {
          context.showCustomConfirmationDeleteDialog(
            title:
                'Hapus ${activity.isEvent ?? false ? 'Kegiatan' : 'Mading'} ini',
            message: 'Data yang dihapus tidak dapat dipulihkan kembali.',
            onTapDeleteButton: () {
              activityDetailCubit.removeActivity(widget.postId);
              navigatorKey.currentState!.pop();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (_) => ActivityFormPage(
                isMagz: !activity.isEvent!,
                isEdit: true,
                activity: activity,
              ),
            ),
          );
        },
        shape: const RoundedRectangleBorder(),
        backgroundColor: warningColor,
        child: SvgPicture.asset(
          AssetPath.getIcons('pencil.svg'),
          colorFilter: const ColorFilter.mode(
            secondaryTextColor,
            BlendMode.srcIn,
          ),
        ),
      ),
      body: BlocConsumer<ActivityDetailCubit, ActivityManagementState>(
        listener: (context, state) {
          if (state.isFailure) {
            context.showCustomSnackbar(
              message: state.message!,
              type: SnackBarType.error,
            );
          }
          if (state.isMutateDataSuccess) {
            context.showCustomSnackbar(
              message: state.message!,
              type: SnackBarType.success,
            );
            navigatorKey.currentState!.pop();
            context.read<ActivityManagementCubit>().getAllPosts();
          }
        },
        builder: (context, state) {
          if (state.isInProgress) {
            return const Loading(
              color: secondaryTextColor,
            );
          }

          if (state.isSuccess) {
            activity = state.data as Post;
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Foto ${(activity.isEvent ?? true) ? 'Kegiatan' : 'Mading'} ',
                    style: textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: () => navigatorKey.currentState!.push(
                      MaterialPageRoute(
                        builder: (_) => ImageViewPage(
                          imagePath: activity.picture,
                        ),
                      ),
                    ),
                    child: CachedNetworkImage(
                      height: 320,
                      width: double.infinity,
                      imageUrl: activity.picture ?? '',
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
                              activity.title ?? '',
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
                              activity.organizer ?? '',
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
                              (activity.isEvent ?? true) ? 'Waktu' : 'Waktu Dibuat',
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
                              formatDateTime(activity.eventDate ?? ''),
                              style: textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if ((activity.isEvent ?? true))
                        FilledButton(
                          onPressed: () => navigatorKey.currentState!.push(
                            MaterialPageRoute(
                              builder: (_) => EventParticipantPage(
                                postId: activity.id!,
                              ),
                            ),
                          ),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.all(12),
                            shape: const RoundedRectangleBorder(),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                AssetPath.getIcons('users-group.svg'),
                                colorFilter: const ColorFilter.mode(
                                  secondaryTextColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                "Lihat Pendaftar",
                                style: textTheme.titleMedium!.copyWith(
                                  color: secondaryTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Description',
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        activity.content ?? '',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
