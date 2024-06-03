import 'package:get_it/get_it.dart';
import 'package:unischedule_app/features/presentation/bloc/countdown/count_down_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  initBlocs();
  initUseCases();
  initRepositories();
  initDataSources();
  await initExternal();
}

void initBlocs() {
  getIt.registerFactory(() => CountDownCubit());
}

void initUseCases() {}

void initRepositories() {}

void initDataSources() {}

Future<void> initExternal() async {}
