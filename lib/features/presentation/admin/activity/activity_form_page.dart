import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unischedule_app/core/extensions/date_time_extension.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/theme/theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/core/utils/image_service.dart';
import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/features/presentation/common/image_view_page.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';
import 'package:unischedule_app/features/presentation/widget/custom_text_field.dart';
import 'package:unischedule_app/features/presentation/widget/ink_well_container.dart';

class ActivityFormPage extends StatefulWidget {
  final bool isMagz;
  final bool isEdit;
  const ActivityFormPage({
    super.key,
    required this.isMagz,
    required this.isEdit,
  });

  @override
  State<ActivityFormPage> createState() => ActivityFormPageState();
}

class ActivityFormPageState extends State<ActivityFormPage> {
  final formKey = GlobalKey<FormBuilderState>();
  late final ValueNotifier<String?> postImagePath;
  late DateTime dateTime;

  @override
  void initState() {
    super.initState();

    postImagePath = ValueNotifier(null);
    dateTime = DateTime.now();
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
      body: SingleChildScrollView(
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
                    onPressed: () {},
                    child: Text(
                      'Submit',
                      style: textTheme.titleMedium!.copyWith(
                        color: secondaryTextColor,
                      ),
                    ),
                  ),
                ),
              ],
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
          hintText: 'Deskripsi',
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

    if (selectedTime == null) return;

    dateTime = selectedDate.copyWith(
      hour: selectedTime.hour,
      minute: selectedTime.minute,
    );

    debugPrint(dateTime.toString());

    final value = dateTime.toStringPattern('dd MMMM yyyy HH:mm');

    formKey.currentState!.fields['eventTime']!.didChange(value);
  }
}
