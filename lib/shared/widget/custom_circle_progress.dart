import 'package:flutter/material.dart';

import '../app_constants/app_colors.dart';

class CustomProgressIndicatorWidget extends StatelessWidget {
  final bool isLoading;
  final Color color;
  final double size;

  const CustomProgressIndicatorWidget({
    Key? key,
    this.isLoading = true,
    this.size = 40,
    this.color = AppColors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: Center(
        child: Container(
          height: size,
          width: size,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child:  Center(
            child: CircularProgressIndicator(
              color: color,
              strokeWidth: 2,
            ),
          ),
        ),
      ),
    );
  }
}
