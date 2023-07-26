// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_tasks_organizer/shared/components/components.dart';
import 'package:company_tasks_organizer/shared/components/defaultTextFormField.dart';

import 'package:company_tasks_organizer/shared/cubit/cubit.dart';
import 'package:company_tasks_organizer/shared/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:intl/intl.dart';

class PersonalAttendanceScreen extends StatefulWidget {
  PersonalAttendanceScreen({Key? key}) : super(key: key);

  static String id = 'PersonalAttendance';

  @override
  State<PersonalAttendanceScreen> createState() => _PersonalAttendanceState();
}

class _PersonalAttendanceState extends State<PersonalAttendanceScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  String? code;

  CollectionReference record = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Record');

  CollectionReference attendance = FirebaseFirestore.instance
      .collection('Attendance')
      .doc(DateFormat('MMMM').format(DateTime.now()))
      .collection(DateFormat('dd').format(DateTime.now()));

  CollectionReference lateAttendance = FirebaseFirestore.instance
      .collection('Attendance')
      .doc(DateFormat('MMMM').format(DateTime.now()))
      .collection(
          DateFormat('dd').format(DateTime.now().subtract(Duration(days: 1))));

  @override
  void initState() {
    super.initState();
    AppLoginCubit.get(context).getName();
    getRecord();
  }

  Future<void> getRecord() async {
    try {
      DocumentSnapshot user = await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();

      DocumentSnapshot snap = await attendance.doc(user['name']).get();

      setState(() {
        AppLoginCubit.get(context).checkIn = snap['Check In'];
        AppLoginCubit.get(context).checkOut = snap['Check Out'];
      });
    } catch (e) {
      setState(() {
        AppLoginCubit.get(context).checkIn = '--/--';
        AppLoginCubit.get(context).checkOut = '--/--';
      });
    }
  }

  String location = ' ';
  late String lat;
  late String long;

  Future<Position?> getCurrentLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    return await Geolocator.getCurrentPosition();
  }

  void liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
      distanceFilter: 100,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();

      setState(() {
        location = '$lat , $long';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    var formKey = GlobalKey<FormState>();

    return StreamBuilder<DocumentSnapshot>(
        stream: attendance.doc(AppLoginCubit.get(context).name).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text(translator.translate('personalAttending')),
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Text(
                            translator.translate('welcome'),
                            style: TextStyle(
                              color: AppCubit.get(context).isDark
                                  ? Colors.white
                                  : HexColor('333739'),
                              fontSize: screenWidth / 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenWidth / 20,
                    ),
                    Stack(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 50),
                            child: Text(
                              AppLoginCubit.get(context).name ?? " ",
                              style: TextStyle(
                                  fontSize: screenWidth / 20,
                                  color: AppCubit.get(context).isDark
                                      ? Colors.green
                                      : Colors.orange,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenWidth / 20,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 32),
                      child: Text(
                        translator.translate('todaysStatus'),
                        style: TextStyle(
                          fontSize: screenWidth / 18,
                          fontWeight: FontWeight.w500,
                          color: AppCubit.get(context).isDark
                              ? Colors.white
                              : HexColor('333739'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12, bottom: 32),
                      height: screenWidth - 250,
                      decoration: BoxDecoration(
                        color: AppCubit.get(context).isDark
                            ? HexColor('333739')
                            : Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(2, 2)),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  translator.translate('checkIn'),
                                  style: TextStyle(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : HexColor('333739'),
                                    fontWeight: FontWeight.w500,
                                    fontSize: screenWidth / 20,
                                  ),
                                ),
                                SizedBox(
                                  height: screenWidth / 25,
                                ),
                                Text(
                                  AppLoginCubit.get(context).checkIn,
                                  style: TextStyle(
                                    fontSize: screenWidth / 18,
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : HexColor('333739'),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  translator.translate('checkOut'),
                                  style: TextStyle(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : HexColor('333739'),
                                    fontWeight: FontWeight.w500,
                                    fontSize: screenWidth / 20,
                                  ),
                                ),
                                SizedBox(
                                  height: screenWidth / 25,
                                ),
                                Text(
                                  AppLoginCubit.get(context).checkOut,
                                  style: TextStyle(
                                      fontSize: screenWidth / 18,
                                      color: AppCubit.get(context).isDark
                                          ? Colors.white
                                          : HexColor('333739'),
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                              text: DateTime.now().day.toString(),
                              style: TextStyle(
                                fontSize: screenWidth / 15,
                                color: AppCubit.get(context).isDark
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                                TextSpan(
                                  text: DateFormat('  MMMM yyyy')
                                      .format(DateTime.now()),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: screenWidth / 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        StreamBuilder(
                            stream: Stream.periodic(const Duration(seconds: 1)),
                            builder: (context, snapshot) {
                              return Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  DateFormat('hh:mm:ss a')
                                      .format(DateTime.now()),
                                  style: TextStyle(
                                    fontSize: screenWidth / 15,
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : null,
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                    AppLoginCubit.get(context).checkOut == '--/--'
                        ? Container(
                            margin: EdgeInsets.only(top: 24, bottom: 12),
                            child: Builder(
                              builder: (context) {
                                final GlobalKey<SlideActionState> key =
                                    GlobalKey();
                                return SlideAction(
                                  text: AppLoginCubit.get(context).checkIn ==
                                          '--/--'
                                      ? translator.translate('slidetoCheckIn')
                                      : translator
                                          .translate('slidetoCheck Out'),
                                  textStyle: TextStyle(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : HexColor('333739'),
                                    fontSize: screenWidth / 22,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  outerColor: AppCubit.get(context).isDark
                                      ? HexColor('333739')
                                      : Colors.white,
                                  innerColor: AppCubit.get(context).isDark
                                      ? Colors.green
                                      : Colors.orange,
                                  key: key,
                                  onSubmit: () async {
                                    // print(DateFormat('dd').format(DateTime.now()
                                    //     .subtract(Duration(days: 1))));
                                    // DateTime now = DateTime.now();
                                    // DateTime midnight =
                                    //     DateTime(now.year, now.month, now.day);
                                    // DateTime fourAM = DateTime(
                                    //     now.year, now.month, now.day, 4);
                                    // if (now.isAfter(midnight) &&
                                    //     now.isBefore(fourAM)) {
                                    //   print('Done');

                                    // }
                                    getCurrentLocation().then((value) {
                                      lat = '${value!.latitude}';
                                      long = '${value.longitude}';
                                      setState(() {
                                        location = '$lat , $long';
                                      });
                                    });
                                    showDialog(
                                      context: context,
                                      builder: (_) => BlocConsumer<
                                          AppLoginCubit, AppLoginStates>(
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0))),
                                              content: Builder(
                                                builder: (context) {
                                                  return Container(
                                                    height: screenWidth - 100,
                                                    width: double.infinity,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          translator.translate(
                                                              'enterYourCode'),
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
                                                          height: 30,
                                                        ),
                                                        defaultTextFormFieldM(
                                                          maxLines: 1,
                                                          suffixIcon: AppLoginCubit
                                                                      .get(
                                                                          context)
                                                                  .isSecureCode
                                                              ? Iconsax.eye
                                                              : Iconsax
                                                                  .eye_slash,
                                                          suffixOnPressed: () {
                                                            AppLoginCubit.get(
                                                                    context)
                                                                .secureCode();
                                                          },
                                                          obscureText:
                                                              AppLoginCubit.get(
                                                                      context)
                                                                  .isSecureCode,
                                                          label: translator
                                                              .translate(
                                                                  'enterYourCode'),
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          prefixIcon:
                                                              Iconsax.code,
                                                          onChanged: (value) {
                                                            code = value;
                                                          },
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return translator
                                                                  .translate(
                                                                      'codemustntbeEmpty');
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                        SizedBox(
                                                          height: 30,
                                                        ),
                                                        myButton(
                                                            text: translator
                                                                .translate(
                                                                    'submit'),
                                                            onPressed:
                                                                () async {
                                                              SharedPreferences
                                                                  prefs =
                                                                  await SharedPreferences
                                                                      .getInstance();

                                                              if (formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                if (code ==
                                                                    prefs.getString(
                                                                        'userCode')) {
                                                                  DateTime now =
                                                                      DateTime
                                                                          .now();
                                                                  DateTime
                                                                      midnight =
                                                                      DateTime(
                                                                          now.year,
                                                                          now.month,
                                                                          now.day);
                                                                  DateTime
                                                                      fourAM =
                                                                      DateTime(
                                                                          now.year,
                                                                          now.month,
                                                                          now.day,
                                                                          4);
                                                                  if (now.isAfter(
                                                                          midnight) &&
                                                                      now.isBefore(
                                                                          fourAM)) {
                                                                    AppLoginCubit.get(
                                                                            context)
                                                                        .changeCheckOut();
                                                                    Navigator.pop(
                                                                        context);
                                                                    lateAttend2();
                                                                  } else {
                                                                    if (AppLoginCubit.get(context)
                                                                            .checkIn ==
                                                                        '--/--') {
                                                                      AppLoginCubit.get(
                                                                              context)
                                                                          .changeCheckIn();
                                                                      Navigator.pop(
                                                                          context);
                                                                      attend();
                                                                    } else {
                                                                      AppLoginCubit.get(
                                                                              context)
                                                                          .changeCheckOut();
                                                                      Navigator.pop(
                                                                          context);
                                                                      attend2();
                                                                    }
                                                                  }
                                                                } else {
                                                                  Navigator.pop(
                                                                      context);
                                                                  showSnackBar(
                                                                      context,
                                                                      'Wrong Code',
                                                                      Colors
                                                                          .red);
                                                                }
                                                              }
                                                            }),
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
                                    key.currentState!.reset();
                                  },
                                );
                              },
                            ))
                        : Container(
                            margin: EdgeInsets.only(top: 32, bottom: 32),
                            child: Text(
                              translator.translate('Youhavecompletedthisday'),
                              style: TextStyle(
                                fontSize: screenWidth / 20,
                                color: AppCubit.get(context).isDark
                                    ? Colors.green
                                    : Colors.orange,
                              ),
                            ),
                          ),
                  ],
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
        });
  }

  Future<void> attend() async {
    DocumentSnapshot user = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    await attendance.doc(user['name']).set({
      'name': user['name'],
      'Check In': AppLoginCubit.get(context).checkIn,
      'Check Out': AppLoginCubit.get(context).checkOut,
      'Date': Timestamp.now(),
      'LocationCheckIn': location,
      'LocationCheckOut': ' ',
    });
  }

  Future<void> attend2() async {
    DocumentSnapshot user = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    await attendance.doc(user['name']).update({
      'Check Out': AppLoginCubit.get(context).checkOut,
      'Date': Timestamp.now(),
      'LocationCheckOut': location,
    });
  }

  Future<void> lateAttend2() async {
    DocumentSnapshot user = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    await lateAttendance.doc(user['name']).update({
      'Check Out': AppLoginCubit.get(context).checkOut,
      'Date': Timestamp.now(),
      'LocationCheckOut': location,
    });
  }
}
