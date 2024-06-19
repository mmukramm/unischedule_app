class UserActivityDetailState<T> {
  final bool isInitial;
  final bool isInProgress;
  final bool isFailure;
  final bool isMutateDataSuccess;
  final bool isSuccess;

  final String? message;
  final T? data;

  const UserActivityDetailState({
    this.isInitial = false,
    this.isInProgress = false,
    this.isFailure = false,
    this.isSuccess = false,
    this.isMutateDataSuccess = false,
    this.message = '',
    this.data,
  });

  factory UserActivityDetailState.initial() =>
      const UserActivityDetailState(isInitial: true);

  factory UserActivityDetailState.inProgress() =>
      const UserActivityDetailState(isInProgress: true);

  factory UserActivityDetailState.failure(String? message) =>
      UserActivityDetailState(isFailure: true, message: message);

  factory UserActivityDetailState.success({required T data}) =>
      UserActivityDetailState(isSuccess: true, data: data);

  factory UserActivityDetailState.mutateDataSuccess(
          {required String message}) =>
      UserActivityDetailState(isMutateDataSuccess: true, message: message);
}
