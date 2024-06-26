import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {

  @EnviedField(varName: 'BASE_URL', defaultValue: '')
  static const String baseUrl = _Env.baseUrl;
}
