class ActivityHistoryState<T> {
  final bool isInitial;
  final bool isInProgress;
  final bool isFailure;
  final bool isMutateDataSuccess;
  final bool isSuccess;

  final String? message;
  final T? data;

  const ActivityHistoryState({
    this.isInitial = false,
    this.isInProgress = false,
    this.isFailure = false,
    this.isSuccess = false,
    this.isMutateDataSuccess = false,
    this.message = '',
    this.data,
  });

  factory ActivityHistoryState.initial() => const ActivityHistoryState(isInitial: true);

  factory ActivityHistoryState.inProgress() => const ActivityHistoryState(isInProgress: true);

  factory ActivityHistoryState.failure(String? message) =>
      ActivityHistoryState(isFailure: true, message: message);

  factory ActivityHistoryState.success({required T data}) =>
      ActivityHistoryState(isSuccess: true, data: data);

  factory ActivityHistoryState.mutateDataSuccess({required String message}) =>
      ActivityHistoryState(isMutateDataSuccess: true, message: message);
}