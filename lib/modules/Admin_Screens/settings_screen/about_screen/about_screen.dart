// ignore_for_file: must_be_immutable, prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:company_tasks_organizer/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({Key? key}) : super(key: key);

  static String id = 'AboutScreen';
  double screenHeight = 0;
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(translator.translate('about')),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: AppCubit.get(context).isDark
                      ? HexColor('333739')
                      : Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 15,
                        offset: Offset(2, 2)),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                padding: EdgeInsetsDirectional.only(
                    start: 5, end: 2, bottom: 10, top: 10),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    translator.translate('version'),
                    style: TextStyle(
                      fontSize: screenWidth / 20,
                      color: AppCubit.get(context).isDark
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenWidth / 10,
            ),
            Text(
              translator.translate('thisAPPisprogrammedby'),
              style: TextStyle(
                fontSize: screenWidth / 20,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: screenWidth / 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: AppCubit.get(context).isDark
                      ? HexColor('333739')
                      : Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 15,
                        offset: Offset(2, 2)),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                padding: EdgeInsetsDirectional.only(
                    start: 5, end: 2, bottom: 10, top: 10),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text(
                          translator.translate('tomas'),
                          style: TextStyle(
                            fontSize: screenWidth / 20,
                            color: AppCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SelectableText(
                        'tomasashraf70@gmail.com',
                        style: TextStyle(
                          fontSize: screenWidth / 20,
                          color: AppCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenWidth / 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: AppCubit.get(context).isDark
                      ? HexColor('333739')
                      : Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 15,
                        offset: Offset(2, 2)),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                padding: EdgeInsetsDirectional.only(
                    start: 5, end: 2, bottom: 10, top: 10),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text(
                          translator.translate('mahmoud'),
                          style: TextStyle(
                            fontSize: screenWidth / 20,
                            color: AppCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SelectableText(
                        'mahmoudabdelaty2002@gmail.com',
                        style: TextStyle(
                          fontSize: screenWidth / 22,
                          color: AppCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
