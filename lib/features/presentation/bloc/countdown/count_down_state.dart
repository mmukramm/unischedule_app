class CountDownState {
  final bool isInitial;
  final bool isStart;
  final bool isEnd;
  int? time;
  CountDownState({
    this.isInitial = false,
    this.isStart = false,
    this.isEnd = false,
    this.time,
  });

  factory CountDownState.initial() => CountDownState(isInitial: true);
  factory CountDownState.onStart(int second) => CountDownState(
        isStart: true,
        time: second,
      );
  factory CountDownState.onEnd() => CountDownState(isInitial: true);
}
