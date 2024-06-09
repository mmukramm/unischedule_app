class IsSignInState<T> {
  final bool isInitial;
  final bool isInProgress;
  final bool isFailure;
  final bool isSuccess;

  final String? message;
  final T? data;

  const IsSignInState({
    this.isInitial = false,
    this.isInProgress = false,
    this.isFailure = false,
    this.isSuccess = false,
    this.message = '',
    this.data,
  });

  factory IsSignInState.initial() => const IsSignInState(isInitial: true);

  factory IsSignInState.inProgress() => const IsSignInState(isInProgress: true);

  factory IsSignInState.failure(String? message) =>
      IsSignInState(isFailure: true, message: message);

  factory IsSignInState.success({required T data}) =>
      IsSignInState(isSuccess: true, data: data);
}
