import 'package:flutter/material.dart';
import 'custom_circle_progress.dart';

//
class DexterButton extends StatelessWidget {
  final String? title;
  final Function() onPress;
  final Color textColor;
  final Color color;
  final bool isLoading;

  const DexterButton({
    Key? key,
    required this.title,
    required this.onPress,
    required this.textColor,
    required this.color,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(8.0),
      child: isLoading
          ? const CustomProgressIndicatorWidget()
          : MaterialButton(
              elevation: 0,
              highlightElevation: 0,
              onPressed: onPress,
              highlightColor: color.withOpacity(0.5),
              splashColor: Colors.transparent,
//        color,
              child: Text(
                title!,
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ),
    );
  }
}

