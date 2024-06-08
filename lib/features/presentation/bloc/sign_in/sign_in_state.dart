class SignInState<T> {
  final bool isInitial;
  final bool isInProgress;
  final bool isFailure;
  final bool isSuccess;

  final String? message;
  final T? data;

  const SignInState({
    this.isInitial = false,
    this.isInProgress = false,
    this.isFailure = false,
    this.isSuccess = false,
    this.message = '',
    this.data,
  });

  factory SignInState.initial() => const SignInState(isInitial: true);

  factory SignInState.inProgress() => const SignInState(isInProgress: true);

  factory SignInState.failure(String? message) =>
      SignInState(isFailure: true, message: message);

  factory SignInState.success({required T data}) =>
      SignInState(isSuccess: true, data: data);
}
