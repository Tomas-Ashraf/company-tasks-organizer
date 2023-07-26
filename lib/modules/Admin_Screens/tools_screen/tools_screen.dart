// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, deprecated_member_use

import 'package:company_tasks_organizer/modules/Admin_Screens/tools_screen/Employees/Employee_Data.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/tools_screen/Employees/Employees.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/tools_screen/Employees_Attebding/employee_attending.dart';
import 'package:company_tasks_organizer/modules/Admin_Screens/tools_screen/My_Attendance/my_attendance.dart';
import 'package:company_tasks_organizer/shared/components/inkwell_component.dart';
import 'package:company_tasks_organizer/shared/cubit/cubit.dart';
import 'package:company_tasks_organizer/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'personal_attending/personal_attending.dart';

class ToolsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWellComponent(
                    onTap: () {
                      Navigator.pushNamed(context, PersonalAttendanceScreen.id);
                    },
                    icon: Iconsax.clock,
                    iconSize: 50,
                    text: translator.translate('personalAttending'),
                    color: AppCubit.get(context).isDark
                        ? Colors.white
                        : Colors.black,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  InkWellComponent(
                    onTap: () {
                      AppLoginCubit.get(context).permission == 'Admin'
                          ? Navigator.pushNamed(context, EmployeesAttending.id)
                          : Navigator.pushNamed(context, MyAttendance.id,
                              arguments: AppLoginCubit.get(context).name);
                    },
                    icon: Iconsax.grid_1,
                    text: AppLoginCubit.get(context).permission == 'Admin'
                        ? translator.translate('employeesAttending')
                        : translator.translate('myAttendance'),
                    iconSize: 50,
                    color: AppCubit.get(context).isDark
                        ? Colors.white
                        : Colors.black,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  AppLoginCubit.get(context).permission == 'Admin'
                      ? InkWellComponent(
                          onTap: () {
                            Navigator.pushNamed(context, MyAttendance.id,
                                arguments: AppLoginCubit.get(context).name);
                          },
                          icon: Iconsax.grid_1,
                          text: translator.translate('myAttendance'),
                          iconSize: 50,
                          color: AppCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black,
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 30.0,
                  ),
                  InkWellComponent(
                    onTap: () {
                      AppLoginCubit.get(context).permission == 'Admin'
                          ? Navigator.pushNamed(context, EmployeesScreen.id)
                          : Navigator.pushNamed(context, EmployeeData.id);
                    },
                    icon: AppLoginCubit.get(context).permission == 'Admin'
                        ? Iconsax.people
                        : Iconsax.chart_square,
                    iconSize: 50,
                    text: AppLoginCubit.get(context).permission == 'Admin'
                        ? translator.translate('employees')
                        : translator.translate('yourData'),
                    color: AppCubit.get(context).isDark
                        ? Colors.white
                        : Colors.black,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
