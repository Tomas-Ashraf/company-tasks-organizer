// ignore_for_file: unused_local_variable, use_key_in_widget_constructors, must_be_immutable, deprecated_member_use

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_tasks_organizer/shared/constants/constants.dart';
import 'package:company_tasks_organizer/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import '../../../shared/components/components.dart';

class ExcelScreen extends StatelessWidget {
  final Stream<QuerySnapshot> finishedTasksStream = FirebaseFirestore.instance
      .collection(KFinishedTasksFire)
      .orderBy('published_time', descending: false)
      .snapshots();

  CollectionReference finishedTasks =
      FirebaseFirestore.instance.collection(KFinishedTasksFire);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: finishedTasksStream,
      builder: (context, snapshot) {
        return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: myButton(
                  text: translator.translate('downloadXlsx'),
                  textColor: AppCubit.get(context).isDark
                      ? Colors.black
                      : Colors.white,
                  color: AppCubit.get(context).isDark
                      ? Colors.white
                      : Colors.black,
                  onPressed: () async {
                    final Workbook workbook = Workbook();
                    final Worksheet sheet = workbook.worksheets[0];
                    sheet.getRangeByName('A1').setText('اسم الموظف');
                    sheet.getRangeByName('B1').setText('تاريخ البلاغ');
                    sheet.getRangeByName('C1').setText('اسم العميل');
                    sheet.getRangeByName('D1').setText('رقم تليفون العميل');
                    sheet.getRangeByName('E1').setText('عنوان العميل');
                    sheet.getRangeByName('F1').setText('نوع البلاغ');
                    sheet
                        .getRangeByName('G1')
                        .setText('الوصف والتفاصيل والملاحظات');
                    sheet.getRangeByName('H1').setText('اسم الفنى');
                    sheet.getRangeByName('I1').setText('التقرير');
                    sheet.getRangeByName('J1').setText('صورة التفاصيل');
                    sheet.getRangeByName('K1').setText('صورة التقرير');

                    if (snapshot.hasData) {
                      int? excelIndex;
                      int i;
                      for (i = 0; i < snapshot.data!.size; i++) {
                        excelIndex = i + 2;

                        sheet
                            .getRangeByName('A$excelIndex')
                            .setText(snapshot.data?.docs[i][KEmployeeNameFire]);
                        sheet
                            .getRangeByName('B$excelIndex')
                            .setText(snapshot.data?.docs[i][KDateFire]);
                        sheet
                            .getRangeByName('C$excelIndex')
                            .setText(snapshot.data?.docs[i][KClientNameFire]);
                        sheet
                            .getRangeByName('D$excelIndex')
                            .setText(snapshot.data?.docs[i][KClientPhoneFire]);
                        sheet.getRangeByName('E$excelIndex').setText(
                            snapshot.data?.docs[i][KClientAddressFire]);
                        sheet
                            .getRangeByName('F$excelIndex')
                            .setText(snapshot.data?.docs[i][KMisionTypeFire]);
                        sheet
                            .getRangeByName('G$excelIndex')
                            .setText(snapshot.data?.docs[i][KDetailsFire]);
                        sheet
                            .getRangeByName('H$excelIndex')
                            .setText(snapshot.data?.docs[i][KGiveMissionFire]);
                        sheet.getRangeByName('I$excelIndex').setText(
                              snapshot.data!.docs[i][KReportFire]
                                      .toString()
                                      .isEmpty
                                  ? snapshot.data!.docs[i][KFailedFire]
                                  : snapshot.data!.docs[i][KReportFire],
                            );
                        sheet
                            .getRangeByName('J$excelIndex')
                            .setText(snapshot.data?.docs[i]['image_url']);
                        sheet.getRangeByName('K$excelIndex').setText(snapshot
                                .data!.docs[i]['image_d_url']
                                .toString()
                                .isNotEmpty
                            ? snapshot.data?.docs[i]['image_d_url']
                            : snapshot.data?.docs[i]['image_f_url']);
                      }
                    }
                    final List<int> bytes = workbook.saveAsStream();
                    workbook.dispose();
                    final String path =
                        (await getApplicationSupportDirectory()).path;
                    final String fileName = '$path/Finished Tasks.xlsx';
                    final File file = File(fileName);
                    await file.writeAsBytes(bytes, flush: true);
                    OpenFile.open(fileName);
                  }),
            ));
      },
    );
  }
}
