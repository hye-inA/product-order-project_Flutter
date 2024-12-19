import 'package:flutter/material.dart';

import '../const/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final String labelText;
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final ValueChanged<String>? onChanged;

  CustomTextFormField({
    required this.textInputAction,
    required this.keyboardType,
    required this.labelText,
    required this.onChanged,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.autofocus = false,
    this.focusNode,
    this.onEditingComplete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: AppColors.INPUT_BORDER_COLOR, width: 1.6),
    );

    return TextFormField(
      cursorColor: AppColors.PRIMARY_GREEN,
      obscureText: obscureText,
      autofocus: autofocus,
      focusNode: focusNode,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle: TextStyle(
            color: AppColors.TextSecondary, fontWeight: FontWeight.w500),
        contentPadding: EdgeInsets.all(20),
        hintText: hintText,
        errorText: errorText,
        hintStyle: TextStyle(
          color: AppColors.TextTertiary,
          fontSize: 14.0,
        ),
        fillColor: AppColors.INPUT_BG_COLOR,
        filled: true,
        border: baseBorder,
        enabledBorder: baseBorder.copyWith(
          borderSide: BorderSide(
            color: AppColors.INPUT_BORDER_COLOR.withOpacity(0.5),
            width: 1.6,
          ),
        ),
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
