import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unischedule_app/core/usecases/no_params.dart';
import 'package:unischedule_app/features/domain/usecases/get_activities_by_user.dart';
import 'package:unischedule_app/features/presentation/user/activity_history/bloc/activity_history_state.dart';

class ActivityHistoryCubit extends Cubit<ActivityHistoryState> {
  GetActivitiesByUser getActivitiesByUser;
  ActivityHistoryCubit(this.getActivitiesByUser)
      : super(ActivityHistoryState.initial());

  void getUserActivities() async {
    emit(ActivityHistoryState.inProgress());

    final result = await getActivitiesByUser(NoParams());

    result.fold(
      (l) => emit(ActivityHistoryState.failure(l.message)),
      (r) => emit(ActivityHistoryState.success(data: r)),
    );
  }
}
