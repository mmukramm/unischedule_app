import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class CountDownCubit extends Cubit<int> {
  Timer? _timer;
  final int second;
  CountDownCubit({this.second = 60}) : super(second);

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

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
