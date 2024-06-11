import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unischedule_app/core/usecases/no_params.dart';
import 'package:unischedule_app/features/data/datasources/auth_datasources.dart';
import 'package:unischedule_app/features/domain/usecases/get_user_info.dart';
import 'package:unischedule_app/features/domain/usecases/post_sign_up.dart';
import 'package:unischedule_app/features/presentation/bloc/sign_up/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final PostSignUp postSignUp;
  final GetUserInfo getUserInfo;

  SignUpCubit(this.postSignUp, this.getUserInfo) : super(SignUpState.initial());

  void signUp(SignUpParams signUpParams) async {
    emit(SignUpState.inProgress());

    final result = await postSignUp(signUpParams.toMap());

    result.fold(
      (l) => emit(SignUpState.failure(l.message)),
      (r) => emit(SignUpState.success(data: r)),
    );
  }

  void userInfo() async {
    emit(SignUpState.inProgress());

    final result = await getUserInfo(NoParams());

    result.fold(
      (l) => emit(SignUpState.failure(l.message)),
      (r) => emit(SignUpState.login()),
    );
  }
}
