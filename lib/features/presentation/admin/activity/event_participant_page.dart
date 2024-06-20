import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unischedule_app/core/enums/snack_bar_type.dart';
import 'package:unischedule_app/core/extensions/context_extension.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/core/utils/date_formatter.dart';
import 'package:unischedule_app/core/utils/pdf_name_generator.dart';
import 'package:unischedule_app/core/utils/pdf_service.dart';
import 'package:unischedule_app/features/data/models/activity_participant.dart';
import 'package:unischedule_app/features/presentation/admin/activity/bloc/activity_management_state.dart';
import 'package:unischedule_app/features/presentation/admin/activity/bloc/event_participant_cubit.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';
import 'package:unischedule_app/features/presentation/widget/ink_well_container.dart';
import 'package:unischedule_app/features/presentation/widget/loading.dart';

class EventParticipantPage extends StatefulWidget {
  final String postId;
  const EventParticipantPage({
    super.key,
    required this.postId,
  });

  @override
  State<EventParticipantPage> createState() => _EventParticipantPageState();
}

class _EventParticipantPageState extends State<EventParticipantPage> {
  late final PdfService pdfService;
  late final EventParticipantCubit eventParticipantCubit;
  late ActivityParticipant activityParticipant;

  @override
  void initState() {
    super.initState();
    pdfService = PdfService();
    eventParticipantCubit = context.read<EventParticipantCubit>();
    eventParticipantCubit.getPostWithParticipants(widget.postId);
    activityParticipant = ActivityParticipant();
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
          if (activityParticipant.participants == null) {
            context.showCustomSnackbar(
              message: 'Gagal mengolah data, silahkan coba lagi.',
              type: SnackBarType.error,
            );
            return;
          }

          final result = await pdfService
              .generateParticipantPdf(activityParticipant.participants);

          pdfService.savePdfFile(
              pdfNameGenerator(activityParticipant.organizer ?? ''), result);
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
        child: BlocConsumer<EventParticipantCubit, ActivityManagementState>(
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
                  SizedBox(
                    height: 40,
                  ),
                  Loading(
                    color: secondaryTextColor,
                  ),
                ],
              );
            }

            if (state.isSuccess) {
              activityParticipant = state.data as ActivityParticipant;
            }

            return Padding(
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
                          activityParticipant.title ?? '',
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
                          activityParticipant.organizer ?? '',
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
                          formatDateTime(activityParticipant.eventDate ?? ''),
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
                  ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 80),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final participant =
                          activityParticipant.participants?[index];
                      return InkWellContainer(
                        border: Border.all(
                            color: primaryColor,
                            width: 3,
                            strokeAlign: BorderSide.strokeAlignOutside),
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
                                    participant?.name ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.titleMedium,
                                  ),
                                  Text(
                                    participant?.email ?? '',
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
                                          participant?.stdCode ??
                                              'Not Available',
                                          style: textTheme.bodyMedium!.copyWith(
                                            color: primaryTextColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        participant?.gender == 'MALE'
                                            ? 'Laki-laki'
                                            : 'Perempuan',
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
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 12,
                    ),
                    itemCount: activityParticipant.participants?.length ?? 0,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
