import 'package:flutter/material.dart';

import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';

ThemeData get theme {
  return ThemeData.from(
    colorScheme: colorScheme,
    textTheme: textTheme,
    useMaterial3: true,
  ).copyWith(
    scaffoldBackgroundColor: scaffoldColor,
    primaryColor: primaryColor,
    listTileTheme: const ListTileThemeData(
      horizontalTitleGap: 4,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}

ColorScheme colorScheme = ColorScheme.fromSeed(
  seedColor: backgroundColor,
  primary: primaryColor,
  secondary: secondaryTextColor,
  background: backgroundColor,
  onBackground: primaryColor,
  onPrimary: scaffoldColor,
  onSecondary: scaffoldColor,
);
