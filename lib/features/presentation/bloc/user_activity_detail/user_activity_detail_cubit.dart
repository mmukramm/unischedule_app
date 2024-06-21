import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:unischedule_app/features/domain/usecases/post_register_event.dart';
import 'package:unischedule_app/features/presentation/bloc/user_activity_detail/user_activity_detail_state.dart';

class UserActivityDetailCubit extends Cubit<UserActivityDetailState> {
  final PostRegisterEvent postRegisterEvent;
  UserActivityDetailCubit(this.postRegisterEvent)
      : super(UserActivityDetailState.initial());

  void registerEvent(String postId) async {
    emit(UserActivityDetailState.inProgress());
    final result = await postRegisterEvent(postId);

    result.fold(
      (l) => emit(UserActivityDetailState.failure(l.message)),
      (r) => emit(UserActivityDetailState.success(data: r)),
    );
  }
}
