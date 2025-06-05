import 'package:flutter/material.dart';

import '../../../../core/utils/dimens.dart';
import '../../../../core/utils/styles.dart';

class EmptyListView extends StatelessWidget {
  const EmptyListView({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(message,
            textAlign: TextAlign.center,
            style: AppFontTextStyles.textStyleBold()
                .copyWith(fontSize: Dimens.fontSizeTwenty)));
  }
}
