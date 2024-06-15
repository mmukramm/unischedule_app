class UserFormState<T> {
  final bool isInitial;
  final bool isInProgress;
  final bool isFailure;
  final bool isSuccess;

  final String? message;
  final T? data;

  const UserFormState({
    this.isInitial = false,
    this.isInProgress = false,
    this.isFailure = false,
    this.isSuccess = false,
    this.message = '',
    this.data,
  });

  factory UserFormState.initial() => const UserFormState(isInitial: true);

  factory UserFormState.inProgress() => const UserFormState(isInProgress: true);

  factory UserFormState.failure(String? message) =>
      UserFormState(isFailure: true, message: message);

  factory UserFormState.success({required T data}) =>
      UserFormState(isSuccess: true, data: data);
}
