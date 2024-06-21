import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:unischedule_app/core/utils/const.dart';
import 'package:unischedule_app/core/usecases/no_params.dart';
import 'package:unischedule_app/features/domain/usecases/get_user_info.dart';
import 'package:unischedule_app/features/domain/usecases/delete_access_token.dart';
import 'package:unischedule_app/features/presentation/bloc/profile/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  DeleteAccessToken deleteAccessToken;
  GetUserInfo getUserInfo;

  ProfileCubit(this.deleteAccessToken, this.getUserInfo)
      : super(ProfileState.initial());

  void signOut() async {
    emit(ProfileState.inProgress());
    final result = await deleteAccessToken(NoParams());

    result.fold(
      (l) => emit(ProfileState.failure(l.message)),
      (r) => emit(ProfileState.logout()),
    );
  }

  void userInfo() async {
    emit(ProfileState.inProgress());

    final result = await getUserInfo(NoParams());

    result.fold(
      (l) {
        if (l.message == kNoInternetConnection) {
          emit(ProfileState.failure(l.message));
        } else {
          emit(ProfileState.loginInfo(isLogin: false));
        }
      },
      (r) => emit(ProfileState.loginInfo(isLogin: true)),
    );
  }
}
