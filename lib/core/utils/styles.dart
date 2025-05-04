import 'package:flutter/material.dart';

import '../configs/themes/app_colors.dart';
import 'dimens.dart';

String internetStatus = 'ConnectivityResult.none';

abstract class AppFontTextStyles {
  static const fontFamily = 'Ageo';

  static TextStyle textStyleSmall() => const TextStyle(
      fontFamily: AppFontTextStyles.fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: Dimens.fontSizeTwelve,
      color: AppColors.checkBoxColor,
      overflow: TextOverflow.visible,
      letterSpacing: 0.07);

  static TextStyle textStyleMedium() => const TextStyle(
      fontFamily: AppFontTextStyles.fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: Dimens.fontSizeFourteen,
      color: AppColors.checkBoxColor,
      overflow: TextOverflow.visible,
      letterSpacing: 0.07);

  static TextStyle textStyleLarge() => const TextStyle(
      fontFamily: AppFontTextStyles.fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: Dimens.fontSizeEighteen,
      color: AppColors.checkBoxColor,
      overflow: TextOverflow.visible,
      letterSpacing: 0.07);

  static TextStyle textStyleBold() => const TextStyle(
      fontFamily: AppFontTextStyles.fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: Dimens.fontSizeEighteen,
      color: AppColors.checkBoxColor,
      overflow: TextOverflow.visible,
      letterSpacing: 0.07);

  static TextStyle buttonTextStyle() => const TextStyle(
      fontFamily: AppFontTextStyles.fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: Dimens.fontSizeSixteen,
      color: AppColors.white,
      overflow: TextOverflow.visible,
      letterSpacing: 0.07);

  static TextStyle appbarTextStyle() => const TextStyle(
      fontFamily: AppFontTextStyles.fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: Dimens.fontSizeEighteen,
      color: AppColors.checkBoxColor,
      overflow: TextOverflow.visible,
      letterSpacing: 0.07);
}
