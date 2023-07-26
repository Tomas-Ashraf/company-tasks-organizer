// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';

class InkWellComponent extends StatelessWidget {
  InkWellComponent({
    required this.onTap,
    required this.text,
    required this.icon,
    this.iconSize,
    this.color,
  });

  GestureTapCallback onTap;
  IconData icon;
  String text;
  double? iconSize = 50;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Column(
          children: [
            Icon(
              icon,
              size: iconSize,
            ),
            SizedBox(
              height: 15,
            ),
            Text(text, style: Theme.of(context).textTheme.bodyText1),
          ],
        ),
      ),
    );
  }
}
