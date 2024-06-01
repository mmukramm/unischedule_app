import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unischedule_app/core/enums/post_type.dart';
import 'package:unischedule_app/core/extensions/context_extension.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/features/presentation/admin/post/post_detail_page.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';
import 'package:unischedule_app/features/presentation/widget/custom_selector_dialog.dart';
import 'package:unischedule_app/features/presentation/widget/ink_well_container.dart';

class PostManagementPage extends StatefulWidget {
  const PostManagementPage({super.key});

  @override
  State<PostManagementPage> createState() => _PostManagementPageState();
}

class _PostManagementPageState extends State<PostManagementPage> {
  late final ValueNotifier<PostType> postType;

  @override
  void initState() {
    super.initState();

    postType = ValueNotifier(PostType.all);
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
              SelectorDialogParams(label: 'Kegiatan', onTap: (){}),
              SelectorDialogParams(label: 'Mading', onTap: (){}),
            ]
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
                valueListenable: postType,
                builder: (context, value, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SegmentedButton<PostType>(
                        style: SegmentedButton.styleFrom(
                          side: const BorderSide(color: primaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          foregroundColor: scaffoldColor,
                          selectedBackgroundColor: scaffoldColor,
                          backgroundColor: backgroundColor,
                        ),
                        segments: const [
                          ButtonSegment(
                            value: PostType.all,
                            label: Text("Semua"),
                          ),
                          ButtonSegment(
                            value: PostType.event,
                            label: Text("Kegiatan"),
                          ),
                          ButtonSegment(
                            value: PostType.magz,
                            label: Text("Mading"),
                          ),
                        ],
                        selected: {value},
                        showSelectedIcon: false,
                        onSelectionChanged: (selection) {
                          postType.value = selection.first;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      DropdownButton(
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
                        value: "Aktif",
                        onChanged: (value) {},
                        dropdownColor: primaryColor,
                        borderRadius: BorderRadius.circular(12),
                        isExpanded: true,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        padding: const EdgeInsets.only(bottom: 40),
                        itemBuilder: (context, index) {
                          return InkWellContainer(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(bottom: 12),
                            containerBackgroundColor: scaffoldColor,
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
                                        builder: (_) => const PostDetailPage(),
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
