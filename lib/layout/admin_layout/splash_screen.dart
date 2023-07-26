// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors,, annotate_overrides

import 'dart:async';
import 'package:company_tasks_organizer/shared/cubit/cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    startTime();
  }

  startTime() {
    var duration = Duration(seconds: 7);
    return Timer(duration, route);
  }

  route() {
    // Navigator.pushNamedAndRemoveUntil(context, FirebaseAuth.instance.currentUser?.uid == null ? 'LoginScreen' :  (FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) => value.get('permission')) == 'Admin' ? 'AppLayoutEmployee' : 'AppLayout' ), (route) => false);
    Navigator.pushNamedAndRemoveUntil(
        context,
        FirebaseAuth.instance.currentUser?.uid == null
            ? 'LoginScreen'
            : 'AppLayout',
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppCubit.get(context).isDark
          ? HexColor('#333739')
          : HexColor('#FFFFFF'),
      body: Center(
        child: Container(
          child: Lottie.asset(
            'assets/images/Splash_Screen.json',
            fit: BoxFit.cover,
            width: double.maxFinite,
          ),
        ),
      ),
    );
  }
}
