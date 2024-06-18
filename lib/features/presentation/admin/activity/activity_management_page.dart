import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unischedule_app/core/enums/activity_type.dart';
import 'package:unischedule_app/core/enums/snack_bar_type.dart';
import 'package:unischedule_app/core/extensions/context_extension.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/core/utils/date_formatter.dart';
import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/features/data/models/post.dart';
import 'package:unischedule_app/features/presentation/admin/activity/activity_detail_page.dart';
import 'package:unischedule_app/features/presentation/admin/activity/activity_form_page.dart';
import 'package:unischedule_app/features/presentation/admin/activity/bloc/activity_management_cubit.dart';
import 'package:unischedule_app/features/presentation/admin/activity/bloc/activity_management_state.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';
import 'package:unischedule_app/features/presentation/widget/custom_selector_dialog.dart';
import 'package:unischedule_app/features/presentation/widget/loading.dart';

class ActivityManagementPage extends StatefulWidget {
  const ActivityManagementPage({super.key});

  @override
  State<ActivityManagementPage> createState() => ActivityManagementPageState();
}

class ActivityManagementPageState extends State<ActivityManagementPage> {
  late final ValueNotifier<ActivityType> activityType;
  late final ValueNotifier<String> eventStatus;
  late final ActivityManagementCubit activityManagementCubit;
  late final List<Post> activities;

  @override
  void initState() {
    super.initState();

    activityType = ValueNotifier(ActivityType.all);
    eventStatus = ValueNotifier('Aktif');

    activities = [];

    activityManagementCubit = context.read<ActivityManagementCubit>();

    activityManagementCubit.getAllPosts();
  }

  @override
  void dispose() {
    super.dispose();

    activityType.dispose();
    eventStatus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Kelola Postingan",
        withBackButton: true,
      ),
      backgroundColor: backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.showCustomSelectorDialog(
            title: 'Pilih Tipe',
            message: 'Pilih tipe postingan',
            items: [
              SelectorDialogParams(
                label: 'Kegiatan',
                onTap: () {
                  navigatorKey.currentState!.pop();
                  navigatorKey.currentState!.push(
                    MaterialPageRoute(
                      builder: (_) =>
                          const ActivityFormPage(isMagz: false, isEdit: false),
                    ),
                  );
                },
              ),
              SelectorDialogParams(
                label: 'Mading',
                onTap: () {
                  navigatorKey.currentState!.pop();
                  navigatorKey.currentState!.push(
                    MaterialPageRoute(
                      builder: (_) => const ActivityFormPage(
                        isMagz: true,
                        isEdit: false,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 24,
              ),
              ValueListenableBuilder(
                valueListenable: activityType,
                builder: (context, activityTypeValue, _) =>
                    ValueListenableBuilder(
                  valueListenable: eventStatus,
                  builder: (context, eventStatusValue, _) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SegmentedButton<ActivityType>(
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
                            value: ActivityType.all,
                            label: Text("Semua"),
                          ),
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
                      const SizedBox(
                        height: 16,
                      ),
                      activityTypeValue == ActivityType.event
                          ? DropdownButton(
                              underline: const Divider(
                                thickness: 2,
                                height: 0,
                                color: primaryColor,
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: "Aktif",
                                  child: Text("Aktif"),
                                ),
                                DropdownMenuItem(
                                  value: "Riwayat",
                                  child: Text("Riwayat"),
                                ),
                              ],
                              value: eventStatusValue,
                              onChanged: (result) {
                                eventStatus.value = result!;
                              },
                              dropdownColor: primaryColor,
                              borderRadius: BorderRadius.circular(12),
                              isExpanded: true,
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 24,
                      ),
                      BlocConsumer<ActivityManagementCubit,
                          ActivityManagementState>(
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
                            return const Loading(
                              color: secondaryTextColor,
                            );
                          }

                          if (state.isSuccess) {
                            final result = state.data as List<Post>;
                            List<Post> data;

                            if (activityTypeValue == ActivityType.event) {
                              data = result.where((element) {
                                final now = DateTime.now();
                                if (eventStatusValue == 'Aktif') {
                                  return element.isEvent! &&
                                      now.isBefore(
                                        DateTime.parse(element.eventDate!),
                                      );
                                }
                                return element.isEvent! &&
                                    now.isAfter(
                                        DateTime.parse(element.eventDate!));
                              }).toList();
                            } else if (activityTypeValue == ActivityType.magz) {
                              data = result
                                  .where((element) => !element.isEvent!)
                                  .toList();
                            } else {
                              data = result;
                            }

                            activities.clear();
                            activities.addAll(data);
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: activities.length,
                            padding: const EdgeInsets.only(bottom: 40),
                            itemBuilder: (context, index) {
                              final activity = activities[index];

                              return ActivityItemCard(
                                item: activity,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActivityItemCard extends StatelessWidget {
  final Post item;
  const ActivityItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      color: scaffoldColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CachedNetworkImage(
            height: 240,
            width: double.infinity,
            imageUrl: item.picture!,
            placeholder: (_, __) => const Padding(
              padding: EdgeInsets.all(12),
              child: Loading(
                color: secondaryTextColor,
              ),
            ),
            errorWidget: (_, __, ___) => Image.asset(
              width: double.infinity,
              height: 240,
              AssetPath.getImages('no-image.jpg'),
              fit: BoxFit.cover,
            ),
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            item.title ?? '',
            textAlign: TextAlign.start,
            style: textTheme.titleMedium,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            item.content ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodySmall!.copyWith(
              color: highlightTextColor,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AssetPath.getIcons('calendar.svg'),
                      width: 20,
                      colorFilter: const ColorFilter.mode(
                        highlightTextColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      formatDateTime(item.eventDate ?? ''),
                      style: textTheme.bodySmall!.copyWith(
                        color: highlightTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AssetPath.getIcons('category.svg'),
                      width: 20,
                      colorFilter: const ColorFilter.mode(
                        highlightTextColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      item.isEvent ?? false ? 'Kegiatan' : 'Mading',
                      style: textTheme.bodySmall!.copyWith(
                        color: highlightTextColor,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => navigatorKey.currentState!.push(
                MaterialPageRoute(
                  builder: (_) => ActivityDetailPage(
                    postId: item.id!,
                  ),
                ),
              ),
              style: FilledButton.styleFrom(
                  backgroundColor: infoColor,
                  shape: const RoundedRectangleBorder()),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    AssetPath.getIcons('eye.svg'),
                    colorFilter: const ColorFilter.mode(
                      scaffoldColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text("Detail"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
