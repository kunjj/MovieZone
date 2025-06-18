import 'package:flutter/material.dart';
import '../../../../core/configs/themes/app_colors.dart';
import '../../../../core/utils/dimens.dart';
import '../../../../core/utils/styles.dart';
import '../svg_icon.dart';

class AppOutLineButton extends StatelessWidget {
  final String title;
  final String? image;
  final TextStyle? titleTextStyle;
  final VoidCallback? onTap;
  final bool isLoading;
  final Color? disabledColor;
  final Color? backgroundColor;
  final bool hasBorder;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final bool isEnabled;
  final double height;
  final double width;
  final double imageWidth;
  final double imageHeight;

  const AppOutLineButton(
      {this.title = '',
      this.image,
      this.titleTextStyle,
      this.onTap,
      this.isLoading = false,
      this.disabledColor = AppColors.secondaryGrey2,
      this.backgroundColor = AppColors.primaryBlue1,
      this.hasBorder = false,
      this.borderColor = AppColors.primaryBlue1,
      this.borderWidth = Dimens.borderWidthSmall,
      this.borderRadius = Dimens.radius2xSmall,
      this.isEnabled = true,
      this.height = Dimens.button2xLarge,
      this.width = double.infinity,
      this.imageHeight = Dimens.iconMedium,
      this.imageWidth = Dimens.iconMedium,
      super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: isLoading || !isEnabled ? null : onTap,
        style: OutlinedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(horizontal: Dimens.space2xSmall),
            disabledBackgroundColor:
                isLoading ? AppColors.transparent : disabledColor,
            side: BorderSide(width: 1, color: borderColor),
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: borderColor,
                    width: borderWidth,
                    style: hasBorder ? BorderStyle.solid : BorderStyle.none),
                borderRadius: BorderRadius.circular(borderRadius))),
        child: Center(
            child: isLoading
                ? SizedBox(
                    width: Dimens.iconSmall,
                    height: Dimens.iconSmall,
                    child: CircularProgressIndicator(
                        strokeWidth: Dimens.borderWidthXMedium,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.primaryBlue1),
                        backgroundColor: Colors.white.withOpacity(0.2)))
                : _TextWithIcon(
                    title: title,
                    style: titleTextStyle ??
                        AppFontTextStyles.buttonTextStyle()
                            .copyWith(color: AppColors.primaryBlue1),
                    imageWidth: imageWidth,
                    imageHeight: imageHeight,
                    image: image)));
  }
}

class _TextWithIcon extends StatelessWidget {
  final String title;
  final TextStyle style;

  final String? image;
  final double imageWidth;
  final double imageHeight;

  const _TextWithIcon(
      {required this.title,
      required this.style,
      required this.imageWidth,
      required this.imageHeight,
      this.image});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      image != null
          ? Padding(
              padding: const EdgeInsets.only(right: Dimens.space3xSmall),
              child: AppSvgIcon(image!,
                  width: imageWidth,
                  height: imageHeight,
                  color: AppColors.primaryBlue1))
          : const SizedBox(),
      Text(title, textAlign: TextAlign.center, style: style)
    ]);
  }
}
