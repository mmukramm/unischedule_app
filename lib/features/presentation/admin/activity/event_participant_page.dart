import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/core/utils/pdf_service.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';
import 'package:unischedule_app/features/presentation/widget/ink_well_container.dart';

class EventParticipantPage extends StatefulWidget {
  const EventParticipantPage({super.key});

  @override
  State<EventParticipantPage> createState() => _EventParticipantPageState();
}

class _EventParticipantPageState extends State<EventParticipantPage> {
  late final PdfService pdfService;

  @override
  void initState() {
    super.initState();
    pdfService = PdfService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Daftar Peserta',
        withBackButton: true,
      ),
      backgroundColor: backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final dir = await getApplicationDocumentsDirectory();
          debugPrint(dir.path);

          final result = await pdfService.generateParticipantPdf();

          pdfService.savePdfFile("testpdf", result);
        },
        shape: const RoundedRectangleBorder(),
        backgroundColor: primaryColor,
        child: SvgPicture.asset(
          AssetPath.getIcons('pdf-box.svg'),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
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
                height: 32,
              ),
              Text(
                'Daftar Peserta',
                style: textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWellContainer(
                border: Border.all(
                  color: primaryColor,
                  width: 3,
                ),
                padding: const EdgeInsets.all(12),
                borderRadiusGeometry: const BorderRadius.only(
                  topRight: Radius.circular(32),
                ),
                containerBackgroundColor: scaffoldColor,
                onTap: () {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: secondaryTextColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2,
                          color: primaryColor,
                        ),
                      ),
                      child: Padding(
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
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hamid Al-Hafidzurrahman Aljabbar",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleMedium,
                          ),
                          Text(
                            "Mthfdz",
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
                                  "19028492837",
                                  style: textTheme.bodyMedium!.copyWith(
                                    color: primaryTextColor,
                                  ),
                                ),
                              ),
                              Text(
                                "Mahasiswa",
                                style: textTheme.bodyMedium!.copyWith(
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
