import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:reactive_button/reactive_button.dart';

import '../../../core/configs/themes/app_colors.dart';
import '../../../core/utils/dimens.dart';
import '../../common/app_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
            minimum: EdgeInsets.symmetric(horizontal: Dimens.paddingXSmall, vertical: Dimens.padding3xMedium),
            child: _ScreenContent()));
  }
}

class _ScreenContent extends StatelessWidget {
  const _ScreenContent();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      AppTextField(labelText: AppLocalizations.of(context)?.email),
      const Gap(Dimens.paddingXSmall),
      AppTextField(labelText: AppLocalizations.of(context)?.password),
      const Gap(Dimens.padding4xLarge),
      ReactiveButton(
          title: AppLocalizations.of(context)?.signUp,
          activeColor: AppColors.red,
          onPressed: () async {},
          onSuccess: () {},
          onFailure: (error) {})
    ]);
  }
}
