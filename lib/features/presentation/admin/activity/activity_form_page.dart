import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unischedule_app/core/enums/snack_bar_type.dart';
import 'package:unischedule_app/core/extensions/context_extension.dart';
import 'package:unischedule_app/core/extensions/date_time_extension.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/theme/theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/core/utils/date_formatter.dart';
import 'package:unischedule_app/core/utils/image_service.dart';
import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/features/data/datasources/activity_data_sources.dart';
import 'package:unischedule_app/features/data/models/post.dart';
import 'package:unischedule_app/features/presentation/admin/activity/bloc/activity_detail_cubit.dart';
import 'package:unischedule_app/features/presentation/admin/activity/bloc/activity_form_cubit.dart';
import 'package:unischedule_app/features/presentation/admin/activity/bloc/activity_management_cubit.dart';
import 'package:unischedule_app/features/presentation/admin/activity/bloc/activity_management_state.dart';
import 'package:unischedule_app/features/presentation/common/image_view_page.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';
import 'package:unischedule_app/features/presentation/widget/custom_text_field.dart';
import 'package:unischedule_app/features/presentation/widget/ink_well_container.dart';
import 'package:unischedule_app/features/presentation/widget/loading.dart';

class ActivityFormPage extends StatefulWidget {
  final bool isMagz;
  final bool isEdit;
  final Post? activity;
  const ActivityFormPage({
    super.key,
    required this.isMagz,
    required this.isEdit,
    this.activity,
  });

  @override
  State<ActivityFormPage> createState() => ActivityFormPageState();
}

class ActivityFormPageState extends State<ActivityFormPage> {
  final formKey = GlobalKey<FormBuilderState>();
  late final ValueNotifier<String?> postImagePath;
  late DateTime dateTime;
  late final ActivityFormCubit activityFormCubit;

  @override
  void initState() {
    super.initState();

    postImagePath = ValueNotifier(null);
    dateTime = DateTime.now().toUtc();
    activityFormCubit = context.read<ActivityFormCubit>();

    if (widget.activity != null) {
      dateTime = DateTime.parse(widget.activity!.eventDate!);
    }
  }

  @override
  void dispose() {
    super.dispose();

    postImagePath.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.isEdit
            ? 'Edit ${widget.isMagz ? 'Mading' : 'Kegiatan'}'
            : 'Tambah ${widget.isMagz ? 'Mading' : 'Kegiatan'}',
        withBackButton: true,
      ),
      body: BlocListener<ActivityFormCubit, ActivityManagementState>(
        listener: (context, state) {
          if (state.isInProgress) {
            context.showLoadingDialog();
          }

          if (state.isFailure) {
            navigatorKey.currentState!.pop();
            context.showCustomSnackbar(
              message: state.message!,
              type: SnackBarType.error,
            );
          }
          if (state.isSuccess) {
            navigatorKey.currentState!.pop();
            navigatorKey.currentState!.pop();
            context.showCustomSnackbar(
              message: state.data,
              type: SnackBarType.success,
            );
            context.read<ActivityManagementCubit>().getAllPosts();
            if (widget.activity != null) {
              context
                  .read<ActivityDetailCubit>()
                  .getActivity(widget.activity!.id!);
            }
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Foto ${widget.isMagz ? 'Mading' : 'Kegiatan'}',
                    textAlign: TextAlign.center,
                    style: textTheme.headlineSmall!.copyWith(
                      color: primaryTextColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: 3 / 2,
                        child: ValueListenableBuilder(
                          valueListenable: postImagePath,
                          builder: (context, value, _) {
                            if (widget.activity != null) {
                              if (value == null) {
                                return InkWell(
                                  onTap: () => navigatorKey.currentState!.push(
                                    MaterialPageRoute(
                                      builder: (_) => ImageViewPage(
                                        imagePath: value,
                                      ),
                                    ),
                                  ),
                                  child: CachedNetworkImage(
                                    height: 320,
                                    width: double.infinity,
                                    imageUrl: widget.activity!.picture!,
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
                                );
                              } else {
                                return InkWell(
                                  onTap: () => navigatorKey.currentState!.push(
                                    MaterialPageRoute(
                                      builder: (_) => ImageViewPage(
                                        imagePath: value,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(File(value)),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                );
                              }
                            }

                            if (value == null) {
                              return Container(
                                decoration: const BoxDecoration(
                                  color: secondaryTextColor,
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
                              );
                            } else {
                              return InkWell(
                                onTap: () => navigatorKey.currentState!.push(
                                  MaterialPageRoute(
                                    builder: (_) => ImageViewPage(
                                      imagePath: value,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(File(value)),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: InkWellContainer(
                          splashColor: Colors.transparent,
                          onTap: () {
                            showActionModalBottomSheet(context);
                          },
                          child: Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: highlightTextColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: primaryColor,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: SvgPicture.asset(
                                width: 80,
                                AssetPath.getIcons('pencil.svg'),
                                colorFilter: const ColorFilter.mode(
                                  primaryColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  FormBuilder(
                    key: formKey,
                    child: widget.isMagz ? buildMagzForm() : buildEventForm(),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                      ),
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();

                        debugPrint(dateTime.toIso8601String());

                        if (formKey.currentState!.saveAndValidate()) {
                          final formValue = formKey.currentState!.value;

                          debugPrint(formValue.toString());

                          CreatePostParams createPostParams;

                          if (widget.isMagz) {
                            if (widget.isEdit) {
                              createPostParams = CreatePostParams(
                                id: widget.activity?.id,
                                title: formValue['magzName'],
                                content: formValue['description'],
                                organizer: formValue['organizer'],
                                eventDate: widget.activity?.eventDate,
                                isEvent: !widget.isMagz,
                                file: postImagePath.value != null
                                    ? File(postImagePath.value!)
                                    : null,
                              );
                              activityFormCubit.editActivity(createPostParams);
                            } else {
                              createPostParams = CreatePostParams(
                                title: formValue['magzName'],
                                content: formValue['description'],
                                organizer: formValue['organizer'],
                                eventDate:
                                    DateTime.now().toUtc().toIso8601String(),
                                isEvent: !widget.isMagz,
                                file: File(postImagePath.value!),
                              );
                              activityFormCubit
                                  .createActivity(createPostParams);
                            }
                          } else {
                            if (widget.isEdit) {
                              createPostParams = CreatePostParams(
                                id: widget.activity!.id,
                                title: formValue['eventName'] != ''
                                    ? formValue['eventName']
                                    : null,
                                content: formValue['description'] != ''
                                    ? formValue['description']
                                    : null,
                                organizer: formValue['organizer'] != ''
                                    ? formValue['organizer']
                                    : null,
                                eventDate: formValue['eventTime'] != ''
                                    ? dateTime.toIso8601String()
                                    : null,
                                isEvent: !widget.isMagz,
                                file: postImagePath.value != null
                                    ? File(postImagePath.value!)
                                    : null,
                              );
                              activityFormCubit.editActivity(createPostParams);
                            } else {
                              createPostParams = CreatePostParams(
                                title: formValue['eventName'],
                                content: formValue['description'],
                                organizer: formValue['organizer'],
                                eventDate: formValue['eventTime'] != ''
                                    ? dateTime.toIso8601String()
                                    : null,
                                isEvent: !widget.isMagz,
                                file: File(postImagePath.value!),
                              );
                              activityFormCubit
                                  .createActivity(createPostParams);
                            }
                          }
                        }
                      },
                      child: Text(
                        'Submit',
                        style: textTheme.titleMedium!.copyWith(
                          color: secondaryTextColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column buildMagzForm() {
    return Column(
      children: [
        CustomTextField(
          labelText: 'Nama Mading',
          name: 'magzName',
          initialValue: widget.activity != null ? widget.activity!.title : '',
          hintText: 'Nama Mading',
          validators: [
            FormBuilderValidators.required(
              errorText: 'Bagian ini harus diisi',
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        CustomTextField(
          labelText: 'Penyelenggara',
          name: 'organizer',
          initialValue:
              widget.activity != null ? widget.activity!.organizer : '',
          hintText: 'Nama Penyelenggara',
          validators: [
            FormBuilderValidators.required(
              errorText: 'Bagian ini harus diisi',
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        CustomTextField(
          labelText: 'Deskripsi',
          name: 'description',
          initialValue: widget.activity != null ? widget.activity!.content : '',
          hintText: 'Deskripsi',
          maxLines: 3,
          validators: [
            FormBuilderValidators.required(
              errorText: 'Bagian ini harus diisi',
            ),
          ],
        ),
      ],
    );
  }

  Column buildEventForm() {
    return Column(
      children: [
        CustomTextField(
          labelText: 'Nama Kegiatan',
          name: 'eventName',
          initialValue: widget.activity != null ? widget.activity!.title : '',
          hintText: 'Nama Kegiatan',
          validators: [
            FormBuilderValidators.required(
              errorText: 'Bagian ini harus diisi',
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        CustomTextField(
          labelText: 'Penyelenggara',
          name: 'organizer',
          initialValue:
              widget.activity != null ? widget.activity!.organizer : '',
          hintText: 'Nama Penyelenggara',
          validators: [
            FormBuilderValidators.required(
              errorText: 'Bagian ini harus diisi',
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        CustomTextField(
          labelText: 'Waktu',
          name: 'eventTime',
          initialValue: widget.activity != null
              ? formatDateTime(widget.activity!.eventDate ?? '')
              : '',
          readOnly: true,
          hintText: 'Waktu Kegiatan',
          textInputType: TextInputType.none,
          validators: [
            FormBuilderValidators.required(
              errorText: 'Bagian ini harus diisi',
            ),
          ],
          onTap: showEventDatePicker,
        ),
        const SizedBox(
          height: 24,
        ),
        CustomTextField(
          labelText: 'Deskripsi',
          name: 'description',
          initialValue: widget.activity != null ? widget.activity!.content : '',
          hintText: 'Deskripsi',
          maxLines: 3,
          validators: [
            FormBuilderValidators.required(
              errorText: 'Bagian ini harus diisi',
            ),
          ],
        ),
      ],
    );
  }

  Future<void> showActionModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      enableDrag: false,
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          enableDrag: false,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                    leading: const Icon(
                      Icons.photo_camera_outlined,
                      color: secondaryTextColor,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    title: Text(
                      'Buka Kamera',
                      style: textTheme.bodyMedium!.copyWith(
                        color: secondaryTextColor,
                      ),
                    ),
                    onTap: () async {
                      await selectPostPicture(ImageSource.camera);
                    },
                    visualDensity: const VisualDensity(vertical: -2),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                    leading: const Icon(
                      Icons.photo_library_outlined,
                      color: secondaryTextColor,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    title: Text(
                      'Pilih Gambar dari Galeri',
                      style: textTheme.bodyMedium!.copyWith(
                        color: secondaryTextColor,
                      ),
                    ),
                    onTap: () async {
                      await selectPostPicture(ImageSource.gallery);
                    },
                    visualDensity: const VisualDensity(vertical: -2),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> selectPostPicture(
    ImageSource imageSource,
  ) async {
    final path = await ImageService.pickImage(imageSource);

    if (path != null) {
      final compressedImagePath = await ImageService.cropImage(
        imagePath: path,
      );

      if (compressedImagePath != null) {
        postImagePath.value = compressedImagePath;
        navigatorKey.currentState!.pop();
      }
    }
  }

  Future<void> showEventDatePicker() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(dateTime.year - 50),
      lastDate: DateTime(dateTime.year + 50),
      initialEntryMode: DatePickerEntryMode.calendar,
      helpText: 'Pilih Tanggal Kegiatan',
      locale: const Locale('id', 'ID'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: colorScheme.copyWith(
              primary: secondaryTextColor,
              onPrimary: primaryColor,
              background: scaffoldColor,
              onBackground: secondaryTextColor,
              surface: scaffoldColor,
              onSurface: primaryTextColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate == null) return;

    if (!context.mounted) return;

    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'Pilih Waktu',
      initialEntryMode: TimePickerEntryMode.inputOnly,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: colorScheme.copyWith(
              primary: secondaryTextColor,
              onPrimary: primaryColor,
              surface: scaffoldColor,
              onSurface: primaryTextColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedTime == null) return;

    dateTime = selectedDate.copyWith(
        hour: selectedTime.hour,
        minute: selectedTime.minute,
        second: 00,
        isUtc: true);

    debugPrint(dateTime.toIso8601String());

    final value = dateTime.toStringPattern('dd MMMM yyyy HH:mm');

    formKey.currentState!.fields['eventTime']!.didChange(value);
  }
}
