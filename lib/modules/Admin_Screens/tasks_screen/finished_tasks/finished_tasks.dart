// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use, prefer_const_constructors, avoid_print, must_be_immutable, sized_box_for_whitespace, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/excel_sheet/excel_sheet.dart';
import 'package:company_tasks_organizer/shared/colors/colors.dart';
import 'package:company_tasks_organizer/shared/components/components.dart';
import 'package:company_tasks_organizer/shared/constants/constants.dart';
import 'package:company_tasks_organizer/shared/cubit/cubit.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:localize_and_translate/localize_and_translate.dart';

class FinishTasksScreen extends StatefulWidget {
  @override
  State<FinishTasksScreen> createState() => _FinishTasksScreenState();
}

class _FinishTasksScreenState extends State<FinishTasksScreen> {
  final Stream<QuerySnapshot> finishedTasksStream = FirebaseFirestore.instance
      .collection(KFinishedTasksFire)
      .orderBy('published_time', descending: false)
      .snapshots();

  CollectionReference finishedTasks =
      FirebaseFirestore.instance.collection(KFinishedTasksFire);

  CollectionReference backUp = FirebaseFirestore.instance.collection('back_up');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: finishedTasksStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                translator.translate('finishedTasks'),
                style: Theme.of(context).textTheme.bodyText1,
              ),
              actions: [
                AppLoginCubit.get(context).permission == 'Admin'
                    ? TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Container(
                                width: 100,
                                child: CupertinoAlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(0),
                                        child: TextButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return CupertinoAlertDialog(
                                                  title: Text(translator
                                                      .translate('alert')),
                                                  content: Text(
                                                      translator.translate(
                                                          'finishedAlert')),
                                                  actions: [
                                                    CupertinoDialogAction(
                                                      child: Text(translator
                                                          .translate('yes')),
                                                      onPressed: () async {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return Center(
                                                                child:
                                                                    CircularProgressIndicator());
                                                          },
                                                        );
                                                        int i;
                                                        for (i = 0;
                                                            i <
                                                                snapshot
                                                                    .data!.size;
                                                            i++) {
                                                          print(i);
                                                          AppCubit.get(context)
                                                              .deleteTask(
                                                                  collectionName:
                                                                      finishedTasks,
                                                                  snapShotID:
                                                                      snapshot
                                                                          .data!
                                                                          .docs[
                                                                              i]
                                                                          .id);
                                                        }
                                                        setState(() {});

                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    CupertinoDialogAction(
                                                      child: Text(translator
                                                          .translate('no')),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            translator.translate('reset'),
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              },
                                            );
                                            for (int t = 0;
                                                t < snapshot.data!.size;
                                                t++) {
                                              AppCubit.get(context).addBackUp(
                                                  employeeName: snapshot.data!.docs[t]
                                                      [KEmployeeNameFire],
                                                  clientAddress: snapshot.data!.docs[t]
                                                      [KClientAddressFire],
                                                  clientName: snapshot.data!.docs[t]
                                                      [KClientNameFire],
                                                  clientPhone: snapshot.data!.docs[t]
                                                      [KClientPhoneFire],
                                                  datePicker: snapshot.data!.docs[t]
                                                      [KDateFire],
                                                  details: snapshot.data!.docs[t]
                                                      [KDetailsFire],
                                                  misionType: snapshot.data!.docs[t]
                                                      [KMisionTypeFire],
                                                  reportController: snapshot.data!.docs[t][KReportFire].toString().isEmpty
                                                      ? snapshot.data!.docs[t]
                                                          [KFailedFire]
                                                      : snapshot.data!.docs[t][KReportFire],
                                                  giveMission: snapshot.data!.docs[t][KGiveMissionFire],
                                                  status: snapshot.data!.docs[t][KStatusFire],
                                                  image_name: snapshot.data!.docs[t]['image_name'],
                                                  image_url: snapshot.data!.docs[t]['image_url'],
                                                  image_done: snapshot.data!.docs[t]['image_done'],
                                                  image_d_url: snapshot.data!.docs[t]['image_d_url'],
                                                  image_f_name: snapshot.data!.docs[t]['image_f_name'],
                                                  image_f_url: snapshot.data!.docs[t]['image_f_url'],
                                                  context: context);
                                            }
                                            Navigator.pop(context);
                                            setState(() {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return CupertinoAlertDialog(
                                                    content: Text(
                                                        translator.translate(
                                                            'backUpisReady')),
                                                    actions: [
                                                      CupertinoDialogAction(
                                                        child: Text(translator
                                                            .translate(
                                                                'close')),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      )
                                                    ],
                                                  );
                                                },
                                              );
                                            });
                                          },
                                          child: Text(
                                            translator.translate('backup'),
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ))
                                    ],
                                  ),
                                  actions: [
                                    CupertinoDialogAction(
                                      child:
                                          Text(translator.translate('close')),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          translator.translate('tools'),
                          style: Theme.of(context).textTheme.bodyText1,
                        ))
                    : SizedBox(),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                start: 5,
                                end: 2,
                                bottom: 10,
                                top: 10,
                              ),
                              child: Column(children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, 'FinishedTasksDetailsScreen',
                                        arguments: index);
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                          child: Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: snapshot.data!
                                                      .docs[index][KStatusFire]
                                                      .toString() ==
                                                  "Done"
                                              ? Colors.green
                                              : snapshot
                                                          .data!
                                                          .docs[index]
                                                              [KStatusFire]
                                                          .toString() ==
                                                      "تمت"
                                                  ? Colors.green
                                                  : Colors.red,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
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
                                                  [KClientNameFire],
                                              style: TextStyle(
                                                fontSize: 20,
                                                color:
                                                    AppCubit.get(context).isDark
                                                        ? darkTextLight
                                                        : lightTextLight,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data!.docs[index]
                                                  [KClientAddressFire],
                                              style: TextStyle(
                                                fontSize: 20,
                                                color:
                                                    AppCubit.get(context).isDark
                                                        ? darkTextLight
                                                        : lightTextLight,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data!.docs[index]
                                                  [KClientPhoneFire],
                                              style: TextStyle(
                                                fontSize: 20,
                                                color:
                                                    AppCubit.get(context).isDark
                                                        ? darkTextLight
                                                        : lightTextLight,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data!.docs[index]
                                                  [KMisionTypeFire],
                                              style: TextStyle(
                                                fontSize: 15,
                                                color:
                                                    AppCubit.get(context).isDark
                                                        ? darkTextLight
                                                        : lightTextLight,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      AppLoginCubit.get(context).permission ==
                                              'Admin'
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20),
                                              child: IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return CupertinoAlertDialog(
                                                        title: Text(translator
                                                            .translate(
                                                                'alert')),
                                                        content: Text(translator
                                                            .translate(
                                                                'missionAlert')),
                                                        actions: [
                                                          CupertinoDialogAction(
                                                            child: Text(
                                                                translator
                                                                    .translate(
                                                                        'yes')),
                                                            onPressed:
                                                                () async {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Center(
                                                                      child:
                                                                          CircularProgressIndicator());
                                                                },
                                                              );
                                                              if (snapshot
                                                                  .data!
                                                                  .docs[index][
                                                                      'image_name']
                                                                  .toString()
                                                                  .isNotEmpty) {
                                                                final Reference
                                                                    storageRef =
                                                                    FirebaseStorage
                                                                        .instance
                                                                        .ref()
                                                                        .child(
                                                                            'tasks/${snapshot.data!.docs[index]['image_name']}');
                                                                await storageRef
                                                                    .delete();
                                                                AppCubit.get(context).deleteTask(
                                                                    collectionName:
                                                                        finishedTasks,
                                                                    snapShotID: snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .id);
                                                              }
                                                              if (snapshot
                                                                  .data!
                                                                  .docs[index][
                                                                      'image_done']
                                                                  .toString()
                                                                  .isNotEmpty) {
                                                                final Reference
                                                                    storageRef =
                                                                    FirebaseStorage
                                                                        .instance
                                                                        .ref()
                                                                        .child(
                                                                            'reports/${snapshot.data!.docs[index]['image_done']}');
                                                                await storageRef
                                                                    .delete();
                                                                AppCubit.get(context).deleteTask(
                                                                    collectionName:
                                                                        finishedTasks,
                                                                    snapShotID: snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .id);
                                                              }
                                                              if (snapshot
                                                                  .data!
                                                                  .docs[index][
                                                                      'image_f_name']
                                                                  .toString()
                                                                  .isNotEmpty) {
                                                                final Reference
                                                                    storageRef =
                                                                    FirebaseStorage
                                                                        .instance
                                                                        .ref()
                                                                        .child(
                                                                            'reports/${snapshot.data!.docs[index]['image_f_name']}');
                                                                await storageRef
                                                                    .delete();
                                                                AppCubit.get(context).deleteTask(
                                                                    collectionName:
                                                                        finishedTasks,
                                                                    snapShotID: snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .id);
                                                              } else {
                                                                AppCubit.get(context).deleteTask(
                                                                    collectionName:
                                                                        finishedTasks,
                                                                    snapShotID: snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .id);
                                                              }

                                                              // AppCubit.get(context)
                                                              //     .deleteTask(
                                                              //         collectionName:
                                                              //             finishedTasks,
                                                              //         snapShotID:
                                                              //             snapshot
                                                              //                 .data!
                                                              //                 .docs[
                                                              //                     index]
                                                              //                 .id);

                                                              Navigator.pop(
                                                                  context);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                          CupertinoDialogAction(
                                                            child: Text(
                                                                translator
                                                                    .translate(
                                                                        'no')),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.delete_forever_rounded,
                                                  size: 35,
                                                  color: Colors.redAccent,
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 20,
                      ),
                      itemCount: snapshot.data!.size,
                    ),
                  ),
                ),
                AppLoginCubit.get(context).permission == 'Admin'
                    ? Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: myButton(
                            text: translator.translate('downloadXlsx'),
                            textColor: AppCubit.get(context).isDark
                                ? Colors.black
                                : Colors.white,
                            color: AppCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExcelScreen(),
                                  ));
                            }),
                      )
                    : SizedBox(),
              ],
            ),
          );
        } else {
          return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      color: Colors.black,
                    ),
                  ],
                ),
              ));
        }
      },
    );
  }
}
