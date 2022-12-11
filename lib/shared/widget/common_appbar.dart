import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_constants/app_colors.dart';
import '../app_constants/app_text_styles.dart';
import 'build_text_style.dart';

AppBar commonAppBar(BuildContext context, String title, {Function? onTap, List<Widget>? actions,bool shouldAddBack = true}) {
  return AppBar(
    elevation: 0,
    centerTitle: false,
    systemOverlayStyle: const SystemUiOverlayStyle(
      // Status bar color
      statusBarColor: Colors.white,

      // Status bar brightness (optional)
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
    ),
    backgroundColor: AppColors.white,
    leading: shouldAddBack ? backButton(context, onTap) : null,
    titleSpacing: 0,
    actions: actions,
    title: BuildTextWithStyle(
      text: title,
      textStyle: appBarHeaderStyle,
    ),
  );
}

Widget backButton(BuildContext context, [Function? onTap]) {
  return InkWell(
      onTap: onTap == null
          ? () {
              Navigator.of(context).pop();
            }
          : () {
              onTap();
            },
      child: const Padding(
        padding: EdgeInsets.only(top: 8.0, bottom: 8, right: 8, left: 19),
        child: Icon(Icons.arrow_back_ios, size: 19, color: AppColors.textColor),
      ));
}
