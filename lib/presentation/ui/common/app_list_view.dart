import 'package:flutter/material.dart';
import '../../../../core/utils/dimens.dart';

class AppListView<T> extends StatelessWidget {
  const AppListView(
      {super.key,
      required this.list,
      required this.itemBuilder,
      this.separator,
      this.scrollController,
      this.physics,
      this.shrinkWrap = false});

  final List<T> list;
  final Widget? Function(BuildContext, T) itemBuilder;
  final Widget? separator;
  final ScrollController? scrollController;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) => ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: const NeverScrollableScrollPhysics(),
      controller: scrollController,
      itemBuilder: (context, index) => itemBuilder(context, list[index]),
      itemCount: list.length,
      separatorBuilder: (_, __) =>
          separator ?? const Divider(height: Dimens.dividerThicknessXSmall));
}
