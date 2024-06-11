class EmailVerificationState<T> {
  final bool isInitial;
  final bool isInProgress;
  final bool isFailure;

  final bool isResendSuccess;
  final bool isPinCorrect;

  final String? message;
  final T? data;

  const EmailVerificationState({
    this.isInitial = false,
    this.isInProgress = false,
    this.isFailure = false,
    this.isResendSuccess = false,
    this.isPinCorrect = false,
    this.message = '',
    this.data,
  });

  factory EmailVerificationState.initial() =>
      const EmailVerificationState(isInitial: true);

  factory EmailVerificationState.inProgress() =>
      const EmailVerificationState(isInProgress: true);

  factory EmailVerificationState.failure(String? message) =>
      EmailVerificationState(isFailure: true, message: message);

  factory EmailVerificationState.resendSuccess({required T data}) =>
      EmailVerificationState(isResendSuccess: true, data: data);

  factory EmailVerificationState.isPinCorrect({required T data}) =>
      EmailVerificationState(isPinCorrect: true, data: data);
}
