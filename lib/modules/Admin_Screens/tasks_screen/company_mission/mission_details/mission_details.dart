// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, deprecated_member_use, sized_box_for_whitespace, unused_import, prefer_const_literals_to_create_immutables, unused_local_variable, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_tasks_organizer/shared/colors/colors.dart';

import 'package:company_tasks_organizer/shared/components/components.dart';
import 'package:company_tasks_organizer/shared/constants/constants.dart';
import 'package:company_tasks_organizer/shared/cubit/cubit.dart';
import 'package:company_tasks_organizer/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class CompanyMissionsDetailsScreen extends StatefulWidget {
  @override
  State<CompanyMissionsDetailsScreen> createState() =>
      _CompanyMissionsDetailsScreenState();
}

class _CompanyMissionsDetailsScreenState
    extends State<CompanyMissionsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    String id = 'CompanyMissionsDetailsScreen';
    dynamic taskIndex = ModalRoute.of(context)!.settings.arguments;
    int taskNumber = taskIndex + 1;
    final Stream<QuerySnapshot> tasksStream = FirebaseFirestore.instance
        .collection(KTasksFire)
        .orderBy('published_time', descending: false)
        .snapshots();
    CollectionReference tasks =
        FirebaseFirestore.instance.collection(KTasksFire);

    return StreamBuilder(
        stream: tasksStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            String employeeName =
                snapshot.data?.docs[taskIndex][KEmployeeNameFire];
            String clientAddress =
                snapshot.data?.docs[taskIndex][KClientAddressFire];
            String clientName = snapshot.data!.docs[taskIndex][KClientNameFire];
            String clientPhone =
                snapshot.data?.docs[taskIndex][KClientPhoneFire];
            String datePicker = snapshot.data?.docs[taskIndex][KDateFire];
            String details = snapshot.data?.docs[taskIndex][KDetailsFire];
            String misionType = snapshot.data!.docs[taskIndex][KMisionTypeFire];

            return Scaffold(
              appBar: AppBar(
                title: Text(translator.translate('companyMissionsDetails')),
              ),
              body: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: 400,
                        child: ListView(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      30, 70, 30, 0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                              Icons
                                                  .format_list_numbered_rounded,
                                              size: 35),
                                          SizedBox(width: 40),
                                          Text(
                                            '$taskNumber',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        children: [
                                          Stack(
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              Icon(Icons.date_range_rounded,
                                                  size: 35),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .only(top: 10),
                                                child: Icon(
                                                  Icons
                                                      .access_time_filled_rounded,
                                                  size: 19,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 40),
                                          Container(
                                            width: 200,
                                            child: Text(
                                              snapshot.data!.docs[taskIndex]
                                                  [KDateFire],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.person_pin, size: 35),
                                          SizedBox(width: 40),
                                          Container(
                                            width: 200,
                                            child: Text(
                                              snapshot.data!.docs[taskIndex]
                                                  [KEmployeeNameFire],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.person, size: 35),
                                          SizedBox(width: 40),
                                          Container(
                                            width: 150,
                                            child: Text(
                                              snapshot.data!.docs[taskIndex]
                                                  [KClientNameFire],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          AppLoginCubit.get(context)
                                                      .permission ==
                                                  'Admin'
                                              ? editButton(
                                                  controllerName:
                                                      'updateClientNameController',
                                                  collectionName: tasks,
                                                  snapShotID: snapshot
                                                      .data!.docs[taskIndex].id,
                                                  field: KClientNameFire,
                                                  context: context)
                                              : SizedBox(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.phone_in_talk_rounded,
                                              size: 35),
                                          SizedBox(width: 40),
                                          Container(
                                            width: 150,
                                            child: SelectableText(
                                              snapshot.data!.docs[taskIndex]
                                                  [KClientPhoneFire],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          AppLoginCubit.get(context)
                                                      .permission ==
                                                  'Admin'
                                              ? editButton(
                                                  controllerName:
                                                      'updateClientPhoneController',
                                                  collectionName: tasks,
                                                  snapShotID: snapshot
                                                      .data!.docs[taskIndex].id,
                                                  field: KClientPhoneFire,
                                                  context: context)
                                              : SizedBox(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on_rounded,
                                              size: 35),
                                          SizedBox(width: 40),
                                          Container(
                                            width: 150,
                                            child: SelectableText(
                                              snapshot.data!.docs[taskIndex]
                                                  [KClientAddressFire],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          AppLoginCubit.get(context)
                                                      .permission ==
                                                  'Admin'
                                              ? editButton(
                                                  controllerName:
                                                      'updateClientAddressController',
                                                  collectionName: tasks,
                                                  snapShotID: snapshot
                                                      .data!.docs[taskIndex].id,
                                                  field: KClientAddressFire,
                                                  context: context)
                                              : SizedBox(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.task_alt_rounded,
                                              size: 35),
                                          SizedBox(width: 40),
                                          Container(
                                            width: 150,
                                            child: Text(
                                              snapshot.data!.docs[taskIndex]
                                                  [KMisionTypeFire],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          AppLoginCubit.get(context)
                                                      .permission ==
                                                  'Admin'
                                              ? editButton(
                                                  controllerName:
                                                      'updateMisionTypeController',
                                                  collectionName: tasks,
                                                  snapShotID: snapshot
                                                      .data!.docs[taskIndex].id,
                                                  field: KMisionTypeFire,
                                                  context: context)
                                              : SizedBox(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.details_rounded, size: 35),
                                          SizedBox(width: 40),
                                          Container(
                                            width: 150,
                                            child: SelectableText(
                                              snapshot.data!.docs[taskIndex]
                                                  [KDetailsFire],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                              maxLines: 15,
                                              minLines: 1,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          AppLoginCubit.get(context)
                                                      .permission ==
                                                  'Admin'
                                              ? editButton(
                                                  controllerName:
                                                      'updateDetailsController',
                                                  collectionName: tasks,
                                                  snapShotID: snapshot
                                                      .data!.docs[taskIndex].id,
                                                  field: KDetailsFire,
                                                  context: context)
                                              : SizedBox(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      snapshot.data!
                                              .docs[taskIndex]['image_url']
                                              .toString()
                                              .isNotEmpty
                                          ? Text(
                                              translator.translate('details'),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            )
                                          : SizedBox(),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      snapshot.data!
                                              .docs[taskIndex]['image_url']
                                              .toString()
                                              .isNotEmpty
                                          ? Image.network(snapshot.data!
                                              .docs[taskIndex]['image_url'])
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppLoginCubit.get(context).permission == 'Admin'
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: myButton(
                                text: translator.translate('giveMission'),
                                textColor:
                                    cubit.isDark ? Colors.black : Colors.white,
                                color:
                                    cubit.isDark ? Colors.white : Colors.black,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      var giveMissionController =
                                          TextEditingController();
                                      return Container(
                                        width: 400,
                                        child: AlertDialog(
                                          backgroundColor: cubit.isDark
                                              ? HexColor('333739')
                                              : Colors.white,
                                          title: Text(translator
                                              .translate('giveMission')),
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
                                                    controller:
                                                        giveMissionController,
                                                    type:
                                                        TextInputType.multiline,
                                                    minLines: 3,
                                                    maxLines: 5,
                                                    prefixIcon: Icons.people,
                                                    labelText:
                                                        translator.translate(
                                                            'typeEmployeeName'),
                                                    textStyle: TextStyle(
                                                      color:
                                                          AppCubit.get(context)
                                                                  .isDark
                                                              ? Colors.white
                                                              : Colors.black,
                                                    ),
                                                    color: AppCubit.get(context)
                                                            .isDark
                                                        ? Colors.grey
                                                        : Colors.black,
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .only(bottom: 10),
                                                    child: myButton(
                                                        text: translator
                                                            .translate(
                                                                'submit'),
                                                        textColor: cubit.isDark
                                                            ? Colors.black
                                                            : Colors.white,
                                                        color: cubit.isDark
                                                            ? Colors.white
                                                            : HexColor(
                                                                '333739'),
                                                        onPressed: () async {
                                                          String tasksID =
                                                              snapshot
                                                                  .data!
                                                                  .docs[
                                                                      taskIndex]
                                                                  .id
                                                                  .toString();
                                                          String? imageName =
                                                              snapshot.data!
                                                                          .docs[
                                                                      taskIndex]
                                                                  [
                                                                  'image_name'];
                                                          String? imageUrl =
                                                              snapshot.data!
                                                                          .docs[
                                                                      taskIndex]
                                                                  ['image_url'];
                                                          if (imageUrl!
                                                              .isNotEmpty) {
                                                            cubit.addTodayTasks(
                                                                clientAddress,
                                                                clientName,
                                                                clientPhone,
                                                                datePicker,
                                                                details,
                                                                employeeName,
                                                                misionType,
                                                                giveMissionController,
                                                                tasksID,
                                                                imageName:
                                                                    imageName,
                                                                imageUrl:
                                                                    imageUrl,
                                                                context:
                                                                    context);
                                                            AppLoginCubit.get(
                                                                    context)
                                                                .sendNotification();
                                                            Navigator.pop(
                                                                context);
                                                          } else {
                                                            cubit.addTodayTasks(
                                                                clientAddress,
                                                                clientName,
                                                                clientPhone,
                                                                datePicker,
                                                                details,
                                                                employeeName,
                                                                misionType,
                                                                giveMissionController,
                                                                tasksID,
                                                                imageName: "",
                                                                imageUrl: "",
                                                                context:
                                                                    context);
                                                            AppLoginCubit.get(
                                                                    context)
                                                                .sendNotification();
                                                            Navigator.pop(
                                                                context);
                                                          }

                                                          AppLoginCubit.get(
                                                                  context)
                                                              .sendNotification();
                                                          Navigator.pop(
                                                              context);
                                                        }),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      );
                                    },
                                  );
                                }),
                          )
                        : SizedBox(),
                  ],
                ),
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
