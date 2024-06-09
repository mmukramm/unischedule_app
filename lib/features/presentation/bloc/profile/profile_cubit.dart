import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unischedule_app/core/usecases/no_params.dart';
import 'package:unischedule_app/core/utils/credential_saver.dart';
import 'package:unischedule_app/features/domain/usecases/delete_access_token.dart';
import 'package:unischedule_app/features/domain/usecases/get_user_info.dart';
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
      (r) {
        CredentialSaver.accessToken = null;
        CredentialSaver.userInfo = null;
        emit(ProfileState.logout());
      },
    );
  }

  void userInfo() async {
    emit(ProfileState.inProgress());

    final result = await getUserInfo(NoParams());

    result.fold(
      (l) => emit(ProfileState.loginInfo(isLogin: false)),
      (r) => emit(ProfileState.loginInfo(isLogin: true)),
    );
  }
}
