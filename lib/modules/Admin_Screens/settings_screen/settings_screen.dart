// ignore_for_file: use_key_in_widget_constructors, implementation_imports, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_import, deprecated_member_use, avoid_print, use_build_context_synchronously

import 'package:company_tasks_organizer/modules/Admin_Screens/settings_screen/about_screen/about_screen.dart';
import 'package:company_tasks_organizer/shared/components/myButton%20.dart';
import 'package:company_tasks_organizer/shared/cubit/cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../shared/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  static String id = 'SettingsScreen';
  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 100),
          child: ListView(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    translator.translate('themeMode'),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  FlutterSwitch(
                      activeText: translator.translate('dark'),
                      activeIcon: Icon(Icons.dark_mode_sharp),
                      activeColor: Colors.black,
                      inactiveText: translator.translate('light'),
                      inactiveIcon: Icon(Icons.sunny),
                      width: 90.0,
                      height: 50,
                      padding: 8.0,
                      showOnOff: true,
                      value: cubit.isDark,
                      onToggle: ((value) {
                        AppCubit.get(context).changeMode(fromShared: null);
                      })),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    translator.translate('language'),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  FlutterSwitch(
                      activeText: 'English ',
                      activeIcon: Icon(Icons.language),
                      activeColor: cubit.isDark ? Colors.black : Colors.grey,
                      inactiveText: 'العربية',
                      inactiveIcon: Icon(Icons.language),
                      inactiveColor: cubit.isDark ? Colors.black : Colors.grey,
                      width: 110,
                      height: 50,
                      padding: 8.0,
                      showOnOff: true,
                      value: translator.currentLanguage == 'en' ? true : false,
                      onToggle: ((value) {
                        AppCubit.get(context).changeAppLanguage(context);
                      })),
                  SizedBox(
                    height: 50.0,
                  ),
                  myButton(
                      text: translator.translate('about'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutScreen(),
                            ));
                      }),
                  SizedBox(
                    height: 50.0,
                  ),
                  myButton(
                      text: translator.translate('logOut'),
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();

                        Navigator.pushNamedAndRemoveUntil(
                            context, 'LoginScreen', (route) => false);
                        AppCubit.get(context).CurrentIndex = 0;
                      }),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
