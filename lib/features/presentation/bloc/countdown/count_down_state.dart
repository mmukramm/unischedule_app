class CountDownState {
  final bool isInitial;
  final bool isStart;
  final bool isEnd;
  final int? time;
  const CountDownState({
    this.isInitial = false,
    this.isStart = false,
    this.isEnd = false,
    this.time,
  });

  factory CountDownState.initial() => const CountDownState(isInitial: true);
  factory CountDownState.onStart() => const CountDownState(isStart: true);
  factory CountDownState.onEnd() => const CountDownState(isInitial: true);
}
