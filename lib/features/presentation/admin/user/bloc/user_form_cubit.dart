import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unischedule_app/features/data/datasources/user_data_sources.dart';
import 'package:unischedule_app/features/domain/usecases/post_user.dart';
import 'package:unischedule_app/features/domain/usecases/put_user.dart';
import 'package:unischedule_app/features/presentation/admin/user/bloc/user_form_state.dart';

class UserFormCubit extends Cubit<UserFormState> {
  final PostUser postUser;
  final PutUser putUser;
  UserFormCubit(this.postUser, this.putUser) : super(UserFormState.initial());

  void createUser(CreateUserParams createUserParams) async {
    emit(UserFormState.inProgress());

    final result = await postUser(createUserParams);

    result.fold(
      (l) => emit(UserFormState.failure(l.message)),
      (r) => emit(UserFormState.success(data: r)),
    );
  }

  void updateUser(CreateUserParams createUserParams) async {
    emit(UserFormState.inProgress());

    final result = await putUser(createUserParams);

    result.fold(
      (l) => emit(UserFormState.failure(l.message)),
      (r) => emit(UserFormState.success(data: r)),
    );
  }


}
