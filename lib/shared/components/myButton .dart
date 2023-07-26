// ignore_for_file: must_be_immutable, camel_case_types, file_names, use_key_in_widget_constructors

import 'package:company_tasks_organizer/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';

class myButton extends StatelessWidget {
  myButton({required this.text, this.onPressed, this.fontSize});

  String text;
  VoidCallback? onPressed;
  double? fontSize = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: AppCubit.get(context).isDark ? Colors.white : Colors.black,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(text,
            style: TextStyle(
              color: AppCubit.get(context).isDark ? Colors.black : Colors.white,
              fontSize: fontSize,
            )),
      ),
    );
  }
}
