// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use, prefer_const_constructors, avoid_print, must_be_immutable, sized_box_for_whitespace, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, unused_local_variable, unused_element, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_tasks_organizer/shared/colors/colors.dart';
import 'package:company_tasks_organizer/shared/constants/constants.dart';
import 'package:company_tasks_organizer/shared/cubit/cubit.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:localize_and_translate/localize_and_translate.dart';

class BackUpScreen extends StatefulWidget {
  static String id = 'BackUpScreen';

  @override
  State<BackUpScreen> createState() => _BackUpScreenState();
}

class _BackUpScreenState extends State<BackUpScreen> {
  @override
  Widget build(BuildContext context) {
    dynamic collectionDate = ModalRoute.of(context)?.settings.arguments;

    final Stream<QuerySnapshot> backUpStream = FirebaseFirestore.instance
        .collection('back_up')
        .doc(collectionDate)
        .collection(collectionDate)
        .orderBy('published_time', descending: false)
        .snapshots();
    CollectionReference backupData = FirebaseFirestore.instance
        .collection('back_up')
        .doc(collectionDate)
        .collection(collectionDate);

    return StreamBuilder<QuerySnapshot>(
      stream: backUpStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                translator.translate('history'),
                style: Theme.of(context).textTheme.bodyText1,
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.all(0),
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text(translator.translate('alert')),
                            content:
                                Text(translator.translate('finishedAlert')),
                            actions: [
                              CupertinoDialogAction(
                                child: Text(translator.translate('yes')),
                                onPressed: () async {
                                  int i;
                                  for (i = 0; i < snapshot.data!.size; i++) {
                                    AppCubit.get(context).deleteTask(
                                        collectionName: backupData,
                                        snapShotID: snapshot.data!.docs[i].id);
                                  }
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                              CupertinoDialogAction(
                                child: Text(translator.translate('no')),
                                onPressed: () {
                                  print(collectionDate);
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
                          padding:
                              EdgeInsets.only(top: 10, left: 10, right: 10),
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
                                      context,
                                      'BackUpDetailsScreen',
                                      arguments: {
                                        'index': index,
                                        'collectionDate': collectionDate,
                                      },
                                    );
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
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return CupertinoAlertDialog(
                                                  title: Text(translator
                                                      .translate('alert')),
                                                  content: Text(
                                                      translator.translate(
                                                          'missionAlert')),
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
                                                        if (snapshot
                                                            .data!
                                                            .docs[index]
                                                                ['image_name']
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
                                                          AppCubit.get(context)
                                                              .deleteTask(
                                                                  collectionName:
                                                                      backupData,
                                                                  snapShotID:
                                                                      snapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                          .id);
                                                        }
                                                        if (snapshot
                                                            .data!
                                                            .docs[index]
                                                                ['image_done']
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
                                                          AppCubit.get(context)
                                                              .deleteTask(
                                                                  collectionName:
                                                                      backupData,
                                                                  snapShotID:
                                                                      snapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                          .id);
                                                        }
                                                        if (snapshot
                                                            .data!
                                                            .docs[index]
                                                                ['image_f_name']
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
                                                          AppCubit.get(context)
                                                              .deleteTask(
                                                                  collectionName:
                                                                      backupData,
                                                                  snapShotID:
                                                                      snapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                          .id);
                                                        } else {
                                                          AppCubit.get(context)
                                                              .deleteTask(
                                                                  collectionName:
                                                                      backupData,
                                                                  snapShotID:
                                                                      snapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                          .id);
                                                        }

                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    CupertinoDialogAction(
                                                      child: Text(translator
                                                          .translate('no')),
                                                      onPressed: () {
                                                        Navigator.pop(context);
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
                                      ),
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
