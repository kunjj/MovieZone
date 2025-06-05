import 'package:flutter/material.dart';

import '../../../../core/configs/themes/app_colors.dart';
import '../../../../core/utils/dimens.dart';
import '../../../../core/utils/styles.dart';

class AppPopupOptions<T> {
  void show({
    required BuildContext context,
    required List<T> optionsList,
    required Function(T) onSelection,
    Color backgroundColor = AppColors.white,
    String Function(T)? itemLabel,
    TextStyle? textStyle,
    double itemHeight = Dimens.buttonLarge,
    double borderWidth = Dimens.borderWidthXSmall,
    double borderRadius = Dimens.radiusSmall,
    double menuPadding = Dimens.space4xSmall,
    Color dividerColor = AppColors.dividerColor,
    Color borderColor = AppColors.borderColor,
  }) =>
      showMenu<T>(
          context: context,
          color: backgroundColor,
          elevation: Dimens.elevationMedium,
          menuPadding: EdgeInsets.all(menuPadding),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: borderColor, width: borderWidth), borderRadius: BorderRadius.circular(borderRadius)),
          position: _getRelativePosition(context),
          items: [
            ...optionsList.map((element) => PopupMenuItem(
                value: element,
                onTap: () => onSelection(element),
                height: itemHeight,
                child: _ItemView(
                    text: itemLabel != null ? itemLabel(element) : element.toString(),
                    textStyle: textStyle ?? AppFontTextStyles.textStyleMedium(),
                    isLast: optionsList.last == element,
                    dividerColor: dividerColor)))
          ]);

  RelativeRect _getRelativePosition(BuildContext context) {
    //*get the render box from the context
    final renderBox = context.findRenderObject() as RenderBox;
    //*get the global position, from the widget local position
    final offset = renderBox.localToGlobal(Offset.zero);

    //*calculate the start point in this case, below the button
    final left = offset.dx;
    final top = offset.dy + renderBox.size.height;
    //*The right does not indicates the width
    final right = left + renderBox.size.width;
    return RelativeRect.fromLTRB(left, top, right, 0.0);
  }
}

class _ItemView extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final bool isLast;
  final Color dividerColor;

  const _ItemView({required this.text, required this.textStyle, required this.isLast, required this.dividerColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: isLast ? EdgeInsets.zero : const EdgeInsets.symmetric(vertical: Dimens.spaceXSmall),
            child: Text(text, style: textStyle, overflow: TextOverflow.visible),
          ),
          isLast ? const SizedBox() : Divider(height: Dimens.dividerThicknessSmall, color: dividerColor)
        ],
      ),
    );
  }
}
