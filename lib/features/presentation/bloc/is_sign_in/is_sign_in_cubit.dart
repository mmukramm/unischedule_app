import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unischedule_app/core/usecases/no_params.dart';
import 'package:unischedule_app/features/domain/usecases/get_user_info.dart';
import 'package:unischedule_app/features/presentation/bloc/is_sign_in/is_sign_in_state.dart';

class IsSignInCubit extends Cubit<IsSignInState> {
  GetUserInfo getUserInfo;

  IsSignInCubit(this.getUserInfo):super(IsSignInState.initial());

  void userInfo() async {
    emit(IsSignInState.inProgress());

    final result = await getUserInfo(NoParams());

    result.fold(
      (l) => emit(IsSignInState.failure(l.message)),
      (r) => emit(IsSignInState.success(data: r)),
    );
  }
}