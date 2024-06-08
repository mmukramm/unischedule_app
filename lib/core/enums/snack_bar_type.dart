import 'dart:ui';

import 'package:unischedule_app/core/theme/colors.dart';

enum SnackBarType {
  primary(scaffoldColor, primaryColor),
  error(scaffoldColor, dangerColor),
  success(scaffoldColor, infoColor);

  final Color textColor;
  final Color backgroundColor;

  const SnackBarType(this.textColor, this.backgroundColor);
}
