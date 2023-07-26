// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:company_tasks_organizer/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';

class MatrialButtonComponent extends StatelessWidget {
  MatrialButtonComponent({
    required this.text,
    this.onPressed,
    required this.isUpperCase,
  });

  String text;
  VoidCallback? onPressed;
  bool isUpperCase = true;

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
        child: Text(isUpperCase ? text.toUpperCase() : text,
            style: TextStyle(
                color:
                    AppCubit.get(context).isDark ? Colors.black : Colors.white,
                fontSize: 20)),
      ),
    );
  }
}
