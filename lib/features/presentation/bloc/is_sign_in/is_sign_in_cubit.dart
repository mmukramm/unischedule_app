import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:unischedule_app/core/usecases/no_params.dart';
import 'package:unischedule_app/features/domain/usecases/get_user_info.dart';
import 'package:unischedule_app/features/domain/usecases/post_register_fcp_token.dart';
import 'package:unischedule_app/features/presentation/bloc/is_sign_in/is_sign_in_state.dart';

class IsSignInCubit extends Cubit<IsSignInState> {
  GetUserInfo getUserInfo;
  PostRegisterFcpToken postRegisterFcpToken;

  IsSignInCubit(this.getUserInfo, this.postRegisterFcpToken)
      : super(IsSignInState.initial());

  void registerFcpToken(String fcmToken) async {
    emit(IsSignInState.inProgress());
    final result = await postRegisterFcpToken(fcmToken);
    result.fold(
      (l) => emit(IsSignInState.failure(l.message)),
      (r) => emit(IsSignInState.fcmTokenChange(r)),
    );
  }

  void userInfo() async {
    emit(IsSignInState.inProgress());

    final result = await getUserInfo(NoParams());

    result.fold(
      (l) => emit(IsSignInState.failure(l.message)),
      (r) => emit(IsSignInState.success(data: r)),
    );
  }
}
