import 'package:flutter/material.dart';

class BuildTextWithStyle extends StatelessWidget {
  final TextStyle textStyle;
  final String text;
  final int maxLines;
  final TextOverflow textOverflow;
  final TextAlign textAlign;
  final bool shouldOutline;

  const BuildTextWithStyle(
      {Key? key,
      required this.textStyle,
      required this.text,
      this.maxLines = 1,
      this.textOverflow = TextOverflow.ellipsis,
      this.shouldOutline = false,
      this.textAlign = TextAlign.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: textOverflow,
      maxLines: maxLines,
      softWrap: true,
      style: textStyle.copyWith(
          decoration: shouldOutline ? TextDecoration.lineThrough : TextDecoration.none),
    );
  }
}
