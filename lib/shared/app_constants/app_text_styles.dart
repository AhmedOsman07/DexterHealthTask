import 'package:flutter/material.dart';

import '../utils/size_config.dart';
import 'app_colors.dart';

double width = SizeConfig.blockSizeHorizontal;

var appBarHeaderStyle =
    TextStyle(fontSize: width * 4.5, fontWeight: FontWeight.w500, color: AppColors.textColor);

var successToastText = TextStyle(
  fontSize: width * 3.5,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);
