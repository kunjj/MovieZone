import 'package:flutter/material.dart';

import '../../../../core/configs/themes/app_colors.dart';

class HighlightText extends StatefulWidget {
  final String text;
  final String highlightText;
  final TextStyle style;
  final TextStyle highlightStyle;
  final Color? highlightColor;
  final TextAlign? textAlign;

  const HighlightText(
      {super.key,
      required this.text,
      required this.highlightText,
      required this.style,
      required this.highlightStyle,
      this.highlightColor = AppColors.red,
      this.textAlign = TextAlign.start});

  @override
  State<HighlightText> createState() => _HighlightTextState();
}

class _HighlightTextState extends State<HighlightText> {
  @override
  Widget build(BuildContext context) {
    final text = widget.text;
    if ((widget.highlightText.isEmpty) || text.isEmpty) {
      return Text(text,
          style: widget.style,
          textAlign: widget.textAlign,
          overflow: TextOverflow.visible);
    }

    List<TextSpan> spans = [];
    int start = 0;
    int indexOfHighlight;
    do {
      indexOfHighlight =
          text.toLowerCase().indexOf(widget.highlightText.toLowerCase(), start);
      if (indexOfHighlight < 0) {
        spans.add(_normalSpan(text.substring(start)));
        break;
      }
      if (indexOfHighlight > start) {
        spans.add(_normalSpan(text.substring(start, indexOfHighlight)));
      }
      start = indexOfHighlight + widget.highlightText.length;
      spans.add(_highlightSpan(text.substring(indexOfHighlight, start)));
    } while (true);

    return Text.rich(TextSpan(children: spans),
        textAlign: widget.textAlign, overflow: TextOverflow.visible);
  }

  TextSpan _highlightSpan(String content) => TextSpan(
      text: content,
      style: widget.highlightStyle.copyWith(color: widget.highlightColor));

  TextSpan _normalSpan(String content) =>
      TextSpan(text: content, style: widget.style);
}
