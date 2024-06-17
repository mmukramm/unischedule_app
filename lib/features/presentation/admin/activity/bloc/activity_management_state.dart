class ActivityManagementState<T> {
  final bool isInitial;
  final bool isInProgress;
  final bool isFailure;
  final bool isMutateDataSuccess;
  final bool isSuccess;

  final String? message;
  final T? data;

  const ActivityManagementState({
    this.isInitial = false,
    this.isInProgress = false,
    this.isFailure = false,
    this.isSuccess = false,
    this.isMutateDataSuccess = false,
    this.message = '',
    this.data,
  });

  factory ActivityManagementState.initial() => const ActivityManagementState(isInitial: true);

  factory ActivityManagementState.inProgress() => const ActivityManagementState(isInProgress: true);

  factory ActivityManagementState.failure(String? message) =>
      ActivityManagementState(isFailure: true, message: message);

  factory ActivityManagementState.success({required T data}) =>
      ActivityManagementState(isSuccess: true, data: data);

  factory ActivityManagementState.mutateDataSuccess({required String message}) =>
      ActivityManagementState(isMutateDataSuccess: true, message: message);
}