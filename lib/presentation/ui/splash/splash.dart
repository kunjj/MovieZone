import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/configs/navigation/app_navigator.dart';
import '../../../core/utils/images.dart';
import '../../bloc/splash_cubit.dart';
import '../../bloc/splash_state.dart';
import '../home/home_screen.dart';
import '../signin/signin_screen.dart';

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
                  AppNavigator.pushAndRemoveUntil(context, const HomeScreen());
                case UnAuthenticated():
                  AppNavigator.pushAndRemoveUntil(context, const SignInScreen());
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
