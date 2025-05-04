import 'package:flutter/material.dart';

import '../../../core/configs/themes/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: SizedBox(),
        ));
  }
}
