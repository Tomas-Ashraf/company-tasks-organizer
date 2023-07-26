// ignore_for_file: use_key_in_widget_constructors, implementation_imports, prefer_const_constructors, unnecessary_import, unused_local_variable, deprecated_member_use, avoid_print

import 'package:company_tasks_organizer/shared/cubit/cubit.dart';
import 'package:company_tasks_organizer/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AdminLayout extends StatelessWidget {
  static String id = 'AppLayout';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) => AppCubit(),
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.CurrentIndex]),
          ),
          bottomNavigationBar: GNav(
            activeColor: Colors.orangeAccent,
            color: Colors.deepOrange,
            gap: 3,
            tabBackgroundColor: cubit.isDark ? Colors.white12 : Colors.black12,
            padding: EdgeInsets.all(15),
            textStyle: Theme.of(context).textTheme.bodyText1,
            curve: Curves.decelerate,
            tabs: cubit.bottomTabs,
            onTabChange: (index) {
              cubit.changeBottomNavBar(index);
            },
            selectedIndex: cubit.CurrentIndex,
          ),
          body: cubit.screens[cubit.CurrentIndex],
        );
      },
    );
  }
}
