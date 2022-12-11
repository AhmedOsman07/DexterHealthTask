import 'package:flutter/material.dart';

import '../app_constants/app_numbers.dart';
import '../app_constants/app_text_styles.dart';
import 'build_text_style.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class AppToast extends StatelessWidget {
  final bool isSuccessful;
  final String description;

  const AppToast({Key? key, required this.isSuccessful, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppNumbers.inputFieldBorder),
        color: isSuccessful ? Colors.green : Colors.black,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSuccessful ? Icons.check : Icons.close,
            color: Colors.white,
          ),
          const SizedBox(
            width: 15.0,
          ),
          SizedBox(
            // width: SizeConfig.safeBlockHorizontal * 60,
            child: BuildTextWithStyle(
              textStyle: successToastText,
              text: description,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
