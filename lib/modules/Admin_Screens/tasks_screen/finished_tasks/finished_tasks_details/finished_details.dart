// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, deprecated_member_use, unused_local_variable, must_be_immutable, prefer_const_literals_to_create_immutables, unused_import, prefer_if_null_operators, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_tasks_organizer/shared/components/components.dart';
import 'package:company_tasks_organizer/shared/constants/constants.dart';
import 'package:company_tasks_organizer/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class FinishedTasksDetailsScreen extends StatelessWidget {
  final Stream<QuerySnapshot> finishedTasksStream = FirebaseFirestore.instance
      .collection(KFinishedTasksFire)
      .orderBy('published_time', descending: false)
      .snapshots();

  CollectionReference finishedTasks =
      FirebaseFirestore.instance.collection(KFinishedTasksFire);
  @override
  Widget build(BuildContext context) {
    dynamic taskIndex = ModalRoute.of(context)!.settings.arguments;
    int taskNumber = taskIndex + 1;
    return StreamBuilder<QuerySnapshot>(
      stream: finishedTasksStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(translator.translate('companyMissionsDetails')),
            ),
            body: Padding(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.format_list_numbered_rounded, size: 35),
                            SizedBox(width: 40),
                            Text(
                              '$taskNumber',
                              style: Theme.of(context).textTheme.bodyText1,
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
                                Icon(Icons.date_range_rounded, size: 35),
                                Padding(
                                  padding:
                                      const EdgeInsetsDirectional.only(top: 10),
                                  child: Icon(
                                    Icons.access_time_filled_rounded,
                                    size: 19,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 40),
                            Text(
                              snapshot.data!.docs[taskIndex][KDateFire],
                              style: Theme.of(context).textTheme.bodyText1,
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
                            Text(
                              snapshot.data!.docs[taskIndex][KEmployeeNameFire],
                              style: Theme.of(context).textTheme.bodyText1,
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
                              child: SelectableText(
                                snapshot.data!.docs[taskIndex][KClientNameFire],
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
                            Icon(Icons.phone_in_talk_rounded, size: 35),
                            SizedBox(width: 40),
                            Container(
                              width: 200,
                              child: SelectableText(
                                snapshot.data!.docs[taskIndex]
                                    [KClientPhoneFire],
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
                            Icon(Icons.location_on_rounded, size: 35),
                            SizedBox(width: 40),
                            Container(
                              width: 200,
                              child: SelectableText(
                                snapshot.data!.docs[taskIndex]
                                    [KClientAddressFire],
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
                            Icon(Icons.task_alt_rounded, size: 35),
                            SizedBox(width: 40),
                            Text(
                              snapshot.data!.docs[taskIndex][KMisionTypeFire],
                              style: Theme.of(context).textTheme.bodyText1,
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
                                snapshot.data!.docs[taskIndex][KDetailsFire],
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
                            Icon(Icons.people, size: 35),
                            SizedBox(width: 40),
                            Container(
                              width: 200,
                              child: SelectableText(
                                snapshot.data!.docs[taskIndex]
                                    [KGiveMissionFire],
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
                            Icon(Icons.report_gmailerrorred_rounded, size: 35),
                            SizedBox(width: 40),
                            Container(
                              width: 150,
                              child: SelectableText(
                                snapshot.data!.docs[taskIndex][KReportFire]
                                        .toString()
                                        .isEmpty
                                    ? snapshot.data!.docs[taskIndex]
                                        [KFailedFire]
                                    : snapshot.data!.docs[taskIndex]
                                        [KReportFire],
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            AppLoginCubit.get(context).permission == 'Admin'
                                ? editButton(
                                    controllerName: 'reportUpdateController',
                                    collectionName: finishedTasks,
                                    snapShotID:
                                        snapshot.data!.docs[taskIndex].id,
                                    field: snapshot
                                            .data!
                                            .docs[taskIndex][KReportFire]
                                            .isEmpty
                                        ? KFailedFire
                                        : KReportFire,
                                    context: context)
                                : SizedBox(),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Icon(Icons.request_page_rounded, size: 35),
                        SizedBox(width: 40),
                        Container(
                          width: 150,
                          child: Text(
                            snapshot.data!.docs[taskIndex][KStatusFire],
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        AppLoginCubit.get(context).permission == 'Admin'
                            ? editButton(
                                controllerName: 'statusUpdateController',
                                collectionName: finishedTasks,
                                snapShotID: snapshot.data!.docs[taskIndex].id,
                                field: KStatusFire,
                                context: context)
                            : SizedBox(),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    snapshot.data!.docs[taskIndex]['image_url']
                            .toString()
                            .isNotEmpty
                        ? Text(
                            translator.translate('details'),
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 25,
                    ),
                    snapshot.data!.docs[taskIndex]['image_url']
                            .toString()
                            .isNotEmpty
                        ? Image.network(
                            snapshot.data!.docs[taskIndex]['image_url'])
                        : SizedBox(),
                    SizedBox(
                      height: 25,
                    ),
                    snapshot.data!.docs[taskIndex]['image_d_url']
                            .toString()
                            .isNotEmpty
                        ? Text(
                            translator.translate('report'),
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        : SizedBox(),
                    snapshot.data!.docs[taskIndex]['image_f_url']
                            .toString()
                            .isNotEmpty
                        ? Text(
                            translator.translate('report'),
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 25,
                    ),
                    snapshot.data!.docs[taskIndex]['image_d_url']
                            .toString()
                            .isNotEmpty
                        ? Image.network(
                            snapshot.data!.docs[taskIndex]['image_d_url'])
                        : SizedBox(),
                    snapshot.data!.docs[taskIndex]['image_f_url']
                            .toString()
                            .isNotEmpty
                        ? Image.network(
                            snapshot.data!.docs[taskIndex]['image_f_url'])
                        : SizedBox(),
                  ],
                ),
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
