import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unischedule_app/features/domain/usecases/get_post_participants.dart';
import 'package:unischedule_app/features/presentation/admin/activity/bloc/activity_management_state.dart';

class EventParticipantCubit extends Cubit<ActivityManagementState> {
  GetPostParticipants getPostParticipants;

  EventParticipantCubit(this.getPostParticipants)
      : super(ActivityManagementState.initial());

  void getPostWithParticipants(String postId) async {
    emit(ActivityManagementState.inProgress());
    final result = await getPostParticipants(postId);

    result.fold(
      (l) => emit(ActivityManagementState.failure(l.message)),
      (r) => emit(ActivityManagementState.success(data: r)),
    );
  }
}
