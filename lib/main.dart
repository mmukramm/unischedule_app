import 'package:flutter/material.dart';
import 'package:unischedule_app/core/theme/theme.dart';
import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/features/presentation/common/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: theme,
      home: const SplashPage(),
    );
  }
}
