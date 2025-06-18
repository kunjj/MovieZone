import 'package:flutter/material.dart';


import '../../../core/configs/themes/app_colors.dart';
import '../../../core/utils/dimens.dart';
import 'container_decoration.dart';

class AddItemIcon extends StatelessWidget {
  final Function() onTap;
  final double? height;
  final double? width;
  final double borderRadius;
  final Color borderColor;

  const AddItemIcon(
      {super.key,
      required this.onTap,
      this.height,
      this.width,
      this.borderRadius = Dimens.radiusXSmall,
      this.borderColor = AppColors.primaryBlue1});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: ContainerDecoration(radius: borderRadius, borderColor: borderColor),
        child: IconButton(
            onPressed: onTap, icon: const Icon(Icons.add, color: AppColors.primaryBlue1), highlightColor: AppColors.transparent));
  }
}
