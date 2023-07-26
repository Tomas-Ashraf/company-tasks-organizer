// ignore_for_file: prefer_const_constructors, deprecated_member_use, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_tasks_organizer/shared/cubit/cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    AppLoginCubit.get(context).selectPermission();
    AppLoginCubit.get(context).getName();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          translator.translate('welcome'),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Lottie.asset('assets/images/Home_Dark.json',
                            width: 300),
                        Text(
                          snapshot.data!['name'],
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          snapshot.data!['department'],
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
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
}
