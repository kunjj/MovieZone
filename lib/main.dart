import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/configs/themes/app_themes.dart';
import 'core/utils/constants.dart';
import 'core/utils/logging.dart';
import 'injector/injector.dart';
import 'l10n/l10n.dart';
import 'presentation/splash/bloc/splash_cubit.dart';
import 'presentation/splash/ui/splash.dart';

void main() {
  runZonedGuarded(() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    WidgetsFlutterBinding.ensureInitialized();

    injectorSetUp();
    runApp(const MyApp());
  }, (error, stackTrace) {
    if (kDebugMode) printLog(message: 'Error: $error \n StackTrace: $stackTrace');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
        create: (context) => SplashCubit()..appStarted(),
        child: MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.appTheme,
            home: const SplashScreen(),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            locale: L10n.all[0],
            supportedLocales: L10n.all));
  }
}
