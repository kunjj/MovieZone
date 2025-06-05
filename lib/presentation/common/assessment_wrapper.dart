import 'package:flutter/material.dart';

import '../../../../core/configs/themes/app_colors.dart';
import '../../../../core/utils/dimens.dart';
import '../../../../core/utils/styles.dart';
import 'app_inkwell.dart';
import 'container_decoration.dart';

class TitleIconData {
  final IconData icon;
  final Function() onTap;
  final Color? iconColor;

  TitleIconData({
    required this.icon,
    required this.onTap,
    this.iconColor,
  });
}

class AssessmentWrapper extends StatelessWidget {
  final String title;
  final Widget child;
  final List<TitleIconData> icons;
  final Color titleColor;
  final Color backgroundColor;
  final Color titleBackgroundColor;
  final Color borderColor;
  final double titleFontSize;
  final double iconSize;
  final double verticalPadding;
  final double horizontalPadding;
  final double radius;

  const AssessmentWrapper({
    super.key,
    required this.title,
    required this.child,
    this.icons = const [],
    this.titleColor = AppColors.black,
    this.titleFontSize = Dimens.fontSizeSixteen,
    this.iconSize = Dimens.iconMedium,
    this.backgroundColor = AppColors.white,
    this.titleBackgroundColor = AppColors.primaryBlue3,
    this.borderColor = AppColors.boxShadowColor,
    this.verticalPadding = Dimens.padding3xSmall,
    this.horizontalPadding = Dimens.paddingSmall,
    this.radius = Dimens.radius2xSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ContainerDecoration(
        backgroundColor: backgroundColor,
        radius: radius,
        borderColor: borderColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: titleBackgroundColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(radius), topRight: Radius.circular(radius))),
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding,
              horizontal: horizontalPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppFontTextStyles.textStyleBold().copyWith(
                      color: titleColor,
                      fontSize: titleFontSize,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: icons.map((iconData) {
                    return Padding(
                      padding: const EdgeInsets.only(left: Dimens.padding3xSmall),
                      child: AppInkWell(
                        onTap: iconData.onTap,
                        child: Icon(
                          iconData.icon,
                          color: iconData.iconColor ?? AppColors.black,
                          size: iconSize,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Divider(height: Dimens.dividerThicknessXSmall, color: borderColor),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding,
              horizontal: horizontalPadding,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
