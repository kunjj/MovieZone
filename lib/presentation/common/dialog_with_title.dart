import 'package:flutter/material.dart';

import '../../../../core/configs/themes/app_colors.dart';
import '../../../../core/utils/dimens.dart';
import '../../../../core/utils/styles.dart';
import '../../../core/utils/images.dart';
import 'buttons/icon_button.dart';
import 'container_decoration.dart';
import 'svg_icon.dart';

class DialogWithTitle extends StatelessWidget {
  const DialogWithTitle({super.key, required this.title, required this.child, this.onCancelButtonTap, this.isCancellable = true});

  final String title;
  final Widget child;
  final bool isCancellable;
  final Function()? onCancelButtonTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            decoration: ContainerDecoration(
                borderColor: AppColors.primaryBlue1, borderWidth: Dimens.borderWidthSmall, radius: Dimens.radiusSmall),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: [
              Container(
                  padding: const EdgeInsets.all(Dimens.padding3xSmall),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimens.radiusXSmall), topRight: Radius.circular(Dimens.radiusXSmall)),
                      color: AppColors.primaryBlue1),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Padding(
                        padding: EdgeInsets.all(isCancellable ? 0 : Dimens.padding2xSmall),
                        child: Text(title, style: AppFontTextStyles.textStyleBold().copyWith(color: AppColors.white))),
                    if (isCancellable)
                      AppIconButton(iconWidget: const AppSvgIcon(Images.cancel, color: AppColors.white), onTap: onCancelButtonTap)
                  ])),
              child
            ])));
  }
}
