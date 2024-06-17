import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unischedule_app/core/usecases/no_params.dart';
import 'package:unischedule_app/features/domain/usecases/get_posts.dart';
import 'package:unischedule_app/features/presentation/admin/activity/bloc/activity_management_state.dart';

class ActivityManagementCubit extends Cubit<ActivityManagementState> {
  final GetPosts getPosts;

  ActivityManagementCubit(this.getPosts)
      : super(ActivityManagementState.initial());

  void getAllPosts() async {
    emit(ActivityManagementState.inProgress());

    final result = await getPosts(NoParams());

    result.fold(
      (l) => emit(ActivityManagementState.failure(l.message)),
      (r) => emit(ActivityManagementState.success(data: r)),
    );
  }
}
