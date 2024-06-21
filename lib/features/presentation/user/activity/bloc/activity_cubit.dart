import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:unischedule_app/core/usecases/no_params.dart';
import 'package:unischedule_app/features/domain/usecases/get_activities.dart';
import 'package:unischedule_app/features/presentation/user/activity/bloc/activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  GetActivities getActivities;
  ActivityCubit(this.getActivities) : super(ActivityState.initial());

  void getAllActivities() async {
    emit(ActivityState.inProgress());

    final result = await getActivities(NoParams());

    result.fold(
      (l) => emit(ActivityState.failure(l.message)),
      (r) => emit(ActivityState.success(data: r)),
    );
  }
}
