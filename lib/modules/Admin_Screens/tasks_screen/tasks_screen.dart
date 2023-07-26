// ignore_for_file: use_key_in_widget_constructors, implementation_imports, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_import, deprecated_member_use

import 'package:company_tasks_organizer/shared/components/components.dart';
import 'package:company_tasks_organizer/shared/cubit/cubit.dart';
import 'package:company_tasks_organizer/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskssScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Center(
              child: SingleChildScrollView(
            child: myTasksScreen(context),
          )),
        );
      },
    );
  }
}
