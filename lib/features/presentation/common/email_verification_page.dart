import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';
import 'package:unischedule_app/features/presentation/widget/custom_text_field.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        withBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Verifikasi Email',
                  style: textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Silahkan cek kotak masuk pada email yang telah Anda daftarkan. Masukkan kode yang dikirimkan melalui email Anda.',
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall!.copyWith(
                    color: highlightTextColor,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                FormBuilder(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        'Kode Verifikasi',
                        textAlign: TextAlign.center,
                        style: textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomTextField(
                        name: 'code',
                        hintText: 'Masukkan Kode Verifikasi',
                        textAlign: TextAlign.center,
                        isRequired: false,
                        validators: [
                          FormBuilderValidators.required(
                            errorText: 'Bagian ini harus diisi',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}
