import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unischedule_app/core/usecases/no_params.dart';
import 'package:unischedule_app/features/domain/usecases/delete_user.dart';
import 'package:unischedule_app/features/domain/usecases/get_all_users.dart';
import 'package:unischedule_app/features/domain/usecases/get_single_user.dart';
import 'package:unischedule_app/features/presentation/admin/user/bloc/users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final GetAllUsers getAllUsers;
  final GetSingleUser getSingleUser;
  final DeleteUser deleteUser;
  UsersCubit(
    this.getAllUsers,
    this.getSingleUser,
    this.deleteUser,
  ) : super(UsersState.initial());

  void getUsers() async {
    emit(UsersState.inProgress());
    final result = await getAllUsers(NoParams());

    result.fold(
      (l) => emit(UsersState.failure(l.message)),
      (r) => emit(UsersState.success(data: r)),
    );
  }

  void removeUser(String id) async {
    emit(UsersState.inProgress());
    
    final result = await deleteUser(id);

    result.fold(
      (l) => emit(UsersState.failure(l.message)),
      (r) => emit(UsersState.mutateDataSuccess(message: r)),
    );
  }
}
