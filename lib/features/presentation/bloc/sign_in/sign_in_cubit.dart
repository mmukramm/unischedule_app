import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unischedule_app/features/domain/usecases/post_sign_in.dart';
import 'package:unischedule_app/features/presentation/bloc/sign_in/sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  PostSignIn postSignIn;
  SignInCubit(this.postSignIn) : super(SignInState.initial());

  void signIn(Map<String, String> params) async {
    emit(SignInState.inProgress());
    final result = await postSignIn(params);

    result.fold(
      (l) => emit(SignInState.failure(l.message)),
      (r) => emit(SignInState.success(data: r)),
    );
  }
}
