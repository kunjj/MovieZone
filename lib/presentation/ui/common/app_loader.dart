import 'package:flutter/material.dart';

import '../../../core/configs/themes/app_colors.dart';
import '../../../core/utils/dimens.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({
    super.key,
    this.strokeWidth = Dimens.borderWidthXMedium,
    this.backgroundColor,
  });

  final double strokeWidth;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor:
            AlwaysStoppedAnimation<Color>(backgroundColor ?? AppColors.white),
        backgroundColor: AppColors.primaryBlue1.withOpacity(0.5),
      ),
    );
  }
}
