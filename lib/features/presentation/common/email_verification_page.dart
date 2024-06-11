import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:unischedule_app/core/enums/snack_bar_type.dart';
import 'package:unischedule_app/core/extensions/context_extension.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/credential_saver.dart';
import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/features/presentation/bloc/countdown/count_down_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/email_verification/email_verification_cubit.dart';
import 'package:unischedule_app/features/presentation/bloc/email_verification/email_verification_state.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';
import 'package:unischedule_app/features/presentation/widget/custom_text_field.dart';
import 'package:unischedule_app/features/presentation/widget/ink_well_container.dart';

class EmailVerificationPage extends StatefulWidget {
  final bool isSend;
  final String? message;
  const EmailVerificationPage({
    super.key,
    required this.isSend,
    this.message,
  });

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage>
    with AfterLayoutMixin {
  final formKey = GlobalKey<FormBuilderState>();
  late final CountDownCubit countDown;
  late final EmailVerificationCubit emailVerificationCubit;

  @override
  void initState() {
    super.initState();
    countDown = context.read<CountDownCubit>();
    emailVerificationCubit = context.read<EmailVerificationCubit>();
    widget.isSend ? null : emailVerificationCubit.resendEmailVerification();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        countDown.pauseTimer();
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          withBackButton: true,
        ),
        body: BlocListener<EmailVerificationCubit, EmailVerificationState>(
          listener: (context, state) {
            if (state.isInProgress) {
              context.showLoadingDialog();
            }
            if (state.isFailure) {
              context.showCustomSnackbar(
                message: state.message!,
                type: SnackBarType.error,
              );
            }
            if (state.isResendSuccess) {
              context.showCustomSnackbar(
                message:
                    'Pin berhasil dikirim ulang ke email: ${CredentialSaver.userInfo?.email}',
                type: SnackBarType.success,
              );
              countDown.startCountDown(second: 123);
            }
            if (state.isPinCorrect) {
              context.showCustomSnackbar(
                message: 'Email berhasil diverifikasi',
                type: SnackBarType.success,
              );
              navigatorKey.currentState!.pop();
            }
          },
          child: Padding(
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
                      'Silahkan cek kotak masuk pada email yang telah Anda daftarkan. Masukan kode yang dikirimkan melalui email Anda.',
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
                            textInputType: TextInputType.number,
                            isRequired: false,
                            validators: [
                              FormBuilderValidators.required(
                                errorText: 'Bagian ini harus diisi',
                              ),
                              FormBuilderValidators.numeric(
                                errorText: 'Format tidak sesuai',
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
                    BlocConsumer<CountDownCubit, int>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: InkWellContainer(
                                borderRadiusGeometry: BorderRadius.circular(4),
                                splashColor: highlightTextColor,
                                onTap: state == 0
                                    ? () {
                                        emailVerificationCubit
                                            .resendEmailVerification();
                                      }
                                    : null,
                                child: Text(
                                  'Kirim ulang kode ${state != 0 ? 'dalam: \n$state' : ''}',
                                  textAlign: TextAlign.center,
                                  style: textTheme.titleMedium!.copyWith(
                                    color: state == 0
                                        ? secondaryTextColor
                                        : highlightTextColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (formKey.currentState!.saveAndValidate()) {
                            final value = formKey.currentState!.value;
                            emailVerificationCubit.sendPin(value['code']);
                          }
                        },
                        style: FilledButton.styleFrom(
                          shape: const RoundedRectangleBorder(),
                          backgroundColor: primaryColor,
                        ),
                        child: Text(
                          'Submit',
                          style: textTheme.bodyMedium!.copyWith(
                            color: primaryTextColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    if (widget.message != null) {
      context.showCustomSnackbar(
        message: widget.message!,
        type: SnackBarType.success,
      );

      countDown.startCountDown(second: 123);
    }
  }
}
