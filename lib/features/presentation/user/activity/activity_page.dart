import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/core/enums/activity_type.dart';
import 'package:unischedule_app/core/utils/date_formatter.dart';
import 'package:unischedule_app/features/data/models/post.dart';
import 'package:unischedule_app/core/enums/snack_bar_type.dart';
import 'package:unischedule_app/core/extensions/context_extension.dart';
import 'package:unischedule_app/features/presentation/widget/data_empty.dart';
import 'package:unischedule_app/features/presentation/widget/loading.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';
import 'package:unischedule_app/features/presentation/widget/ink_well_container.dart';
import 'package:unischedule_app/features/presentation/common/user_activity_detail_page.dart';
import 'package:unischedule_app/features/presentation/user/activity/bloc/activity_cubit.dart';
import 'package:unischedule_app/features/presentation/user/activity/bloc/activity_state.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  late final ActivityCubit activityCubit;
  late final ValueNotifier<ActivityType> activityType;
  late final List<Post> activities;
  @override
  void initState() {
    super.initState();
    activityCubit = context.read<ActivityCubit>();

    activityType = ValueNotifier(ActivityType.event);

    activityCubit.getAllActivities();
    activities = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        withBackButton: false,
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 24,
            ),
            // Text(
            //   "Daftar Kegiatan Aktif",
            //   textAlign: TextAlign.center,
            //   style: textTheme.titleLarge!,
            // ),
            // const SizedBox(
            //   height: 12,
            // ),
            ValueListenableBuilder(
              valueListenable: activityType,
              builder: (context, activityTypeValue, _) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        width: double.infinity,
                        child: SegmentedButton<ActivityType>(
                          style: SegmentedButton.styleFrom(
                            side: const BorderSide(color: primaryColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            foregroundColor: scaffoldColor,
                            selectedBackgroundColor: scaffoldColor,
                            backgroundColor: highlightTextColor,
                          ),
                          segments: const [
                            ButtonSegment(
                              value: ActivityType.event,
                              label: Text("Kegiatan"),
                            ),
                            ButtonSegment(
                              value: ActivityType.magz,
                              label: Text("Mading"),
                            ),
                          ],
                          selected: {activityTypeValue},
                          showSelectedIcon: false,
                          onSelectionChanged: (selection) {
                            activityType.value = selection.first;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    BlocConsumer<ActivityCubit, ActivityState>(
                      listener: (context, state) {
                        if (state.isFailure) {
                          context.showCustomSnackbar(
                            message: state.message!,
                            type: SnackBarType.error,
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state.isInProgress) {
                          return const Column(
                            children: [
                              SizedBox(height: 24),
                              Loading(
                                color: secondaryTextColor,
                              ),
                            ],
                          );
                        }

                        if (state.isSuccess) {
                          activities.clear();
                          final data = state.data as List<Post>;

                          if (activityTypeValue == ActivityType.event) {
                            data.sort(
                              (a, b) => a.eventDate!.compareTo(b.eventDate!),
                            );
                          } else {
                            data.sort(
                              (a, b) => b.eventDate!.compareTo(a.eventDate!),
                            );
                          }

                          activities.addAll(
                            data.where(
                              (element) {
                                final now = DateTime.now();
                                if (activityTypeValue == ActivityType.event) {
                                  return element.isEvent! &&
                                      !now.isAfter(
                                          DateTime.parse(element.eventDate!));
                                }
                                return !element.isEvent!;
                              },
                            ),
                          );

                          if (activities.isEmpty) {
                            return const DataEmpty(
                              message: 'Tidak ada aktivitas.',
                            );
                          }
                        }

                        return Padding(
                          padding: const EdgeInsets.all(12),
                          child: StaggeredGrid.count(
                            crossAxisCount: 8,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            children: List.generate(
                              activities.length,
                              (index) {
                                final activity = activities[index];
                                return StaggeredGridTile.fit(
                                  crossAxisCellCount: 4,
                                  child: InkWellContainer(
                                    padding: const EdgeInsets.all(8),
                                    onTap: () {
                                      navigatorKey.currentState!.push(
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              UserActivityDetailPage(
                                            activity: activity,
                                          ),
                                        ),
                                      );
                                    },
                                    containerBackgroundColor: scaffoldColor,
                                    child: Column(
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 12 / 11,
                                          child: CachedNetworkImage(
                                            width: double.infinity,
                                            imageUrl: activity.picture!,
                                            placeholder: (_, __) =>
                                                const Padding(
                                              padding: EdgeInsets.all(12),
                                              child: Loading(
                                                color: secondaryTextColor,
                                              ),
                                            ),
                                            errorWidget: (_, __, ___) =>
                                                Image.asset(
                                              width: double.infinity,
                                              height: 240,
                                              AssetPath.getImages(
                                                  'no-image.jpg'),
                                              fit: BoxFit.cover,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          activity.title ?? '',
                                          maxLines: 3,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme.titleSmall!.copyWith(
                                            color: primaryTextColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              AssetPath.getIcons(
                                                  'category.svg'),
                                              width: 16,
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                highlightTextColor,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              activity.isEvent ?? false
                                                  ? 'Kegiatan'
                                                  : 'Mading',
                                              style:
                                                  textTheme.bodySmall!.copyWith(
                                                color: highlightTextColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              AssetPath.getIcons(
                                                  'calendar.svg'),
                                              width: 16,
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                highlightTextColor,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Expanded(
                                              child: Text(
                                                formatDateTime(
                                                  activity.eventDate ?? '',
                                                ),
                                                style: textTheme.bodySmall!
                                                    .copyWith(
                                                  color: highlightTextColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
