// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print, unused_local_variable, prefer_const_literals_to_create_immutables, unused_element, sort_child_properties_last, must_be_immutable, deprecated_member_use, sized_box_for_whitespace, use_build_context_synchronously, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/backup_screen/backup.dart';
import 'package:company_tasks_organizer/shared/colors/colors.dart';
import 'package:company_tasks_organizer/shared/components/defaultTextFormField.dart';
import 'package:company_tasks_organizer/shared/constants/constants.dart';
import 'package:company_tasks_organizer/shared/cubit/cubit.dart';
import 'package:company_tasks_organizer/shared/cubit/states.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class CompanyMissionScreen extends StatefulWidget {
  @override
  State<CompanyMissionScreen> createState() => _CompanyMissionScreenState();
}

class _CompanyMissionScreenState extends State<CompanyMissionScreen> {
  final Stream<QuerySnapshot> tasksStream = FirebaseFirestore.instance
      .collection(KTasksFire)
      .orderBy('published_time', descending: false)
      .snapshots();

  CollectionReference tasks = FirebaseFirestore.instance.collection(KTasksFire);
  var historyController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: tasksStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text(translator.translate('companyMissions')),
                actions: [
                  AppLoginCubit.get(context).permission == 'Admin'
                      ? TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) =>
                                  BlocConsumer<AppLoginCubit, AppLoginStates>(
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
                                            height: 100,
                                            child: Column(
                                              children: [
                                                Text(
                                                  translator
                                                      .translate('chooseDate'),
                                                  style: TextStyle(
                                                    color: AppCubit.get(context)
                                                            .isDark
                                                        ? Colors.white
                                                        : HexColor('333739'),
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                defaultTextFormFieldM(
                                                  controller: historyController,
                                                  obscureText: false,
                                                  label: translator
                                                      .translate('chooseDate'),
                                                  prefixIcon:
                                                      Iconsax.calendar_add,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return translator
                                                          .translate(
                                                              'pleaseEnterDate');
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  onTap: () {
                                                    showDatePicker(
                                                      context: context,
                                                      firstDate: DateTime.parse(
                                                          '2023-01-01'),
                                                      initialDate:
                                                          DateTime.now(),
                                                      lastDate: DateTime.parse(
                                                          '2025-01-01'),
                                                    ).then(
                                                      (value) {
                                                        setState(() {
                                                          dynamic dateValue =
                                                              DateFormat()
                                                                  .add_yMMMM()
                                                                  .format(
                                                                      value!);

                                                          print(dateValue);
                                                          Navigator.pushNamed(
                                                              context,
                                                              BackUpScreen.id,
                                                              arguments:
                                                                  dateValue);
                                                        });
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
                            translator.translate('history'),
                            style: TextStyle(color: Colors.blue),
                          ))
                      : SizedBox(),
                ],
              ),
              body: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
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
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, 'CompanyMissionsDetailsScreen',
                                  arguments: index);
                            },
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        snapshot.data!.docs[index]
                                            ['client_name'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: AppCubit.get(context).isDark
                                              ? darkTextLight
                                              : lightTextLight,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]
                                            ['client_address'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: AppCubit.get(context).isDark
                                              ? darkTextLight
                                              : lightTextLight,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SelectableText(
                                        snapshot.data!.docs[index]
                                            ['client_phone'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: AppCubit.get(context).isDark
                                              ? darkTextLight
                                              : lightTextLight,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]
                                            ['mission_type'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: AppCubit.get(context).isDark
                                              ? darkTextLight
                                              : lightTextLight,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        AppLoginCubit.get(context).permission == 'Admin'
                            ? Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  end: 15,
                                ),
                                child: IconButton(
                                    icon: Icon(
                                      Icons.delete_forever_rounded,
                                      size: 35,
                                      color: Colors.redAccent,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CupertinoAlertDialog(
                                            title: Text(
                                                translator.translate('alert')),
                                            content: Text(translator
                                                .translate('missionAlert')),
                                            actions: [
                                              CupertinoDialogAction(
                                                child: Text(translator
                                                    .translate('yes')),
                                                onPressed: () async {
                                                  if (snapshot.data!
                                                      .docs[index]['image_name']
                                                      .toString()
                                                      .isEmpty) {
                                                    AppCubit.get(context)
                                                        .deleteTask(
                                                            collectionName:
                                                                tasks,
                                                            snapShotID: snapshot
                                                                .data!
                                                                .docs[index]
                                                                .id);
                                                  } else {
                                                    final Reference storageRef =
                                                        FirebaseStorage.instance
                                                            .ref()
                                                            .child(
                                                                'tasks/${snapshot.data!.docs[index]['image_name']}');
                                                    await storageRef.delete();
                                                    AppCubit.get(context)
                                                        .deleteTask(
                                                            collectionName:
                                                                tasks,
                                                            snapShotID: snapshot
                                                                .data!
                                                                .docs[index]
                                                                .id);
                                                    Navigator.pop(context);
                                                  }

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
                                    }),
                              )
                            : SizedBox(),
                      ]),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 20,
                ),
                itemCount: snapshot.data!.size,
              ),
            );
          } else {
            return Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ));
          }
        });
  }
}
