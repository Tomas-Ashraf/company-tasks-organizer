// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

import 'package:company_tasks_organizer/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';

class TextFormFieldComponent extends StatelessWidget {
  TextFormFieldComponent(
      {this.controller,
      this.keyboardType,
      this.onChanged,
      this.validator,
      this.onTap,
      required this.label,
      this.labelStyle,
      required this.obscureText,
      this.onFiledSubmitted,
      this.prefixIcon,
      this.maxLines,
      this.minLines,
      this.style,
      this.suffixIcon,
      this.suffixOnPressed});

  TextEditingController? controller;
  TextInputType? keyboardType;
  String label;
  TextStyle? labelStyle;
  TextStyle? style;
  IconData? prefixIcon;
  IconData? suffixIcon;
  ValueChanged<dynamic>? onFiledSubmitted;
  Function(String)? onChanged;
  FormFieldValidator<String>? validator;
  bool obscureText = false;
  VoidCallback? suffixOnPressed;
  GestureTapCallback? onTap;
  int? minLines;
  int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      minLines: minLines,
      obscureText: obscureText,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      style: TextStyle(
          color:
              AppCubit.get(context).isDark ? Colors.green : Colors.deepOrange,
          fontSize: 18),
      onFieldSubmitted: onFiledSubmitted,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            width: 2,
            color: AppCubit.get(context).isDark ? Colors.white : Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
              width: 2,
              color: AppCubit.get(context).isDark
                  ? Colors.green
                  : Colors.deepOrange),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            width: 2,
            color: Colors.red,
          ),
        ),
        label: Text(
          label,
          style: TextStyle(
            color: AppCubit.get(context).isDark ? Colors.grey : null,
          ),
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: AppCubit.get(context).isDark ? Colors.white : Colors.black,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(
                  suffixIcon,
                ),
                onPressed: suffixOnPressed,
              )
            : null,
      ),
    );
  }
}
