import 'package:flutter/material.dart';

import '../../../../core/configs/themes/app_colors.dart';
import '../../../../core/utils/dimens.dart';

class ContainerDecoration extends BoxDecoration {
  final double radius;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final List<BoxShadow>? boxShadows;
  final Gradient? gradientColor;

  ContainerDecoration({
    this.radius = Dimens.radiusSmall,
    this.backgroundColor = AppColors.white,
    this.borderColor = AppColors.borderColor,
    this.borderWidth = Dimens.borderWidthXSmall,
    this.boxShadows,
    this.gradientColor,
  }) : super(
            borderRadius: BorderRadius.circular(radius),
            color: backgroundColor,
            gradient: gradientColor,
            border: Border.all(width: borderWidth, color: borderColor),
            boxShadow: boxShadows);
}
