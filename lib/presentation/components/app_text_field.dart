import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles/app_colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final IconData? icon;
  Function(String)? onChanged;
  Function(String)? onSubmitted;
  bool iconColorChangingCondition;
  final double? radius;
  final FormFieldValidator<String>? validator;
  final TextInputFormatter? mask;
  final TextInputType? textInputType;
  final Function()? iconTab;
  final bool autofocus;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final EdgeInsets? margin;
  final Color? color;
  final bool withFontWeight;
  final bool withPass;
  final Widget? prefixIcon;
  final TextCapitalization? textCapitalization;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  AppTextField(
      {Key? key,
      this.controller,
      this.prefixIcon,
      this.color,
      this.radius,
      this.withFontWeight = false,
      this.autofocus = false,
      this.onSubmitted,
      this.textCapitalization,
      required this.label,
      this.margin,
      this.suffixIcon,
      this.onChanged,
      this.textInputAction,
      this.iconTab,
      this.textInputType,
      this.validator,
      this.mask,
      this.withPass = false,
      this.inputFormatters,
      this.maxLines,
      this.icon,
      this.iconColorChangingCondition = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      maxLines: maxLines,
      autofocus: autofocus,
      validator: validator,
      style: GoogleFonts.openSans(
          color: AppColors.white,
          fontWeight: withFontWeight ? FontWeight.w600 : FontWeight.normal),
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      obscureText: withPass,
      keyboardType: textInputType,
      controller: controller,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        // ignore: prefer_if_null_operators
        prefixIcon: prefixIcon == null ? null : prefixIcon,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 15),
            borderSide: BorderSide(color: AppColors.primaryBlack, width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 15),
            borderSide: const BorderSide(color: Colors.red, width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 15),
            borderSide: BorderSide(color: AppColors.grey)),
        filled: true,
        fillColor: color,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        hintText: label,
        errorStyle: const TextStyle(color: Colors.red),
        hintStyle: TextStyle(color: AppColors.grey),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 15),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
