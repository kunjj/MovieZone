import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/configs/themes/app_colors.dart';
import '../../../../core/utils/dimens.dart';
import '../../../../core/utils/styles.dart';
import 'app_inkwell.dart';
import 'highlight_text.dart';

class AppItemView<T> extends StatelessWidget {
  const AppItemView(
      {super.key,
      required this.onTap,
      required this.highlightText,
      required this.item,
      this.title,
      this.subtitle,
      this.wantToShowSelectedItem,
      this.prefixIcon});

  final T item;
  final String? title;
  final String? subtitle;
  final Function(T) onTap;
  final bool? wantToShowSelectedItem;
  final String highlightText;
  final Widget? prefixIcon;

  @override
  Widget build(context) => AppInkWell(
      onTap: () async => onTap(item),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (prefixIcon != null) ...[prefixIcon!, const Gap(Dimens.space3xMedium)],
            Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Visibility(
                  visible: title != null,
                  child: HighlightText(
                      text: title ?? '',
                      style: AppFontTextStyles.textStyleMedium(),
                      highlightText: highlightText,
                      highlightStyle: AppFontTextStyles.textStyleMedium())),
              Visibility(
                  visible: subtitle != null,
                  child: Text(subtitle ?? '',
                      style: AppFontTextStyles.textStyleMedium().copyWith(fontSize: Dimens.fontSizeSixteen),
                      overflow: TextOverflow.visible))
            ])),
            Visibility(
                visible: wantToShowSelectedItem == true,
                child: const Icon(Icons.check_circle, color: AppColors.primaryBlue1)),
            Visibility(
                visible: wantToShowSelectedItem == null,
                child: const Icon(Icons.more_vert_rounded,
                    size: Dimens.iconXMedium, color: AppColors.primaryBlue1))
          ]));
}
