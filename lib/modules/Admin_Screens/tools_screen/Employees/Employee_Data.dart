// ignore_for_file: prefer_const_constructors, deprecated_member_use, sized_box_for_whitespace, must_be_immutable, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EmployeeData extends StatelessWidget {
  EmployeeData({Key? key}) : super(key: key);

  static String id = 'EmployeeData';
  double screenHeight = 0;
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text(translator.translate('yourData')),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(50, 70, 30, 50),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Iconsax.user_tag, size: 35),
                          SizedBox(width: 40),
                          Container(
                            width: screenWidth - 155,
                            child: Text(
                              FirebaseAuth.instance.currentUser!.uid ==
                                      snapshot.data!['Uid']
                                  ? '${snapshot.data!['name']} (You)'
                                  : snapshot.data!['name'],
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Icon(Icons.email_outlined, size: 35),
                          SizedBox(width: 40),
                          Container(
                            width: screenWidth - 155,
                            child: Text(
                              snapshot.data!['email'],
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Icon(Iconsax.mobile, size: 35),
                          SizedBox(width: 40),
                          SelectableText(
                            snapshot.data!['phone'],
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Icon(Icons.password_rounded, size: 35),
                          SizedBox(width: 40),
                          Container(
                            width: screenWidth - 155,
                            child: Text(
                              snapshot.data!['password'],
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Icon(Iconsax.code, size: 35),
                          SizedBox(width: 40),
                          Text(
                            snapshot.data!['code'],
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Icon(Iconsax.buildings_2, size: 35),
                          SizedBox(width: 40),
                          Text(
                            snapshot.data!['department'],
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Icon(Iconsax.man, size: 35),
                          SizedBox(width: 40),
                          Text(
                            snapshot.data!['gender'],
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Icon(Iconsax.security_user, size: 35),
                          SizedBox(width: 40),
                          Text(
                            snapshot.data!['permission'],
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ],
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
