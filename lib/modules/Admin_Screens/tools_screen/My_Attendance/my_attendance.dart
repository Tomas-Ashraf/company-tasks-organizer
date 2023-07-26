// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, avoid_print, sized_box_for_whitespace, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/tools_screen/Employees_Attebding/webview.dart';
import 'package:company_tasks_organizer/shared/components/defaultTextFormField.dart';
import 'package:company_tasks_organizer/shared/cubit/cubit.dart';
import 'package:company_tasks_organizer/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class MyAttendance extends StatefulWidget {
  const MyAttendance({Key? key}) : super(key: key);

  static String id = 'MyAttendance';

  @override
  State<MyAttendance> createState() => _MyAttendanceState();
}

class _MyAttendanceState extends State<MyAttendance> {
  double screenHeight = 0;
  double screenWidth = 0;

  late String month = DateTime.now().toString();
  late String day = DateTime.now().toString();
  late String year = DateTime.now().toString();

  dynamic monthController = DateFormat('MMMM').format(DateTime.now());
  dynamic dayController = DateFormat('dd').format(DateTime.now());
  dynamic yearController = DateFormat('yyyy').format(DateTime.now());

  // Future<void> openMap(location) async {
  //   String googleURL =
  //       'https://www.google.com/maps/search/?api=1&query=$location';
  //   await canLaunchUrlString(googleURL)
  //       ? await launchUrlString(googleURL)
  //       : throw 'Could not lanch $googleURL';
  // }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    var formKey = GlobalKey<FormState>();
    dynamic dateOfBirth = TextEditingController();
    var name = ModalRoute.of(context)!.settings.arguments;

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Attendance')
            .doc(monthController)
            .collection(dayController)
            .snapshots(),
        builder: (context, snapshot) {
          {
            if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(translator.translate('myAttendance')),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(children: [
                      Stack(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(top: 32),
                            child: Text(
                              dayController +
                                  ' ' +
                                  monthController +
                                  ' ' +
                                  yearController,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppCubit.get(context).isDark
                                    ? Colors.green
                                    : Colors.orange,
                                fontSize: screenWidth / 20,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            margin: const EdgeInsets.only(top: 32, bottom: 30),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => BlocConsumer<AppLoginCubit,
                                      AppLoginStates>(
                                    listener: (context, state) {},
                                    builder: (context, state) {
                                      return Form(
                                        key: formKey,
                                        child: AlertDialog(
                                          backgroundColor:
                                              AppCubit.get(context).isDark
                                                  ? HexColor('333739')
                                                  : Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                          ),
                                          content: Builder(
                                            builder: (context) {
                                              return Container(
                                                height: screenWidth - 250,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      translator
                                                          .translate('pickDay'),
                                                      style: TextStyle(
                                                        color: AppCubit.get(
                                                                    context)
                                                                .isDark
                                                            ? Colors.white
                                                            : HexColor(
                                                                '333739'),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: screenWidth / 30,
                                                    ),
                                                    defaultTextFormFieldM(
                                                      controller: dateOfBirth,
                                                      obscureText: false,
                                                      label: translator
                                                          .translate('pickDay'),
                                                      prefixIcon:
                                                          Iconsax.calendar_add,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return translator
                                                              .translate(
                                                                  'daymustntbeEmpty');
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      onTap: () {
                                                        showDatePicker(
                                                          context: context,
                                                          firstDate:
                                                              DateTime.parse(
                                                                  '2023-01-01'),
                                                          initialDate:
                                                              DateTime.now(),
                                                          lastDate:
                                                              DateTime.parse(
                                                                  '2025-01-01'),
                                                        ).then(
                                                          (value) {
                                                            setState(() {
                                                              monthController =
                                                                  DateFormat(
                                                                          'MMMM')
                                                                      .format(
                                                                          value!);
                                                              dayController =
                                                                  DateFormat(
                                                                          'dd')
                                                                      .format(
                                                                          value);
                                                              yearController =
                                                                  DateFormat(
                                                                          'yyyy')
                                                                      .format(
                                                                          value);
                                                              print(
                                                                  monthController);
                                                              print(
                                                                  dayController);
                                                              print(
                                                                  yearController);
                                                              print(value);
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        );
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                FocusNode());
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                translator.translate('pickDay'),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppCubit.get(context).isDark
                                      ? Colors.green
                                      : Colors.orange,
                                  fontSize: screenWidth / 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: screenHeight - 180,
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              if (snapshot.data!.docs[index]['name'] == name) {
                                return Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Container(
                                    height: 220,
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    AppCubit.get(context).isDark
                                                        ? Colors.green
                                                        : Colors.orange,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Text(
                                                  snapshot.data!.docs[index]
                                                      ['name'],
                                                  style: TextStyle(
                                                    color: AppCubit.get(context)
                                                            .isDark
                                                        ? HexColor('333739')
                                                        : Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: screenWidth / 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: screenWidth / 20,
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      translator
                                                          .translate('checkIn'),
                                                      style: TextStyle(
                                                        color: AppCubit.get(
                                                                    context)
                                                                .isDark
                                                            ? Colors.white
                                                            : HexColor(
                                                                '333739'),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize:
                                                            screenWidth / 20,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: screenWidth / 35,
                                                    ),
                                                    Text(
                                                      snapshot.data!.docs[index]
                                                          ['Check In'],
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: AppCubit.get(
                                                                    context)
                                                                .isDark
                                                            ? Colors.white
                                                            : HexColor(
                                                                '333739'),
                                                        fontSize:
                                                            screenWidth / 20,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: screenWidth / 20,
                                                    ),
                                                    Container(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.pushNamed(
                                                              context,
                                                              LocationMap.id,
                                                              arguments: snapshot
                                                                          .data!
                                                                          .docs[
                                                                      index][
                                                                  'LocationCheckIn']);
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Text(
                                                            translator.translate(
                                                                'checkInLocation'),
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppCubit
                                                                          .get(
                                                                              context)
                                                                      .isDark
                                                                  ? HexColor(
                                                                      '333739')
                                                                  : Colors
                                                                      .white,
                                                              fontSize:
                                                                  screenWidth /
                                                                      21,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: AppCubit.get(
                                                                    context)
                                                                .isDark
                                                            ? Colors.green
                                                            : Colors.orange,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      translator.translate(
                                                          'checkOut'),
                                                      style: TextStyle(
                                                        color: AppCubit.get(
                                                                    context)
                                                                .isDark
                                                            ? Colors.white
                                                            : HexColor(
                                                                '333739'),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize:
                                                            screenWidth / 20,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: screenWidth / 35,
                                                    ),
                                                    Text(
                                                      snapshot.data!.docs[index]
                                                          ['Check Out'],
                                                      style: TextStyle(
                                                          color: AppCubit.get(
                                                                      context)
                                                                  .isDark
                                                              ? Colors.white
                                                              : HexColor(
                                                                  '333739'),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize:
                                                              screenWidth / 20),
                                                    ),
                                                    SizedBox(
                                                      height: screenWidth / 20,
                                                    ),
                                                    Container(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.pushNamed(
                                                              context,
                                                              LocationMap.id,
                                                              arguments: snapshot
                                                                          .data!
                                                                          .docs[
                                                                      index][
                                                                  'LocationCheckOut']);
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Text(
                                                            translator.translate(
                                                                'checkOutLocation'),
                                                            style: TextStyle(
                                                              color: AppCubit
                                                                          .get(
                                                                              context)
                                                                      .isDark
                                                                  ? HexColor(
                                                                      '333739')
                                                                  : Colors
                                                                      .white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize:
                                                                  screenWidth /
                                                                      21,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: AppCubit.get(
                                                                    context)
                                                                .isDark
                                                            ? Colors.green
                                                            : Colors.orange,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            }),
                      )
                    ]),
                  ),
                ),
              );
            } else {
              return Scaffold(
                body: ModalProgressHUD(
                  inAsyncCall: true,
                  child: Text(''),
                ),
              );
            }
          }
        });
  }
}
