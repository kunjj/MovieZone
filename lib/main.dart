import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/configs/themes/app_themes.dart';
import 'presentation/splash/splash.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, theme: AppTheme.appTheme, home: const SplashScreen());
  }
}
