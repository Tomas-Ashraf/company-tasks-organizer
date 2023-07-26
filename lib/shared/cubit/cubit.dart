// ignore_for_file: unnecessary_import, non_constant_identifier_names, prefer_const_constructors, avoid_print, body_might_complete_normally_nullable, prefer_typing_uninitialized_variables, unused_local_variable, sort_child_properties_last, void_checks, unused_import, deprecated_member_use, avoid_unnecessary_containers, await_only_futures, prefer_if_null_operators, unnecessary_string_interpolations, unused_element, dead_code, unnecessary_new, prefer_final_fields, unused_field, avoid_function_literals_in_foreach_calls, unnecessary_this

import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/home_screen/HomeScreen.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/tools_screen/tools_screen.dart';

import 'package:company_tasks_organizer/modules/login_screen/login_screen.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/settings_screen/settings_screen.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/tasks_screen/tasks_screen.dart';
import 'package:company_tasks_organizer/shared/components/components.dart';
import 'package:company_tasks_organizer/shared/constants/constants.dart';
import 'package:company_tasks_organizer/shared/cubit/states.dart';
import 'package:company_tasks_organizer/shared/shared_preference/shared_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:lottie/lottie.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import 'package:http/http.dart' as http;

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitailStates());

  static AppCubit get(context) => BlocProvider.of(context);
  final Stream<QuerySnapshot> todayTasksStream = FirebaseFirestore.instance
      .collection(KTodayTasksFire)
      .orderBy('published_time', descending: false)
      .snapshots();
  final Stream<QuerySnapshot> tasksStream = FirebaseFirestore.instance
      .collection(KTasksFire)
      .orderBy('published_time', descending: false)
      .snapshots();

  CollectionReference tasks = FirebaseFirestore.instance.collection(KTasksFire);
  CollectionReference todayTasks =
      FirebaseFirestore.instance.collection(KTodayTasksFire);
  CollectionReference finishedTasks =
      FirebaseFirestore.instance.collection(KFinishedTasksFire);

  int CurrentIndex = 0;

  List<GButton> bottomTabs = [
    GButton(
      icon: Icons.home_rounded,
      text: translator.translate('home'),
    ),
    GButton(icon: Icons.task, text: translator.translate('tasks')),
    GButton(icon: Icons.handyman_rounded, text: translator.translate('tools')),
    GButton(
        icon: Icons.settings_rounded, text: translator.translate('settings')),
  ];

  List<Widget> screens = [
    HomeScreen(),
    TaskssScreen(),
    ToolsScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    CurrentIndex = index;
    emit(AppTaskCompanyChangeBottomNavBar());
  }

  List<String> titles = [
    translator.translate('home'),
    translator.translate('tasks'),
    translator.translate('tools'),
    translator.translate('settings'),
  ];

  var dateController1;

  Future<DateTime?> pickedDate(context1) async {
    showDatePicker(
      context: context1,
      firstDate: DateTime.parse('2023-01-01'),
      initialDate: DateTime.now(),
      lastDate: DateTime.parse('2025-01-01'),
    ).then(
      (value) {
        dateController1.text = DateFormat.yMMMd().format(value!);
      },
    );

    emit(AppDatePickerState());
  }

  String? newValue;

  List<DropdownMenuItem<String>> dropMenuItems = [
    DropdownMenuItem(
        child: Text(translator.translate('installation')),
        value: translator.translate('installation')),
    DropdownMenuItem(
        child: Text(translator.translate('repair')),
        value: translator.translate('repair')),
  ];

  void dropValue(String? value) {
    newValue = value;

    emit(AppDatePickerState());
  }

  late File image;
  String? imageName;
  Future pickImage(
      {imageController, imagePathController, imageFileController}) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    this.image = imageTemporary;
    this.imageName = image.name;
    imageController.text = imageName;

    // print(image.name);
    emit(AppImagePickerState());
  }

  UploadTask? _uploadTask;
  String? imageUrl;
  Future uploadFile(
      context, TextEditingController imageController, imageFileController,
      {imageUrlController}) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    final path = 'tasks/${imageController.text}';
    final file = image;
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
    _uploadTask = ref.putFile(file);
    final snapshot = await _uploadTask!.whenComplete(() {});
    var urlDownload = await snapshot.ref.getDownloadURL();
    this.imageUrl = urlDownload;
    imageUrlController.text = urlDownload;
    print(urlDownload);
    emit(AppImageUploadState());

    Navigator.pop(context);
  }

  void endUploading() {}
  bool isSecure = true;

  void securePassword() {
    isSecure = !isSecure;
    emit(TaskCompanySecurePasswordState());
  }

  bool isDark = false;

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(TaskCompanyChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(TaskCompanyChangeModeState());
      });
    }
  }

  bool isEnglish = false;

  void changeAppLanguage(BuildContext context) {
    isEnglish = !isEnglish;
    translator.setNewLanguage(context,
        newLanguage: isEnglish ? 'en' : 'ar', restart: false, remember: true);
    emit(AppChangeLanguageState());
  }

  bool? ThemeMode;
  Color? textColor;
  void themeState() {
    if (isDark = true) {
      ThemeMode = true;
      textColor = Colors.white;
    }
    if (isDark = false) {
      textColor = Colors.black;
    }
    emit(AppThemeState());
  }

  late String dropDownValue;

  late String dropDownValuePermission;

  List<String> permission = [
    translator.translate('admin'),
    translator.translate('employee'),
  ];

  void dropPermission(String? value) {
    dropDownValue = value!;
    emit(GivePermissionState());
  }

  FlutterContactPicker _contactPicker = new FlutterContactPicker();
  Contact? _contact;

  Future<void> addContact(clientName, clientPhone) async {
    Contact? contact = await _contactPicker.selectContact();
    String? contactName;
    String? contactphone;

    _contact = contact;
    contactName = contact?.fullName;
    contactphone = contact!.phoneNumbers!.toString();
    clientName.text = contactName!;
    clientPhone.text = contactphone;

    emit(AddContact());
  }

  Future<void> addTask(
    TextEditingController dateController,
    TextEditingController employeeName,
    TextEditingController clientName,
    TextEditingController clientPhone,
    TextEditingController clientAddress,
    TextEditingController detailsController,
    BuildContext context, {
    String? imageName,
    String? imageUrl,
  }) async {
    return tasks.add({
      'mission_type':
          newValue == null ? translator.translate('installation') : newValue,
      'date_picker': dateController.text,
      'employee_name': employeeName.text,
      'client_name': clientName.text,
      'client_phone': clientPhone.text,
      'client_address': clientAddress.text,
      'details': detailsController.text,
      'published_time': DateTime.now(),
      'image_url': imageUrl,
      'image_name': imageName
    }).then((value) {
      print('value :${value.toString()}');
      emit(AddTaskSuccessful());
    }).catchError((error) {
      showSnackBar(context, '$error', Colors.red);
      emit(AddTaskError(error));
    });
  }

  Future<void> addTodayTasks(
    String? clientAddress,
    String? clientName,
    String? clientPhone,
    String? datePicker,
    String? details,
    String? employeeName,
    String? misionType,
    TextEditingController giveMissionController,
    String tasksID, {
    String? imageName,
    String? imageUrl,
    required BuildContext context,
  }) async {
    return todayTasks.add({
      'mission_type': misionType,
      'date_picker': datePicker,
      'employee_name': employeeName,
      'client_name': clientName,
      'client_phone': clientPhone,
      'client_address': clientAddress,
      'details': details,
      'published_time': DateTime.now(),
      'give_mission': giveMissionController.text,
      'tasks_ID': tasksID,
      'image_name': imageName,
      'image_url': imageUrl
    }).then((value) {
      emit(AddTaskSuccessful());
    }).catchError((error) {
      showSnackBar(context, '$error', Colors.red);
      emit(AddTaskError(error));
    });
  }

  Future<void> addFinishedTaskD(
      String employeeName,
      String clientAddress,
      String clientName,
      String clientPhone,
      String datePicker,
      String details,
      String misionType,
      TextEditingController reportController,
      String giveMission,
      BuildContext context,
      {String? image,
      String? imageUrl,
      String? imageDone,
      String? imageDoneUrl}) async {
    return finishedTasks.add({
      'mission_type': misionType,
      'date_picker': datePicker,
      'employee_name': employeeName,
      'client_name': clientName,
      'client_phone': clientPhone,
      'client_address': clientAddress,
      'details': details,
      'published_time': DateTime.now(),
      'give_mission': giveMission,
      'report': reportController.text,
      'failed': "",
      'status': translator.currentLanguage == 'en' ? 'Done' : 'تمت',
      'image_name': image,
      'image_url': imageUrl,
      'image_done': imageDone,
      'image_d_url': imageDoneUrl,
      'image_f_name': "",
      'image_f_url': "",
    }).then((value) {
      emit(AddTaskSuccessful());
    }).catchError((error) {
      showSnackBar(context, '$error', Colors.red);
      emit(AddTaskError(error));
    });
  }

  Future<void> addFinishedTaskF(
    String employeeName,
    String clientAddress,
    String clientName,
    String clientPhone,
    String datePicker,
    String details,
    String misionType,
    TextEditingController failedController,
    String giveMission,
    BuildContext context, {
    String? imageName,
    String? imageUrl,
    String? imageFailedName,
    String? imageFailedUrl,
  }) async {
    return finishedTasks.add({
      'mission_type': misionType,
      'date_picker': datePicker,
      'employee_name': employeeName,
      'client_name': clientName,
      'client_phone': clientPhone,
      'client_address': clientAddress,
      'details': details,
      'published_time': DateTime.now(),
      'give_mission': giveMission,
      'failed': failedController.text,
      'report': "",
      'status': translator.currentLanguage == 'en' ? 'Failed' : 'فشلت',
      'image_name': imageName,
      'image_url': imageUrl,
      'image_f_name': imageFailedName,
      'image_f_url': imageFailedUrl,
      'image_done': "",
      'image_d_url': "",
    }).then((value) {
      emit(AddTaskSuccessful());
    }).catchError((error) {
      showSnackBar(context, '$error', Colors.red);
      emit(AddTaskError(error));
    });
  }

  Future<void> deleteTask({
    dynamic snapShotID,
    required CollectionReference collectionName,
  }) async {
    collectionName.doc(snapShotID).delete();

    emit(DeleteTaskSuccessful());
  }

  Future<void> updateTask({
    dynamic snapShotID,
    required CollectionReference collectionName,
    required String field,
    required String newText,
  }) {
    return collectionName
        .doc(snapShotID)
        .update({'$field': '$newText'}).then((value) {});
    emit(EditTaskSuccessful());
  }

  final Stream<QuerySnapshot> backUpStream = FirebaseFirestore.instance
      .collection('back_up')
      .orderBy('published_time', descending: false)
      .snapshots();
  CollectionReference backup_data = FirebaseFirestore.instance
      .collection('back_up')
      .doc('${DateFormat().add_yMMMM().format(DateTime.now())}')
      .collection('${DateFormat().add_yMMMM().format(DateTime.now())}');

  Future<void> addBackUp({
    required String employeeName,
    required String clientAddress,
    required String clientName,
    required String clientPhone,
    required String datePicker,
    required String details,
    required String misionType,
    required String reportController,
    required String giveMission,
    required String status,
    String? image_name,
    String? image_url,
    String? image_done,
    String? image_d_url,
    String? image_f_name,
    String? image_f_url,
    required BuildContext context,
  }) async {
    return backup_data.add({
      'mission_type': misionType,
      'date_picker': datePicker,
      'employee_name': employeeName,
      'client_name': clientName,
      'client_phone': clientPhone,
      'client_address': clientAddress,
      'details': details,
      'published_time': DateTime.now(),
      'give_mission': giveMission,
      'report': reportController,
      'failed': "",
      'status': status,
      'image_name': image_name,
      'image_url': image_url,
      'image_done': image_done,
      'image_d_url': image_d_url,
      'image_f_name': image_f_name,
      'image_f_url': image_f_url
    }).then((value) {
      emit(AddBackUpSuccessful());
    }).catchError((error) {
      showSnackBar(context, '$error', Colors.red);
      emit(AddBackUpError(error));
    });
  }
}

class AppLoginCubit extends Cubit<AppLoginStates> {
  AppLoginCubit() : super(TaskCompanyLoginInitialState());

  static AppLoginCubit get(context) => BlocProvider.of(context);

  bool isSecure = true;

  void securePassword() {
    isSecure = !isSecure;
    emit(AppLoginSecurePassword());
  }

  bool isSecureCode = true;

  void secureCode() {
    isSecureCode = !isSecureCode;
    emit(AppLoginSecurePassword());
  }

  bool isLoading = false;
  void loadingPage() {
    isLoading = !isLoading;
    emit(AppLoginLoadingPage());
  }

  String? permission;

  Future<void> selectPermission() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    permission = prefs.getString('userPermission');
    emit(SelectPermission());
  }

  String? name;
  Future<void> getName() async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((DocumentSnapshot user) {
      name = user['name'];
      emit(GetName());
    });
  }

  String checkIn = '--/--';
  String checkOut = '--/--';

  void changeCheckIn() {
    checkIn = DateFormat('hh:mm a').format(DateTime.now());
    print(checkIn);
    emit(ChangeCheckIn());
  }

  void changeCheckOut() {
    checkOut = DateFormat('hh:mm a').format(DateTime.now());
    print(checkOut);
    emit(ChangeCheckOut());
  }

  String? token;
  Future<void> sendNotification() async {
    String? token;
    FirebaseFirestore.instance.collection('tokens').get().then(
          (QuerySnapshot snapshot) => {
            snapshot.docs.forEach((f) {
              FirebaseFirestore.instance
                  .collection('tokens')
                  .doc(f.reference.id)
                  .get()
                  .then((DocumentSnapshot snap) async {
                token = snap['token'];
                final headers = {
                  'Content-Type': 'application/json; charset=UTF-8',
                  'Authorization':
                      'key= AAAAXmmB_Yo:APA91bHkWYxsDQe67MfUA37cqJrYFP8FAK2BvONvBM10q0MoXAqL9YJ8i3K1zTQGFtnO9k0cCjOBP9IEe0FAbzoAn_xymsnpg_6qxr-GJFfsJZ4g0Wv9xXzGk11BkMK6J3-JehXXdRlu',
                };

                final bodyJson = jsonEncode({
                  'notification': {
                    'title': 'مرحبا، هناك مهمة جديدة فى انتظارك',
                    'body': 'لمزيد من التفاصيل قم بفتح التطبيق ',
                  },
                  'priority': 'high',
                  'data': {
                    'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                    'sound': 'default',
                  },
                  'to': token,
                });

                final response = await http.post(
                  Uri.parse('https://fcm.googleapis.com/fcm/send'),
                  headers: headers,
                  body: bodyJson,
                );

                if (response.statusCode == 200) {
                  print('Push notification sent successfully.');
                } else {
                  print('Error sending push notification: ${response.body}');
                }
              });
              print(f.reference.id);
            }),
          },
        );
  }
}
