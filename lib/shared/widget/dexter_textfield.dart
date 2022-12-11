import 'package:flutter/material.dart';

import '../app_constants/app_colors.dart';

class DexterTextFormField extends StatelessWidget {
  const DexterTextFormField({
    Key? key,
    required this.textInputType,
    this.textAlign,
    this.textColor,
    this.initialValue,
    this.hintText,
    this.textFormFieldValue,
    this.textFormFieldValidator,
    this.onTap,
    this.isTextObscure,
    this.suffixIcon,
    this.focusNode,
  }) : super(key: key);
  final TextAlign? textAlign;
  final Color? textColor;
  final String? initialValue;
  final String? hintText;
  final Function? textFormFieldValue;
  final String? Function(String?)? textFormFieldValidator;
  final GestureTapCallback? onTap;
  final TextInputType textInputType;
  final bool? isTextObscure;
  final Widget? suffixIcon;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      if (hintText != null)
        Text(hintText!,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            )),
      if (hintText != null)
        const SizedBox(
          height: 4,
        ),
      TextFormField(
        key: key,
        focusNode: focusNode,
        onTap: onTap,
        initialValue: initialValue,
        keyboardType: textInputType,
        obscureText: isTextObscure ?? false,
        cursorColor: AppColors.textColor,
        textAlign: textAlign ?? TextAlign.start,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.borderColor,
                width: 0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.borderColor,
                width: 1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            filled: true,
            fillColor: AppColors.darkGray,
            suffixIcon: suffixIcon,
            errorStyle: const TextStyle(
              wordSpacing: 1,
              fontWeight: FontWeight.w600,
            )),
        style: const TextStyle(
            color: AppColors.textColor, fontSize: 16, fontWeight: FontWeight.normal),
        onChanged: (dynamic value) => textFormFieldValue!(value),
        onSaved: (dynamic value) => textFormFieldValue!(value),
        validator: textFormFieldValidator,
      ),
    ]);
    // );
  }
}
