import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unischedule_app/core/enums/activity_type.dart';
import 'package:unischedule_app/core/extensions/context_extension.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/features/presentation/admin/activity/activity_detail_page.dart';
import 'package:unischedule_app/features/presentation/admin/activity/activity_form_page.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';
import 'package:unischedule_app/features/presentation/widget/custom_selector_dialog.dart';

class ActivityManagementPage extends StatefulWidget {
  const ActivityManagementPage({super.key});

  @override
  State<ActivityManagementPage> createState() => ActivityManagementPageState();
}

class ActivityManagementPageState extends State<ActivityManagementPage> {
  late final ValueNotifier<ActivityType> activityType;
  late final ValueNotifier<String> eventStatus;

  @override
  void initState() {
    super.initState();

    activityType = ValueNotifier(ActivityType.all);
    eventStatus = ValueNotifier('Aktif');
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
                builder: (context, value, _) {
                  return Column(
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
                        selected: {value},
                        showSelectedIcon: false,
                        onSelectionChanged: (selection) {
                          activityType.value = selection.first;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      value == ActivityType.event
                          ? ValueListenableBuilder(
                              valueListenable: eventStatus,
                              builder: (context, value, _) {
                                return DropdownButton(
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
                                  value: value,
                                  onChanged: (result) {
                                    eventStatus.value = result!;
                                  },
                                  dropdownColor: primaryColor,
                                  borderRadius: BorderRadius.circular(12),
                                  isExpanded: true,
                                );
                              },
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 24,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        padding: const EdgeInsets.only(bottom: 40),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(bottom: 12),
                            color: scaffoldColor,
                            child: Column(
                              children: [
                                Image.asset(
                                  width: double.infinity,
                                  height: 240,
                                  AssetPath.getImages('sample.png'),
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  "Merdeka Belajar Kampus Merdeka (MBKM) Program Kompetisi Kampus Merdeka (PKKM) 2023.",
                                  style: textTheme.titleMedium,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus condimentum justo nisi, a vestibulum justo tempor ut. Nam fringilla orci sed odio tempus consequat. Aenean lorem nisi, vulputate eget convallis vitae, hendrerit id elit. Nulla sollicitudin id sem et pulvinar. Morbi erat tortor, gravida euismod ante vitae, sodales tempus elit.",
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
                                            "12 Februari 2024 18:00",
                                            style:
                                                textTheme.bodySmall!.copyWith(
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
                                            "Mading",
                                            style:
                                                textTheme.bodySmall!.copyWith(
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
                                    onPressed: () =>
                                        navigatorKey.currentState!.push(
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const ActivityDetailPage(),
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
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
