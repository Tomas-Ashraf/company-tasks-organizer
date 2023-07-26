// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, annotate_overrides, override_on_non_overriding_member, use_key_in_widget_constructors, must_be_immutable, file_names, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/tools_screen/Employees/Employees_Details/employees_details_screen.dart';
import 'package:company_tasks_organizer/shared/cubit/cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EmployeesScreen extends StatelessWidget {
  @override
  static String id = 'EmployeesScreen';
  double screenHeight = 0;
  double screenWidth = 0;

  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .orderBy('time')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(translator.translate('employees')),
              actions: [
                AppLoginCubit.get(context).permission == 'Admin'
                    ? IconButton(
                        icon: Icon(Iconsax.user_add),
                        onPressed: () {
                          Navigator.pushNamed(context, 'AddEmployeeScreen');
                        })
                    : Container()
              ],
            ),
            body: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, EmployeesDetailsScreen.id,
                        arguments: snapshot.data!.docs[index]['Uid']);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                        start: 5,
                        end: 2,
                        bottom: 10,
                        top: 10,
                      ),
                      child: Row(children: [
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                  child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: AppCubit.get(context).isDark
                                      ? Colors.green
                                      : Colors.orange,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 35,
                                    ),
                                  ),
                                ),
                              )),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      FirebaseAuth.instance.currentUser!.uid ==
                                              snapshot.data!.docs[index]['Uid']
                                          ? '${snapshot.data!.docs[index]['name']} (You)'
                                          : snapshot.data!.docs[index]['name'],
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: AppCubit.get(context).isDark
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SelectableText(
                                      snapshot.data!.docs[index]['phone'],
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: AppCubit.get(context).isDark
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data!.docs[index]['department'],
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: AppCubit.get(context).isDark
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CupertinoAlertDialog(
                                            title: Text(translator.translate(
                                                'areyousuretoDeleteUser?')),
                                            actions: [
                                              CupertinoDialogAction(
                                                child: Text(translator
                                                    .translate('yes')),
                                                onPressed: () {
                                                  final CollectionReference
                                                      userCollection =
                                                      FirebaseFirestore.instance
                                                          .collection('Users');
                                                  userCollection
                                                      .doc(snapshot.data!
                                                          .docs[index]['Uid'])
                                                      .delete();
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              CupertinoDialogAction(
                                                child: Text(
                                                    translator.translate('no')),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(Iconsax.profile_delete)),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(),
              itemCount: snapshot.data!.docs.length,
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
      },
    );
  }
}
