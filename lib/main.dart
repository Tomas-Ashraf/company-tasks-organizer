// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable, unnecessary_string_interpolations, use_key_in_widget_constructors, prefer_const_constructors, avoid_print, unused_local_variable, deprecated_member_use, unused_shown_name, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, depend_on_referenced_packages

import 'package:company_tasks_organizer/layout/admin_layout/admin_layout.dart';
import 'package:company_tasks_organizer/layout/admin_layout/splash_screen.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/backup_screen/backup.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/backup_screen/backup_details/backup_details.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/home_screen/HomeScreen.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/settings_screen/settings_screen.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/tasks_screen/company_mission/mission_details/mission_details.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/tasks_screen/finished_tasks/finished_tasks_details/finished_details.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/tasks_screen/today_tasks/today_tasks_details/today_tasks_details.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/tools_screen/Employees/Add_Employee/add_employee_screen.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/tools_screen/Employees/Employee_Data.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/tools_screen/Employees/Employees.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/tools_screen/Employees/Employees_Details/employees_details_screen.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/tools_screen/Employees_Attebding/employee_attending.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/tools_screen/Employees_Attebding/webview.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/tools_screen/My_Attendance/my_attendance.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/tools_screen/personal_attending/personal_attending.dart';
import 'package:company_tasks_organizer/modules/login_screen/login_screen.dart';
import 'package:company_tasks_organizer/shared/bloc_observer.dart';
import 'package:company_tasks_organizer/shared/cubit/cubit.dart';
import 'package:company_tasks_organizer/shared/cubit/states.dart';
import 'package:company_tasks_organizer/shared/shared_preference/shared_preference.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:month_year_picker/month_year_picker.dart';

import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}
void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await translator.init(
    localeType: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'assets/lang/',
  );
  await CacheHelper.init();

  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  await FirebaseMessaging.instance.getToken();

  FirebaseMessaging.onMessage.listen((event) {
    Fluttertoast.showToast(
        msg: 'Hello, there is new task waiting you.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.black,
        fontSize: 16.0);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {});

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(LocalizedApp(
    child: MyApp(isDark),
  ));
}

class MyApp extends StatelessWidget {
  late final isDark;

  var delegates;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AppCubit()..changeMode(fromShared: isDark)),
          BlocProvider(create: (context) => AppLoginCubit()),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) => AppCubit(),
          builder: (context, state) {
            return MaterialApp(
              routes: {
                'CompanyMissionsDetailsScreen': (context) =>
                    CompanyMissionsDetailsScreen(),
                'FinishedTasksDetailsScreen': (context) =>
                    FinishedTasksDetailsScreen(),
                'TodayTasksDetailsScreen': (context) =>
                    TodayTasksDetailsScreen(),
                'BackUpDetailsScreen': (context) => BackUpDetailsScreen(),
                BackUpScreen.id: (context) => BackUpScreen(),
                SplashScreen.id: (context) => SplashScreen(),
                AdminLayout.id: (context) => AdminLayout(),
                LoginScreen.id: (context) => LoginScreen(),
                HomeScreen.id: (context) => HomeScreen(),
                PersonalAttendanceScreen.id: (context) =>
                    PersonalAttendanceScreen(),
                EmployeesScreen.id: (context) => EmployeesScreen(),
                AddEmployeeScreen.id: (context) => AddEmployeeScreen(),
                EmployeesDetailsScreen.id: (context) =>
                    EmployeesDetailsScreen(),
                EmployeesAttending.id: (context) => EmployeesAttending(),
                MyAttendance.id: (context) => MyAttendance(),
                EmployeeData.id: (context) => EmployeeData(),
                SettingsScreen.id: (context) => SettingsScreen(),
                LocationMap.id: (context) => LocationMap(),
              },
              theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                appBarTheme: AppBarTheme(
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  centerTitle: true,
                  iconTheme: IconThemeData(color: Colors.black),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  backgroundColor: Colors.white,
                  unselectedItemColor: Colors.grey,
                  elevation: 20.0,
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange,
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              darkTheme: ThemeData(
                scaffoldBackgroundColor: HexColor('333739'),
                indicatorColor:
                    AppCubit.get(context).isDark ? Colors.grey : Colors.white,
                primarySwatch: Colors.deepOrange,
                appBarTheme: AppBarTheme(
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('333739'),
                    statusBarIconBrightness: Brightness.light,
                  ),
                  backgroundColor: HexColor('333739'),
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  centerTitle: true,
                  iconTheme: IconThemeData(color: Colors.white),
                ),
                primaryIconTheme: IconThemeData(
                    color: AppCubit.get(context).isDark
                        ? Colors.grey
                        : Colors.white),
                iconTheme: IconThemeData(
                    color: AppCubit.get(context).isDark
                        ? Colors.grey
                        : Colors.white),
                hintColor:
                    AppCubit.get(context).isDark ? Colors.grey : Colors.white,
                focusColor:
                    AppCubit.get(context).isDark ? Colors.grey : Colors.white,
                primaryColor:
                    AppCubit.get(context).isDark ? Colors.grey : Colors.white,
                inputDecorationTheme: InputDecorationTheme(
                    iconColor: AppCubit.get(context).isDark
                        ? Colors.grey
                        : Colors.white,
                    labelStyle: TextStyle(
                      color: AppCubit.get(context).isDark
                          ? Colors.grey
                          : Colors.white,
                    ),
                    prefixIconColor: AppCubit.get(context).isDark
                        ? Colors.grey
                        : Colors.white),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  backgroundColor: HexColor('333739'),
                  unselectedItemColor: Colors.grey,
                  elevation: 20.0,
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange,
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              debugShowCheckedModeBanner: false,

              initialRoute: 'SplashScreen',

              localizationsDelegates: [
                MonthYearPickerLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],

              locale: translator.locale, // Active locale
              supportedLocales: translator.locals(),
            );
          },
        ));
  }
}
