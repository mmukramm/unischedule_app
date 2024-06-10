class SignUpState<T> {
  final bool isInitial;
  final bool isInProgress;
  final bool isFailure;
  final bool isSuccess;

  final String? message;
  final T? data;

  const SignUpState({
    this.isInitial = false,
    this.isInProgress = false,
    this.isFailure = false,
    this.isSuccess = false,
    this.message = '',
    this.data,
  });

  factory SignUpState.initial() => const SignUpState(isInitial: true);

  factory SignUpState.inProgress() => const SignUpState(isInProgress: true);

  factory SignUpState.failure(String? message) =>
      SignUpState(isFailure: true, message: message);

  factory SignUpState.success({required T data}) =>
      SignUpState(isSuccess: true, data: data);
}
