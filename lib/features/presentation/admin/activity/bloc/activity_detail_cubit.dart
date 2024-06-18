import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unischedule_app/features/domain/usecases/delete_activity.dart';
import 'package:unischedule_app/features/domain/usecases/get_single_activity.dart';
import 'package:unischedule_app/features/presentation/admin/activity/bloc/activity_management_state.dart';

class ActivityDetailCubit extends Cubit<ActivityManagementState> {
  final GetSingleActivity getSingleActivity;
  final DeleteActivity deleteActivity;
  ActivityDetailCubit(
    this.getSingleActivity,
    this.deleteActivity,
  ) : super(ActivityManagementState.initial());

  void getActivity(String id) async {
    emit(ActivityManagementState.inProgress());

    final result = await getSingleActivity(id);

    result.fold(
      (l) => emit(ActivityManagementState.failure(l.message)),
      (r) => emit(ActivityManagementState.success(data: r)),
    );
  }

  void removeActivity(String id) async {
    emit(ActivityManagementState.inProgress());

    final result = await deleteActivity(id);

    result.fold(
      (l) => emit(ActivityManagementState.failure(l.message)),
      (r) => emit(ActivityManagementState.success(data: r)),
    );
  }

}
