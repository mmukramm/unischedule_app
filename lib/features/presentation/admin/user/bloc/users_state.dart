class UsersState<T> {
  final bool isInitial;
  final bool isInProgress;
  final bool isFailure;
  final bool isMutateDataSuccess;
  final bool isSuccess;

  final String? message;
  final T? data;

  const UsersState({
    this.isInitial = false,
    this.isInProgress = false,
    this.isFailure = false,
    this.isSuccess = false,
    this.isMutateDataSuccess = false,
    this.message = '',
    this.data,
  });

  factory UsersState.initial() => const UsersState(isInitial: true);

  factory UsersState.inProgress() => const UsersState(isInProgress: true);

  factory UsersState.failure(String? message) =>
      UsersState(isFailure: true, message: message);

  factory UsersState.success({required T data}) =>
      UsersState(isSuccess: true, data: data);

  factory UsersState.mutateDataSuccess({required String message}) =>
      UsersState(isSuccess: true, message: message);
}
