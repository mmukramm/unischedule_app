import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:unischedule_app/core/enums/gender.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/features/presentation/common/email_verification_page.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';
import 'package:unischedule_app/features/presentation/widget/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormBuilderState>();
  late final ValueNotifier<Gender> genderType;

  @override
  void initState() {
    super.initState();
    genderType = ValueNotifier(Gender.initial);
  }

  @override
  void dispose() {
    super.dispose();
    genderType.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        withBackButton: true,
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
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              genderSelector(),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    navigatorKey.currentState!.push(
                      MaterialPageRoute(
                        builder: (context) => const EmailVerificationPage(),
                      )
                    );
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
    );
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
