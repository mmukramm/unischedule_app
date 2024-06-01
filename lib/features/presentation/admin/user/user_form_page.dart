import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unischedule_app/core/enums/gender.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/core/utils/image_service.dart';
import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/features/data/models/user.dart';
import 'package:unischedule_app/features/presentation/common/image_view_page.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';
import 'package:unischedule_app/features/presentation/widget/custom_text_field.dart';
import 'package:unischedule_app/features/presentation/widget/ink_well_container.dart';

class UserFormPage extends StatefulWidget {
  final bool isEdit;
  final bool isAdmin;
  final User? user;

  const UserFormPage({
    super.key,
    this.user,
    this.isEdit = false,
    required this.isAdmin,
  });

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final formKey = GlobalKey<FormBuilderState>();
  late final ValueNotifier<Gender> genderType;
  late final ValueNotifier<String?> imagePath;

  @override
  void initState() {
    super.initState();
    genderType = ValueNotifier(Gender.initial);
    imagePath = ValueNotifier(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.isEdit
            ? 'Edit ${widget.isAdmin ? 'Admin' : 'User'}'
            : 'Tambah ${widget.isAdmin ? 'Admin' : 'User'}',
        withBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Foto Profil',
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall!.copyWith(
                    color: primaryTextColor,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: imagePath,
                      builder: (context, value, _) {
                        return value == null
                            ? Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                  color: secondaryTextColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 3,
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
                              )
                            : InkWell(
                                onTap: () {
                                  navigatorKey.currentState!.push(
                                    MaterialPageRoute(
                                      builder: (_) => ImageViewPage(
                                        imagePath: value,
                                      ),
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(500),
                                child: Container(
                                  width: 160,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 3,
                                      color: primaryColor,
                                    ),
                                    image: DecorationImage(
                                      image: FileImage(File(value)),
                                    ),
                                  ),
                                ),
                              );
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
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
                  height: 24,
                ),
                FormBuilder(
                  key: formKey,
                  child: Column(
                    children: [
                      if (!widget.isAdmin)
                        CustomTextField(
                          name: 'nim',
                          labelText: 'NIM',
                          hintText: 'Nomor Induk Mahasiswa',
                          validators: [
                            FormBuilderValidators.required(
                              errorText: 'Bagian ini harus diisi',
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        name: 'name',
                        labelText: 'Nama Lengkap',
                        hintText: 'Nama Lengkap',
                        validators: [
                          FormBuilderValidators.required(
                            errorText: 'Bagian ini harus diisi',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        name: 'phone',
                        labelText: 'Nomor Telepon',
                        hintText: 'Nomor Telepon',
                        validators: [
                          FormBuilderValidators.required(
                            errorText: 'Bagian ini harus diisi',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        name: 'email',
                        labelText: 'Email',
                        hintText: 'Email',
                        validators: [
                          FormBuilderValidators.required(
                            errorText: 'Bagian ini harus diisi',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                genderSelector(),
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
                      await selectProfilePicture(ImageSource.camera);
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
                      await selectProfilePicture(ImageSource.gallery);
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

  Future<void> selectProfilePicture(
    ImageSource imageSource,
  ) async {
    final path = await ImageService.pickImage(imageSource);

    if (path != null) {
      final compressedImagePath = await ImageService.cropImage(
        imagePath: path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      );

      if (compressedImagePath != null) {
        imagePath.value = compressedImagePath;
        navigatorKey.currentState!.pop();
      }
    }
  }

  ValueListenableBuilder<Gender> genderSelector() => ValueListenableBuilder(
        valueListenable: genderType,
        builder: (_, value, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: textTheme.bodyMedium,
                  children: const [
                    TextSpan(text: 'Jenis Kelamin'),
                    TextSpan(
                      text: '*',
                      style: TextStyle(color: dangerColor),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<Gender>(
                      title: Text(
                        'Laki-laki',
                        style: textTheme.bodyMedium,
                      ),
                      value: Gender.male,
                      contentPadding: const EdgeInsets.all(0),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      groupValue: value,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      activeColor: secondaryTextColor,
                      splashRadius: 20,
                      fillColor: MaterialStateProperty.all(
                        secondaryTextColor,
                      ),
                      onChanged: (result) {
                        genderType.value = result!;
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<Gender>(
                      title: Text(
                        'Perempuan',
                        style: textTheme.bodyMedium,
                      ),
                      value: Gender.female,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      contentPadding: const EdgeInsets.all(0),
                      groupValue: value,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      activeColor: secondaryTextColor,
                      splashRadius: 20,
                      fillColor: MaterialStateProperty.all(
                        secondaryTextColor,
                      ),
                      onChanged: (result) {
                        genderType.value = result!;
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
}
