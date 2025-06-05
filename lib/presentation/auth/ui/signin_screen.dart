import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:reactive_button/reactive_button.dart';

import '../../../../core/configs/navigation/app_navigator.dart';
import '../../../../core/configs/themes/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/dimens.dart';
import '../../../../core/utils/routes.dart';
import '../../../../core/utils/styles.dart';
import '../../common/app_text_field.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
          title: AppLocalizations.of(context)?.signIn,
          activeColor: AppColors.red,
          onPressed: () async {},
          onSuccess: () {},
          onFailure: (error) {}),
      const Gap(Dimens.paddingXMedium),
      Text.rich(TextSpan(children: [
        TextSpan(text: AppLocalizations.of(context)?.dont_have_account),
        TextSpan(
            text: AppLocalizations.of(context)?.signUp,
            style: AppFontTextStyles.textStyleBold().copyWith(color: AppColors.red, fontSize: 14),
            recognizer: TapGestureRecognizer()
              ..onTap = () => navigatorKey.currentContext?.push(
                  builder: (context) => const SignUpScreen(),
                  settings: const RouteSettings(name: AppRoutes.signUpScreen),
                  transitionType: PageTransitionType.downToUp))
      ]))
    ]);
  }
}
