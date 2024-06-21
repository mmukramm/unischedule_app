import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:unischedule_app/core/usecases/no_params.dart';
import 'package:unischedule_app/features/domain/usecases/post_verification_email.dart';
import 'package:unischedule_app/features/domain/usecases/get_resend_email_verification.dart';
import 'package:unischedule_app/features/presentation/bloc/email_verification/email_verification_state.dart';

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  GetResendEmailVerification getResendEmailVerification;
  PostVerificationEmail postVerificationEmail;
  EmailVerificationCubit(
      this.getResendEmailVerification, this.postVerificationEmail)
      : super(EmailVerificationState.inProgress());

  void resendEmailVerification() async {
    emit(EmailVerificationState.inProgress());

    final result = await getResendEmailVerification(NoParams());

    result.fold(
      (l) => emit(EmailVerificationState.failure(l.message)),
      (r) => emit(EmailVerificationState.resendSuccess(data: r)),
    );
  }

  void sendPin(String pin) async {
    emit(EmailVerificationState.inProgress());

    final result = await postVerificationEmail({'pin': pin});

    result.fold(
      (l) => emit(EmailVerificationState.failure(l.message)),
      (r) => emit(EmailVerificationState.isPinCorrect(data: r)),
    );
  }
}
