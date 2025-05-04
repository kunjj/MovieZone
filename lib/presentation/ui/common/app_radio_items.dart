import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/configs/themes/app_colors.dart';
import '../../../../core/utils/dimens.dart';
import '../../../../core/utils/styles.dart';
import 'app_inkwell.dart';

class AppRadioButtons<T> extends StatelessWidget {
  final List<T> options;
  final T selectedValue;
  final ValueChanged<T> onChanged;
  final String Function(T)? itemLabel;
  final Color activeColor;
  final TextStyle? textStyle;
  final Axis direction;
  final double spacing;
  final ScrollPhysics? scrollPhysics;

  const AppRadioButtons(
      {super.key,
      required this.options,
      required this.selectedValue,
      required this.onChanged,
      this.itemLabel,
      this.activeColor = AppColors.primaryBlue1,
      this.textStyle,
      this.direction = Axis.horizontal,
      this.spacing = Dimens.spaceSmall,
      this.scrollPhysics});

  @override
  Widget build(BuildContext context) => direction == Axis.vertical
      ? ListView.separated(
          shrinkWrap: true,
          physics: scrollPhysics ?? const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) => _ItemsView(
              onChanged: (_) => onChanged(options[index]),
              element: options[index],
              selectedValue: selectedValue,
              activeColor: activeColor,
              itemLabel: itemLabel != null ? itemLabel!(options[index]) : options[index].toString(),
              textStyle: textStyle),
          separatorBuilder: (_, __) => Gap(spacing),
          itemCount: options.length)
      : Wrap(
          direction: direction,
          spacing: spacing,
          children: options
              .map((T element) => _ItemsView(
                  onChanged: (_) => onChanged(element),
                  element: element,
                  selectedValue: selectedValue,
                  activeColor: activeColor,
                  itemLabel: itemLabel != null ? itemLabel!(element) : element.toString(),
                  textStyle: textStyle))
              .toList());
}

class _ItemsView<T> extends StatelessWidget {
  const _ItemsView({
    super.key,
    required this.selectedValue,
    required this.onChanged,
    required this.element,
    required this.itemLabel,
    this.activeColor = AppColors.primaryBlue1,
    this.textStyle,
  });

  final T selectedValue;
  final T element;
  final ValueChanged<T> onChanged;
  final String itemLabel;
  final Color activeColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) => AppInkWell(
      onTap: () => onChanged(element),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Radio(
            value: element,
            groupValue: selectedValue,
            visualDensity: const VisualDensity(horizontal: Dimens.visualDensitySmall, vertical: Dimens.visualDensitySmall),
            activeColor: activeColor,
            onChanged: (_) => onChanged(element)),
        Flexible(child: Text(itemLabel, overflow: TextOverflow.visible, style: textStyle ?? AppFontTextStyles.textStyleMedium())),
      ]));
}
