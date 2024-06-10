import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unischedule_app/features/data/datasources/auth_datasources.dart';
import 'package:unischedule_app/features/domain/usecases/post_sign_up.dart';
import 'package:unischedule_app/features/presentation/bloc/sign_up/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final PostSignUp postSignUp;

  SignUpCubit(this.postSignUp) : super(SignUpState.initial());

  void signUp(SignUpParams signUpParams) async {
    emit(SignUpState.inProgress());
    
    final result = await postSignUp(signUpParams.toMap());

    result.fold(
      (l) => emit(SignUpState.failure(l.message)),
      (r) => emit(SignUpState.success(data: r)),
    );
  }
}
