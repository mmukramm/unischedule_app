import 'package:flutter/material.dart';
import 'package:unischedule_app/core/theme/colors.dart';

TextTheme textTheme = const TextTheme(
  displayLarge: TextStyle(
    fontFamily: 'Inter',
    fontSize: 40,
    fontWeight: FontWeight.w600,
  ),
  displayMedium: TextStyle(
    fontFamily: 'Inter',
    fontSize: 32,
    fontWeight: FontWeight.w600,
  ),
  displaySmall: TextStyle(
    fontFamily: 'Inter',
    fontSize: 24,
    fontWeight: FontWeight.w600,
  ),
  headlineLarge: TextStyle(
    fontFamily: 'Kameron',
    fontSize: 40,
    fontWeight: FontWeight.w600,
  ),
  headlineMedium: TextStyle(
    fontFamily: 'Kameron',
    fontSize: 32,
    fontWeight: FontWeight.w600,
  ),
  headlineSmall: TextStyle(
    fontFamily: 'Kameron',
    fontSize: 24,
    fontWeight: FontWeight.w600,
  ),
  bodyLarge: TextStyle(
    fontFamily: 'Inter',
    fontSize: 20,
    fontWeight: FontWeight.w400,
  ),
  bodyMedium: TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ),
  bodySmall: TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
    fontWeight: FontWeight.w400,
  ),
).apply(
  bodyColor: primaryTextColor,
  displayColor: primaryTextColor
);