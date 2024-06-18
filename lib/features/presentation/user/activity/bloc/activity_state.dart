class ActivityState<T> {
  final bool isInitial;
  final bool isInProgress;
  final bool isFailure;
  final bool isMutateDataSuccess;
  final bool isSuccess;

  final String? message;
  final T? data;

  const ActivityState({
    this.isInitial = false,
    this.isInProgress = false,
    this.isFailure = false,
    this.isSuccess = false,
    this.isMutateDataSuccess = false,
    this.message = '',
    this.data,
  });

  factory ActivityState.initial() => const ActivityState(isInitial: true);

  factory ActivityState.inProgress() => const ActivityState(isInProgress: true);

  factory ActivityState.failure(String? message) =>
      ActivityState(isFailure: true, message: message);

  factory ActivityState.success({required T data}) =>
      ActivityState(isSuccess: true, data: data);

  factory ActivityState.mutateDataSuccess({required String message}) =>
      ActivityState(isMutateDataSuccess: true, message: message);
}