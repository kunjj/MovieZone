import 'package:flutter/material.dart';

import '../../../../core/configs/themes/app_colors.dart';
import '../../../../core/utils/dimens.dart';
import '../../../../core/utils/styles.dart';
import 'container_decoration.dart';

class DateSelectionView extends StatelessWidget {
  final String startDateString;
  final String endDateString;
  final Function()? onStartCalenderViewTap;
  final Function()? onEndCalenderViewTap;

  const DateSelectionView(
      {super.key,
      required this.startDateString,
      required this.endDateString,
      this.onStartCalenderViewTap,
      this.onEndCalenderViewTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: ContainerDecoration(
            radius: Dimens.radiusXSmall,
            backgroundColor: AppColors.primaryBlue1),
        child: Row(children: [
          Expanded(
              child: _DateViewContainer(
                  onCalenderViewTap: onStartCalenderViewTap,
                  dateText: startDateString)),
          Text('-',
              style: AppFontTextStyles.appbarTextStyle()
                  .copyWith(color: AppColors.white)),
          Expanded(
              child: _DateViewContainer(
                  onCalenderViewTap: onEndCalenderViewTap,
                  dateText: endDateString))
        ]));
  }
}

class _DateViewContainer extends StatelessWidget {
  final String dateText;
  final Function()? onCalenderViewTap;

  const _DateViewContainer(
      {required this.onCalenderViewTap, required this.dateText});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onCalenderViewTap,
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(Dimens.space4xSmall),
            child: Text(dateText,
                style: AppFontTextStyles.textStyleMedium()
                    .copyWith(color: AppColors.white))));
  }
}
