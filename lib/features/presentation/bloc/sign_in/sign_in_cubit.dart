import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unischedule_app/core/usecases/no_params.dart';
import 'package:unischedule_app/features/domain/usecases/get_user_info.dart';
import 'package:unischedule_app/features/domain/usecases/post_sign_in.dart';
import 'package:unischedule_app/features/presentation/bloc/sign_in/sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  PostSignIn postSignIn;
  GetUserInfo getUserInfo;
  SignInCubit(this.postSignIn, this.getUserInfo) : super(SignInState.initial());

  void signIn(Map<String, dynamic> params) async {
    emit(SignInState.inProgress());
    final result = await postSignIn(params);

    result.fold(
      (l) => emit(SignInState.failure(l.message)),
      (r) => emit(SignInState.success(data: r)),
    );
  }

  void userInfo() async {
    emit(SignInState.inProgress());

    final result = await getUserInfo(NoParams());

    result.fold(
      (l) => emit(SignInState.failure(l.message)),
      (r) => r ? emit(SignInState.admin()) : emit(SignInState.user()),
    );
  }
}
