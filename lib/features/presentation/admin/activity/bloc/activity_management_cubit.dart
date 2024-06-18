import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unischedule_app/core/usecases/no_params.dart';
import 'package:unischedule_app/features/domain/usecases/get_activities.dart';
import 'package:unischedule_app/features/presentation/admin/activity/bloc/activity_management_state.dart';

class ActivityManagementCubit extends Cubit<ActivityManagementState> {
  final GetActivities getActivities;

  ActivityManagementCubit(this.getActivities)
      : super(ActivityManagementState.initial());

  void getAllPosts() async {
    emit(ActivityManagementState.inProgress());

    final result = await getActivities(NoParams());

    result.fold(
      (l) => emit(ActivityManagementState.failure(l.message)),
      (r) => emit(ActivityManagementState.success(data: r)),
    );
  }
}
