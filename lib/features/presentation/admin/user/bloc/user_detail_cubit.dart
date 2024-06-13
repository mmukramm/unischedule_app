import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unischedule_app/features/domain/usecases/delete_user.dart';
import 'package:unischedule_app/features/presentation/admin/user/bloc/users_state.dart';

class UserDetailCubit extends Cubit<UsersState> {
  DeleteUser deleteUser;
  UserDetailCubit(this.deleteUser) : super(UsersState.initial());

  void removeUser(String id) async {
    emit(UsersState.inProgress());

    final result = await deleteUser(id);

    result.fold(
      (l) => emit(UsersState.failure(l.message)),
      (r) => emit(UsersState.mutateDataSuccess(message: r)),
    );
  }
}
