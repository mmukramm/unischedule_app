import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unischedule_app/core/enums/gender.dart';
import 'package:unischedule_app/core/enums/snack_bar_type.dart';
import 'package:unischedule_app/core/extensions/context_extension.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/core/utils/image_service.dart';
import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/features/data/datasources/user_data_sources.dart';
import 'package:unischedule_app/features/data/models/user.dart';
import 'package:unischedule_app/features/presentation/admin/user/bloc/users_cubit.dart';
import 'package:unischedule_app/features/presentation/admin/user/bloc/user_form_cubit.dart';
import 'package:unischedule_app/features/presentation/admin/user/bloc/user_form_state.dart';
import 'package:unischedule_app/features/presentation/common/image_view_page.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';
import 'package:unischedule_app/features/presentation/widget/custom_password_text_field.dart';
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
  late final UserFormCubit userFormCubit;
  late final ValueNotifier<bool> isPasswordSame;
  late String password;

  @override
  void initState() {
    super.initState();

    genderType = ValueNotifier(Gender.initial);
    imagePath = ValueNotifier(null);
    password = '';
    isPasswordSame = ValueNotifier(true);
    userFormCubit = context.read<UserFormCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    genderType.dispose();
    imagePath.dispose();
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
      body: BlocListener<UserFormCubit, UserFormState>(
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
            context.showCustomSnackbar(
              message: state.data! as String,
              type: SnackBarType.success,
            );
            context.read<UsersCubit>().getUsers();
            navigatorKey.currentState!.pop();
          }
        },
        child: SingleChildScrollView(
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
                            initialValue: widget.user?.stdCode,
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
                          initialValue: widget.user?.name,
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
                          initialValue: widget.user?.phoneNumber,
                          hintText: 'Nomor Telepon',
                          textInputType: TextInputType.phone,
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
                          initialValue: widget.user?.email,
                          hintText: 'Email',
                          validators: [
                            FormBuilderValidators.required(
                              errorText: 'Bagian ini harus diisi',
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        genderSelector(),
                        const SizedBox(
                          height: 24,
                        ),
                        CustomPasswordTextField(
                          name: 'password',
                          hintText: '********',
                          labelText: 'Password',
                          onChanged: (result) {
                            password = result!;
                          },
                          validators: [
                            FormBuilderValidators.required(
                              errorText: 'Bagian ini harus diisi',
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ValueListenableBuilder(
                          valueListenable: isPasswordSame,
                          builder: (context, value, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomPasswordTextField(
                                  name: 'confirmPassword',
                                  hintText: '********',
                                  labelText: 'Konfirmasi Password',
                                  onChanged: (result) {
                                    isPasswordSame.value = password == result!;
                                  },
                                  validators: [
                                    FormBuilderValidators.required(
                                      errorText: 'Bagian ini harus diisi',
                                    ),
                                  ],
                                ),
                                if (!value)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Password dan konfirmasi password tidak sama',
                                        textAlign: TextAlign.start,
                                        style: textTheme.bodySmall!
                                            .copyWith(color: dangerColor),
                                      ),
                                    ],
                                  ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
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
                        if (formKey.currentState!.saveAndValidate()) {
                          final value = formKey.currentState!.value;
                          if (value['password'] != value['confirmPassword']) {
                            return;
                          }

                          debugPrint(value.toString());

                          final createUserParams = CreateUserParams(
                            name: value['name'],
                            stdCode: value['nim'],
                            gender: value['gender'] == Gender.male
                                ? 'MALE'
                                : 'FEMALE',
                            email: value['email'],
                            phoneNumber: value['phone'],
                            password: value['password'],
                            role: widget.isAdmin ? 'ADMIN' : 'USER',
                            picture: imagePath.value,
                          );

                          userFormCubit.createUser(createUserParams);
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
                ],
              ),
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

  Column genderSelector() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          SizedBox(
            width: double.infinity,
            child: FormBuilderRadioGroup<Gender>(
              name: 'gender',
              initialValue:
                  widget.user?.gender == 'MALE' ? Gender.male : Gender.female,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              options: const [
                FormBuilderFieldOption(
                  value: Gender.male,
                  child: Text('Laki-Laki'),
                ),
                FormBuilderFieldOption(
                  value: Gender.female,
                  child: Text('Perempuan'),
                ),
              ],
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                  errorText: 'Bagian ini harus diisi',
                ),
              ]),
            ),
          ),
        ],
      );
}
