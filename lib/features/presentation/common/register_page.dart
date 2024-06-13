import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:unischedule_app/core/enums/gender.dart';
import 'package:unischedule_app/core/enums/snack_bar_type.dart';
import 'package:unischedule_app/core/extensions/context_extension.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/credential_saver.dart';
import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/features/data/datasources/auth_data_sources.dart';
import 'package:unischedule_app/features/presentation/bloc/sign_up/sign_up_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/sign_up/sign_up_state.dart';
import 'package:unischedule_app/features/presentation/common/email_verification_page.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';
import 'package:unischedule_app/features/presentation/widget/custom_password_text_field.dart';
import 'package:unischedule_app/features/presentation/widget/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormBuilderState>();
  late final ValueNotifier<bool> isPasswordSame;
  late final SignUpCubit signUpCubit;
  late String password;

  @override
  void initState() {
    super.initState();
    password = '';
    isPasswordSame = ValueNotifier(true);
    signUpCubit = context.read<SignUpCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    isPasswordSame.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: const CustomAppBar(
          withBackButton: true,
        ),
        body: SingleChildScrollView(
          child: BlocListener<SignUpCubit, SignUpState>(
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
                debugPrint('successss');
                navigatorKey.currentState!.pop();
                context.showCustomSnackbar(
                  message: 'Akun berhasil dibuat',
                  type: SnackBarType.success,
                );
                debugPrint(CredentialSaver.accessToken);
                signUpCubit.userInfo();
              }
              if (state.isLogin) {
                navigatorKey.currentState!.pop();
                navigatorKey.currentState!.pop();
                navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
                  builder: (context) => EmailVerificationPage(
                    isSend: true,
                    message:
                        'Pin terkirim ke email ${CredentialSaver.userInfo!.email}',
                  ),
                ));
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Register",
                    style: textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  FormBuilder(
                    key: formKey,
                    child: Column(
                      children: [
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
                          name: 'email',
                          labelText: 'Email',
                          hintText: 'Email',
                          validators: [
                            FormBuilderValidators.required(
                              errorText: 'Bagian ini harus diisi',
                            ),
                            FormBuilderValidators.email(
                              errorText: 'Format tidak sesuai',
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
                          textInputType: TextInputType.number,
                          validators: [
                            FormBuilderValidators.required(
                              errorText: 'Bagian ini harus diisi',
                            ),
                            FormBuilderValidators.numeric(
                              errorText: 'Format tidak sesuai',
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        genderSelector(),
                        const SizedBox(
                          height: 20,
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
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (formKey.currentState!.saveAndValidate()) {
                          final value = formKey.currentState!.value;
                          if (value['password'] != value['confirmPassword']) {
                            return;
                          }
                          debugPrint(value.toString());
                          final signUpParams = SignUpParams(
                            name: value['name'],
                            stdCode: value['nim'],
                            gender: value['gender'] == Gender.male
                                ? 'MALE'
                                : 'FEMALE',
                            email: value['email'],
                            phoneNumber: value['phone'],
                            password: value['password'],
                          );
                          signUpCubit.signUp(signUpParams);
                        }
                      },
                      style: FilledButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                        backgroundColor: primaryColor,
                      ),
                      child: Text(
                        'Register',
                        style: textTheme.bodyMedium!.copyWith(
                          color: primaryTextColor,
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

  // ValueListenableBuilder<Gender> genderSelector() => ValueListenableBuilder(
  //       valueListenable: genderType,
  //       builder: (_, value, __) {
  //         return Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             RichText(
  //               text: TextSpan(
  //                 style: textTheme.bodyMedium,
  //                 children: const [
  //                   TextSpan(text: 'Jenis Kelamin'),
  //                   TextSpan(
  //                     text: '*',
  //                     style: TextStyle(color: dangerColor),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             FormBuilderRadioGroup<Gender>(
  //               name: 'gender',
  //               decoration: const InputDecoration(
  //                 border: InputBorder.none,
  //               ),
  //               options: const [
  //                 FormBuilderFieldOption(
  //                   value: Gender.male,
  //                   child: Text('Laki-Laki'),
  //                 ),
  //                 FormBuilderFieldOption(
  //                   value: Gender.female,
  //                   child: Text('Perempuan'),
  //                 ),
  //               ],
  //               validator: FormBuilderValidators.compose([
  //                 FormBuilderValidators.required(
  //                   errorText: 'Bagian ini harus diisi',
  //                 ),
  //               ]),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  // ValueListenableBuilder<Gender> genderSelector() => ValueListenableBuilder(
  //       valueListenable: genderType,
  //       builder: (_, value, __) {
  //         return Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             RichText(
  //               text: TextSpan(
  //                 style: textTheme.bodyMedium,
  //                 children: const [
  //                   TextSpan(text: 'Jenis Kelamin'),
  //                   TextSpan(
  //                     text: '*',
  //                     style: TextStyle(color: dangerColor),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Row(
  //               children: [
  //                 Expanded(
  //                   child: RadioListTile<Gender>(
  //                     title: Text(
  //                       'Laki-laki',
  //                       style: textTheme.bodyMedium,
  //                     ),
  //                     value: Gender.male,
  //                     contentPadding: const EdgeInsets.all(0),
  //                     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //                     groupValue: value,
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(12),
  //                     ),
  //                     activeColor: secondaryTextColor,
  //                     splashRadius: 20,
  //                     fillColor: WidgetStateProperty.all(
  //                       secondaryTextColor,
  //                     ),
  //                     onChanged: (result) {
  //                       genderType.value = result!;
  //                     },
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: RadioListTile<Gender>(
  //                     title: Text(
  //                       'Perempuan',
  //                       style: textTheme.bodyMedium,
  //                     ),
  //                     value: Gender.female,
  //                     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //                     contentPadding: const EdgeInsets.all(0),
  //                     groupValue: value,
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(12),
  //                     ),
  //                     activeColor: secondaryTextColor,
  //                     splashRadius: 20,
  //                     fillColor: MaterialStateProperty.all(
  //                       secondaryTextColor,
  //                     ),
  //                     onChanged: (result) {
  //                       genderType.value = result!;
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         );
  //       },
  //     );
}
