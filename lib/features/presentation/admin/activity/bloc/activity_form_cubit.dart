import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unischedule_app/features/data/datasources/activity_data_sources.dart';
import 'package:unischedule_app/features/domain/usecases/post_activity.dart';
import 'package:unischedule_app/features/domain/usecases/put_activity.dart';
import 'package:unischedule_app/features/presentation/admin/activity/bloc/activity_management_state.dart';

class ActivityFormCubit extends Cubit<ActivityManagementState> {
  final PostActivity postActivity;
  final PutActivity putActivity;

  ActivityFormCubit(this.postActivity, this.putActivity)
      : super(ActivityManagementState.initial());

  void createActivity(CreatePostParams createPostParams) async {
    emit(ActivityManagementState.inProgress());
    final result = await postActivity(createPostParams);

    result.fold(
      (l) => emit(ActivityManagementState.failure(l.message)),
      (r) => emit(ActivityManagementState.success(data: r)),
    );
  }

  void editActivity(CreatePostParams createPostParams) async {
    emit(ActivityManagementState.inProgress());
    final result = await putActivity(createPostParams);

    result.fold(
      (l) => emit(ActivityManagementState.failure(l.message)),
      (r) => emit(ActivityManagementState.success(data: r)),
    );
  }
}
