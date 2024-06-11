import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class CountDownCubit extends Cubit<int> {
  Timer? _timer;
  CountDownCubit() : super(125);

  void startCountDown({
    int second = 125,
  }) {
    _timer?.cancel();
    emit(second);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        emit(state - 1);
      } else {
        timer.cancel();
      }
    });
  }

  void pauseTimer() {
    emit(123);
    _timer?.cancel();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    // return null;
    return super.close();
  }
}
