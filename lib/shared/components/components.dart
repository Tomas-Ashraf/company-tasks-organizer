// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, deprecated_member_use, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/tasks_screen/announce_screen/announce.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/tasks_screen/company_mission/company_mission.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/tasks_screen/finished_tasks/finished_tasks.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/tasks_screen/today_tasks/today_tasks.dart';
import 'package:company_tasks_organizer/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

Widget defaultTextFormField({
  required TextEditingController? controller,
  required TextInputType? type,
  String? labelText,
  TextStyle? labelStyle,
  TextStyle? style,
  required IconData prefixIcon,
  IconData? suffixIcon,
  ValueChanged<dynamic>? onFiledSubmitted,
  ValueChanged? onChanged,
  FormFieldValidator<String>? validator,
  bool obscureText = false,
  VoidCallback? suffixOnPressed,
  AutovalidateMode? autoValidateMode,
  GestureTapCallback? onTap,
  TextStyle? textStyle,
  double radius = 20,
  Color color = Colors.white,
  int? minLines,
  int? maxLines,
  String? initialValue,
}) =>
    Container(
      width: 350,
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        minLines: minLines,
        maxLines: maxLines,
        initialValue: initialValue,
        autovalidateMode: autoValidateMode,
        onFieldSubmitted: onFiledSubmitted,
        onChanged: onChanged,
        style: TextStyle(color: color),
        validator: validator,
        obscureText: obscureText,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: suffixIcon == null
              ? null
              : IconButton(
                  icon: Icon(
                    suffixIcon,
                  ),
                  onPressed: suffixOnPressed,
                ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: color,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              width: 2,
              color: color,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              width: 2,
              color: Colors.deepOrange,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: HexColor('#f90000'), width: 2),
          ),
        ),
      ),
    );

Widget myButton({
  double width = 200,
  Color color = Colors.black,
  required String text,
  required Function onPressed,
  bool isUpperCase = true,
  Color textColor = Colors.white,
  double radius = 20,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
      width: width,
      child: MaterialButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );

void myNavigatePush(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void myNavigatePushAndRemoveUntil(context, widget) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );

Widget myInkwell(context,
        {GestureTapCallback? onTap,
        IconData? icon,
        String? text,
        double size = 50.0}) =>
    InkWell(
      onTap: onTap,
      child: Container(
        child: Column(
          children: [
            Icon(
              icon,
              size: size,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              text!,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );

// Widget myHomeScreen(context) => Padding(
//       padding: EdgeInsets.all(20),
//       child: Center(
//         child: Column(
//           children: [
//             Text(
//               translator.translate(
//                 'Welcome',
//               ),
//               style: Theme.of(context).textTheme.bodyText1,
//             ),
//             Lottie.asset('assets/images/Home_Dark.json', width: 300),
//             Text(
//               'Eng: Ahmed Salah',
//               style: Theme.of(context).textTheme.bodyText1,
//             ),
//             SizedBox(
//               height: 15.0,
//             ),
//             Text(
//               'Projects Manager',
//               style: Theme.of(context).textTheme.bodyText1,
//             ),
//           ],
//         ),
//       ),
//     );

Widget myTasksScreen(context) => Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          myInkwell(context,
              onTap: () => myNavigatePush(context, AnnounceScreen()),
              icon: Iconsax.microphone,
              text: translator.translate('announceAMission')),
          SizedBox(
            height: 30.0,
          ),
          myInkwell(context,
              onTap: () => myNavigatePush(context, CompanyMissionScreen()),
              icon: Iconsax.task,
              text: translator.translate('companyMissions')),
          SizedBox(
            height: 30.0,
          ),
          myInkwell(context,
              onTap: () => myNavigatePush(context, TodayTasksScreen()),
              icon: Iconsax.calendar,
              text: translator.translate('todayTasks')),
          SizedBox(
            height: 30.0,
          ),
          myInkwell(context,
              onTap: () => myNavigatePush(context, FinishTasksScreen()),
              icon: Icons.done_all,
              text: translator.translate('finishedTasks')),
        ],
      ),
    );

Widget buildSeparator() =>
    Container(height: 2, width: double.infinity, color: Colors.black);

void showSnackBar(
  BuildContext context,
  String message,
  Color backgroundColor,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      padding: EdgeInsets.all(10),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: 10),
    ),
  );
}

Widget editButton({
  required String controllerName,
  required CollectionReference collectionName,
  required dynamic snapShotID,
  required String field,
  required context,
}) =>
    IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            var controllerName = TextEditingController();

            return Container(
              width: 400,
              child: AlertDialog(
                backgroundColor: AppCubit.get(context).isDark
                    ? HexColor('333739')
                    : Colors.white,
                title: Text(translator.translate('update')),
                titleTextStyle: TextStyle(
                  color: AppCubit.get(context).isDark
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
                content: Container(
                    width: 200,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        defaultTextFormField(
                          controller: controllerName,
                          type: TextInputType.multiline,
                          minLines: 3,
                          prefixIcon: Icons.people,
                          labelText: translator.translate('typeNewValue'),
                          textStyle: TextStyle(
                            color: AppCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                          color: AppCubit.get(context).isDark
                              ? Colors.grey
                              : Colors.black,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(bottom: 10),
                          child: myButton(
                              text: translator.translate('submit'),
                              textColor: AppCubit.get(context).isDark
                                  ? Colors.black
                                  : Colors.white,
                              color: AppCubit.get(context).isDark
                                  ? Colors.white
                                  : HexColor('333739'),
                              onPressed: () async {
                                AppCubit.get(context).updateTask(
                                  collectionName: collectionName,
                                  snapShotID: snapShotID,
                                  field: field,
                                  newText: controllerName.text,
                                );
                                Navigator.pop(context);
                              }),
                        ),
                      ],
                    )),
              ),
            );
          },
        );
      },
      icon: Icon(Icons.edit),
    );
