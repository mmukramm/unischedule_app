import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/features/presentation/admin/post/event_participant_page.dart';
import 'package:unischedule_app/features/presentation/common/image_view_page.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Detail Postingan',
        withBackButton: true,
        withDeleteButton: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Text(
                'Foto Kegiatan',
                style: textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () => navigatorKey.currentState!.push(
                  MaterialPageRoute(
                    builder: (_) => const ImageViewPage(),
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 320,
                  child: Image.asset(
                    AssetPath.getImages('sample.png'),
                    fit: BoxFit.cover,
                  ),
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
                          'Sosialisasi Pertukaran Mahasiswa Merdeka 2023',
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
                          'Kemahasiswaan',
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
                          'Waktu',
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
                          '30 Juli 2024 18:00',
                          style: textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FilledButton(
                    onPressed: () => navigatorKey.currentState!.push(
                      MaterialPageRoute(
                        builder: (_) => const EventParticipantPage(),
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
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus eu neque vitae tortor rhoncus suscipit. Vivamus gravida neque et purus vulputate dictum.',
                    style: textTheme.bodySmall,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
