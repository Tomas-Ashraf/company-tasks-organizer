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

class TodayTasksDetailsScreen extends StatefulWidget {
  @override
  State<TodayTasksDetailsScreen> createState() =>
      _TodayTasksDetailsScreenState();
}

class _TodayTasksDetailsScreenState extends State<TodayTasksDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    String id = 'TodayTasksDetailsScreen';
    dynamic taskIndex = ModalRoute.of(context)!.settings.arguments;
    int taskNumber = taskIndex + 1;
    final Stream<QuerySnapshot> todayTasksStream = FirebaseFirestore.instance
        .collection(KTodayTasksFire)
        .orderBy('published_time', descending: false)
        .snapshots();
    CollectionReference todayTasks =
        FirebaseFirestore.instance.collection(KTodayTasksFire);

    return StreamBuilder(
        stream: todayTasksStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
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
                                      50, 70, 30, 0),
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
                                            width: 200,
                                            child: Text(
                                              snapshot.data!.docs[taskIndex]
                                                  [KClientNameFire],
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
                                          Icon(Icons.phone_in_talk_rounded,
                                              size: 35),
                                          SizedBox(width: 40),
                                          Container(
                                            width: 200,
                                            child: SelectableText(
                                              snapshot.data!.docs[taskIndex]
                                                  [KClientPhoneFire],
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
                                          Icon(Icons.location_on_rounded,
                                              size: 35),
                                          SizedBox(width: 40),
                                          Container(
                                            width: 200,
                                            child: SelectableText(
                                              snapshot.data!.docs[taskIndex]
                                                  [KClientAddressFire],
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
                                          Icon(Icons.task_alt_rounded,
                                              size: 35),
                                          SizedBox(width: 40),
                                          Text(
                                            snapshot.data!.docs[taskIndex]
                                                [KMisionTypeFire],
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
                                          Icon(Icons.details_rounded, size: 35),
                                          SizedBox(width: 40),
                                          Container(
                                            width: 200,
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
                                        ],
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.people, size: 35),
                                          SizedBox(width: 40),
                                          Container(
                                            width: 150,
                                            child: Text(
                                              snapshot.data!.docs[taskIndex]
                                                  [KGiveMissionFire],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                          AppLoginCubit.get(context)
                                                      .permission ==
                                                  'Admin'
                                              ? editButton(
                                                  collectionName: todayTasks,
                                                  snapShotID: snapshot
                                                      .data!.docs[taskIndex].id,
                                                  field: KGiveMissionFire,
                                                  controllerName:
                                                      'updateGiveMissionController',
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
