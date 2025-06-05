import 'package:flutter/material.dart';

import '../../../../core/configs/themes/app_colors.dart';
import '../../../../core/utils/dimens.dart';
import '../../../../core/utils/styles.dart';
import 'app_image_filters.dart';

class AppToast extends StatelessWidget {
  final String message;

  const AppToast({
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimens.space2xLarge),
      child: BackdropFilter(
        filter: AppImageFilters.blurLow,
        child: Container(
          decoration: const ShapeDecoration(
            shape: StadiumBorder(),
            color: AppColors.primaryBlue1,
          ),
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space2xLarge, vertical: Dimens.spaceLarge),
          child:
              Text(message, style: AppFontTextStyles.textStyleBold().copyWith(color: AppColors.white), overflow: TextOverflow.visible),
        ),
      ),
    );
  }
}
