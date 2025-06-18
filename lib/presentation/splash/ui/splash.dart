import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/configs/navigation/app_navigator.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/images.dart';
import '../../../core/utils/routes.dart';
import '../../auth/ui/signin_screen.dart';
import '../../home/ui/home_screen.dart';
import '../bloc/splash_cubit.dart';
import '../bloc/splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<SplashCubit, SplashState>(
            listener: (context, state) {
              switch (state) {
                case Authenticated():
                  navigatorKey.currentContext?.pushAndRemoveUntil(
                      builder: (context) => const HomeScreen(), settings: const RouteSettings(name: AppRoutes.homeScreen));
                case UnAuthenticated():
                  navigatorKey.currentContext?.pushAndRemoveUntil(
                      builder: (context) => const SignInScreen(), settings: const RouteSettings(name: AppRoutes.signInScreen));
              }
            },
            child: const _ScreenContent()));
  }
}

class _ScreenContent extends StatelessWidget {
  const _ScreenContent();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(Images.splashBackground),
      Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [const Color(0xff1A1B20).withOpacity(0.25), const Color(0xff1A1B20)])))
    ]);
  }
}
