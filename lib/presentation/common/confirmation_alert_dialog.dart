import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/configs/themes/app_colors.dart';
import '../../../../core/utils/dimens.dart';
import '../../../../core/utils/styles.dart';
import '../../../core/utils/extensions.dart';
import 'app_image_filters.dart';
import 'buttons/app_out_line_button.dart';
import 'buttons/elevated_button.dart';
import 'svg_icon.dart';

class ConfirmationAlertDialog extends StatelessWidget {
  final String? message;
  final String? title;
  final String? richText;
  final String? positiveButtonTitle;
  final String? negativeButtonTitle;
  final String? image;
  final Function() onPositiveTap;
  final Function() onNegativeTap;
  final bool isWarningDialog;

  const ConfirmationAlertDialog(
      {this.message,
      this.positiveButtonTitle,
      this.negativeButtonTitle,
      required this.onPositiveTap,
      required this.onNegativeTap,
      this.image,
      super.key,
      this.isWarningDialog = false,
      this.title,
      this.richText});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: AppImageFilters.blurLow,
        child: Dialog(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimens.radiusSmall)),
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.spaceXMedium,
                    vertical: Dimens.space3xMedium),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      if (image.isNotBlank)
                        AppSvgIcon(image!,
                            height: Dimens.button3xLarge,
                            color: isWarningDialog
                                ? AppColors.lightRed
                                : AppColors.lightCyan),
                      const Gap(Dimens.space2xSmall),
                      Text(title ?? '',
                          textAlign: TextAlign.center,
                          style: AppFontTextStyles.textStyleBold()
                              .copyWith(color: AppColors.checkBoxColor),
                          overflow: TextOverflow.visible),
                      Visibility(
                          visible: message.isNotBlank,
                          child: Column(children: [
                            const Gap(Dimens.spaceXMedium),
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: message,
                                    style: AppFontTextStyles.textStyleBold()
                                        .copyWith(
                                            overflow: TextOverflow.visible,
                                            fontSize: Dimens.fontSizeEighteen,
                                            color: AppColors.checkBoxColor),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: richText,
                                          style:
                                              AppFontTextStyles.textStyleBold()
                                                  .copyWith(
                                                      overflow:
                                                          TextOverflow.visible,
                                                      color: AppColors
                                                          .checkBoxColor))
                                    ]))
                          ])),
                      const Gap(Dimens.spaceXMedium),
                      Row(children: [
                        if (negativeButtonTitle.isNotBlank)
                          Expanded(
                              child: _CommonNegativeButton(
                                  title: negativeButtonTitle!,
                                  onTap: onNegativeTap,
                                  isWarningDialog: isWarningDialog)),
                        if (negativeButtonTitle.isNotBlank)
                          const Gap(Dimens.spaceXMedium),
                        Expanded(
                            child: _CommonButton(
                                title: positiveButtonTitle!,
                                onTap: () => onPositiveTap.call(),
                                isWarningDialog: isWarningDialog))
                      ])
                    ]))));
  }
}

class _CommonNegativeButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool isWarningDialog;

  const _CommonNegativeButton(
      {required this.title,
      required this.onTap,
      required this.isWarningDialog});

  @override
  Widget build(BuildContext context) {
    return AppOutLineButton(
        title: title,
        onTap: onTap,
        borderColor:
            isWarningDialog ? AppColors.checkBoxColor : AppColors.primaryBlue1,
        titleTextStyle: AppFontTextStyles.textStyleBold().copyWith(
            color: isWarningDialog
                ? AppColors.checkBoxColor
                : AppColors.primaryBlue1));
  }
}

class _CommonButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool isWarningDialog;

  const _CommonButton(
      {required this.title,
      required this.onTap,
      required this.isWarningDialog});

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
        title: title,
        onTap: onTap,
        backgroundColor:
            isWarningDialog ? AppColors.red : AppColors.primaryBlue1);
  }
}
