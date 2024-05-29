import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  initBlocs();
  initUseCases();
  initRepositories();
  initDataSources();
  await initExternal();
}

void initBlocs() {

}

void initUseCases() {
}

void initRepositories() {
}

void initDataSources() {

}

Future<void> initExternal() async {

}