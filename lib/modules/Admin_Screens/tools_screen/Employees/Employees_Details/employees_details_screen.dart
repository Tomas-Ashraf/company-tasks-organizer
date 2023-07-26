// ignore_for_file: prefer_const_constructors, unnecessary_cast, body_might_complete_normally_nullable, sized_box_for_whitespace, deprecated_member_use, non_constant_identifier_names, unused_local_variable, annotate_overrides, use_key_in_widget_constructors, must_be_immutable, override_on_non_overriding_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_tasks_organizer/shared/components/defaultTextFormField.dart';

import 'package:company_tasks_organizer/shared/components/myButton%20.dart';
import 'package:company_tasks_organizer/shared/cubit/cubit.dart';
import 'package:company_tasks_organizer/shared/cubit/states.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EmployeesDetailsScreen extends StatelessWidget {
  @override
  static String id = 'EmployeeDetailsScreen';
  double screenHeight = 0;
  double screenWidth = 0;

  final List<String> permissionItems = [
    'Admin',
    'Employee',
  ];
  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  Widget build(BuildContext context) {
    var Uid = ModalRoute.of(context)!.settings.arguments;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    var formKey = GlobalKey<FormState>();
    String? editName,
        editEmail,
        editPhone,
        editPassword,
        editCode,
        editDepartment,
        editGender,
        editPermission;
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(Uid as String?)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text(translator.translate('employeeDetails')),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(30, 70, 30, 50),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Icon(Iconsax.user_tag, size: 35),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            flex: 7,
                            child: Container(
                              width: screenWidth - 155,
                              child: Text(
                                FirebaseAuth.instance.currentUser!.uid ==
                                        snapshot.data!['Uid']
                                    ? '${snapshot.data!['name']} (You)'
                                    : snapshot.data!['name'],
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => BlocConsumer<AppLoginCubit,
                                        AppLoginStates>(
                                      listener: (context, state) {},
                                      builder: (context, state) {
                                        return Form(
                                          key: formKey,
                                          child: AlertDialog(
                                            backgroundColor:
                                                AppCubit.get(context).isDark
                                                    ? HexColor('333739')
                                                    : Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            content: Builder(
                                              builder: (context) {
                                                return Container(
                                                  height: screenWidth - 100,
                                                  width: double.infinity,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        translator.translate(
                                                            'enterNewName'),
                                                        style: TextStyle(
                                                          color: AppCubit.get(
                                                                      context)
                                                                  .isDark
                                                              ? Colors.white
                                                              : HexColor(
                                                                  '333739'),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      defaultTextFormFieldM(
                                                        maxLines: 1,
                                                        obscureText: false,
                                                        label: translator
                                                            .translate(
                                                                'enterNewName'),
                                                        keyboardType:
                                                            TextInputType.text,
                                                        prefixIcon:
                                                            Iconsax.user_tag,
                                                        onChanged: (value) {
                                                          editName = value;
                                                        },
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return translator
                                                                .translate(
                                                                    'namemustntbeEmpty');
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      myButton(
                                                          text: translator
                                                              .translate(
                                                                  'submit'),
                                                          onPressed: () async {
                                                            if (formKey
                                                                .currentState!
                                                                .validate()) {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Users')
                                                                  .doc(Uid
                                                                      as String?)
                                                                  .update({
                                                                'name': editName
                                                              }).then((value) {
                                                                Navigator.pop(
                                                                    context);
                                                              });
                                                            }
                                                          }),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(Iconsax.edit)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Icon(Icons.email_outlined, size: 35),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            flex: 7,
                            child: Container(
                              width: screenWidth - 155,
                              child: Text(
                                snapshot.data!['email'],
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Icon(Iconsax.mobile, size: 35),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            flex: 7,
                            child: SelectableText(
                              snapshot.data!['phone'],
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => BlocConsumer<AppLoginCubit,
                                        AppLoginStates>(
                                      listener: (context, state) {},
                                      builder: (context, state) {
                                        return Form(
                                          key: formKey,
                                          child: AlertDialog(
                                            backgroundColor:
                                                AppCubit.get(context).isDark
                                                    ? HexColor('333739')
                                                    : Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            content: Builder(
                                              builder: (context) {
                                                return Container(
                                                  height: screenWidth - 100,
                                                  width: double.infinity,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        translator.translate(
                                                            'enterNewPhone'),
                                                        style: TextStyle(
                                                          color: AppCubit.get(
                                                                      context)
                                                                  .isDark
                                                              ? Colors.white
                                                              : HexColor(
                                                                  '333739'),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      defaultTextFormFieldM(
                                                        maxLines: 1,
                                                        obscureText: false,
                                                        label: translator
                                                            .translate(
                                                                'enterNewPhone'),
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        prefixIcon:
                                                            Iconsax.mobile,
                                                        onChanged: (value) {
                                                          editPhone = value;
                                                        },
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return translator
                                                                .translate(
                                                                    'phonemustntbeEmpty');
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      myButton(
                                                          text: 'Submit',
                                                          onPressed: () async {
                                                            if (formKey
                                                                .currentState!
                                                                .validate()) {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Users')
                                                                  .doc(Uid
                                                                      as String?)
                                                                  .update({
                                                                'phone':
                                                                    editPhone
                                                              }).then((value) {
                                                                Navigator.pop(
                                                                    context);
                                                              });
                                                            }
                                                          }),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(Iconsax.edit)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Icon(Icons.password_rounded, size: 35),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            flex: 7,
                            child: Text(
                              snapshot.data!['password'],
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
                          Expanded(
                            child: Icon(Iconsax.code, size: 35),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            flex: 7,
                            child: Text(
                              snapshot.data!['code'],
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => BlocConsumer<AppLoginCubit,
                                        AppLoginStates>(
                                      listener: (context, state) {},
                                      builder: (context, state) {
                                        return Form(
                                          key: formKey,
                                          child: AlertDialog(
                                            backgroundColor:
                                                AppCubit.get(context).isDark
                                                    ? HexColor('333739')
                                                    : Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            content: Builder(
                                              builder: (context) {
                                                return Container(
                                                  height: screenWidth - 100,
                                                  width: double.infinity,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        translator.translate(
                                                            'enterNewCode'),
                                                        style: TextStyle(
                                                          color: AppCubit.get(
                                                                      context)
                                                                  .isDark
                                                              ? Colors.white
                                                              : HexColor(
                                                                  '333739'),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      defaultTextFormFieldM(
                                                        maxLines: 1,
                                                        obscureText: false,
                                                        label: translator
                                                            .translate(
                                                                'enterNewCode'),
                                                        keyboardType:
                                                            TextInputType.text,
                                                        prefixIcon:
                                                            Iconsax.code,
                                                        onChanged: (value) {
                                                          editCode = value;
                                                        },
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return translator
                                                                .translate(
                                                                    'codemustntbeEmpty');
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      myButton(
                                                          text: translator
                                                              .translate(
                                                                  'submit'),
                                                          onPressed: () async {
                                                            if (formKey
                                                                .currentState!
                                                                .validate()) {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Users')
                                                                  .doc(Uid
                                                                      as String?)
                                                                  .update({
                                                                'code': editCode
                                                              }).then((value) {
                                                                Navigator.pop(
                                                                    context);
                                                              });
                                                            }
                                                          }),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(Iconsax.edit)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Icon(Iconsax.buildings_2, size: 35),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            flex: 7,
                            child: Text(
                              snapshot.data!['department'],
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => BlocConsumer<AppLoginCubit,
                                        AppLoginStates>(
                                      listener: (context, state) {},
                                      builder: (context, state) {
                                        return Form(
                                          key: formKey,
                                          child: AlertDialog(
                                            backgroundColor:
                                                AppCubit.get(context).isDark
                                                    ? HexColor('333739')
                                                    : Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            content: Builder(
                                              builder: (context) {
                                                return Container(
                                                  height: screenWidth - 100,
                                                  width: double.infinity,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        translator.translate(
                                                            'enterNewDepartment'),
                                                        style: TextStyle(
                                                          color: AppCubit.get(
                                                                      context)
                                                                  .isDark
                                                              ? Colors.white
                                                              : HexColor(
                                                                  '333739'),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      defaultTextFormFieldM(
                                                        maxLines: 1,
                                                        obscureText: false,
                                                        label: translator.translate(
                                                            'enterNewDepartment'),
                                                        keyboardType:
                                                            TextInputType.text,
                                                        prefixIcon:
                                                            Iconsax.buildings_2,
                                                        onChanged: (value) {
                                                          editDepartment =
                                                              value;
                                                        },
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return translator
                                                                .translate(
                                                                    'departmentmustntbeEmpty');
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      myButton(
                                                          text: translator
                                                              .translate(
                                                                  'submit'),
                                                          onPressed: () async {
                                                            if (formKey
                                                                .currentState!
                                                                .validate()) {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Users')
                                                                  .doc(Uid
                                                                      as String?)
                                                                  .update({
                                                                'department':
                                                                    editDepartment
                                                              }).then((value) {
                                                                Navigator.pop(
                                                                    context);
                                                              });
                                                            }
                                                          }),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(Iconsax.edit)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Icon(Iconsax.man, size: 35),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            flex: 7,
                            child: Text(
                              snapshot.data!['gender'],
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => BlocConsumer<AppLoginCubit,
                                        AppLoginStates>(
                                      listener: (context, state) {},
                                      builder: (context, state) {
                                        return Form(
                                          key: formKey,
                                          child: AlertDialog(
                                            backgroundColor:
                                                AppCubit.get(context).isDark
                                                    ? HexColor('333739')
                                                    : Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            content: Builder(
                                              builder: (context) {
                                                return Container(
                                                  height: screenWidth - 100,
                                                  width: double.infinity,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        translator.translate(
                                                            'chooseNewGender'),
                                                        style: TextStyle(
                                                          color: AppCubit.get(
                                                                      context)
                                                                  .isDark
                                                              ? Colors.white
                                                              : HexColor(
                                                                  '333739'),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      DropdownButtonFormField2(
                                                        isExpanded: true,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          prefixIcon: Icon(
                                                            Iconsax.man,
                                                            color: AppCubit.get(
                                                                        context)
                                                                    .isDark
                                                                ? Colors.white
                                                                : Colors.black,
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            borderSide:
                                                                BorderSide(),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 2,
                                                              color: AppCubit.get(
                                                                          context)
                                                                      .isDark
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                            ),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            borderSide: BorderSide(
                                                                width: 2,
                                                                color: AppCubit.get(
                                                                            context)
                                                                        .isDark
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .orange),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 2,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                        hint: Text(
                                                          translator.translate(
                                                              'chooseNewGender'),
                                                          style: TextStyle(
                                                              fontSize:
                                                                  screenWidth /
                                                                      25,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        items: genderItems
                                                            .map((item) =>
                                                                DropdownMenuItem<
                                                                    String>(
                                                                  value: item,
                                                                  child: Text(
                                                                    item,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          screenWidth /
                                                                              20,
                                                                      color: AppCubit.get(context).isDark
                                                                          ? Colors
                                                                              .green
                                                                          : Colors
                                                                              .orange,
                                                                    ),
                                                                  ),
                                                                ))
                                                            .toList(),
                                                        validator: (value) {
                                                          if (value == null) {
                                                            return translator
                                                                .translate(
                                                                    'gendermustntbeEmpty');
                                                          }
                                                        },
                                                        onChanged: (value) {
                                                          editGender = value;
                                                        },
                                                        buttonStyleData:
                                                            ButtonStyleData(
                                                          height: 60,
                                                        ),
                                                        iconStyleData:
                                                            IconStyleData(
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            color:
                                                                Colors.black45,
                                                          ),
                                                          iconSize: 30,
                                                        ),
                                                        dropdownStyleData:
                                                            DropdownStyleData(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      myButton(
                                                          text: translator
                                                              .translate(
                                                                  'submit'),
                                                          onPressed: () async {
                                                            if (formKey
                                                                .currentState!
                                                                .validate()) {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Users')
                                                                  .doc(Uid
                                                                      as String?)
                                                                  .update({
                                                                'gender':
                                                                    editGender
                                                              }).then((value) {
                                                                Navigator.pop(
                                                                    context);
                                                              });
                                                            }
                                                          }),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(Iconsax.edit)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Icon(Iconsax.security_user, size: 35),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            flex: 7,
                            child: Text(
                              snapshot.data!['permission'],
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => BlocConsumer<AppLoginCubit,
                                        AppLoginStates>(
                                      listener: (context, state) {},
                                      builder: (context, state) {
                                        return Form(
                                          key: formKey,
                                          child: AlertDialog(
                                            backgroundColor:
                                                AppCubit.get(context).isDark
                                                    ? HexColor('333739')
                                                    : Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            content: Builder(
                                              builder: (context) {
                                                return Container(
                                                  height: screenWidth - 100,
                                                  width: double.infinity,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        translator.translate(
                                                            'chooseNewPermission'),
                                                        style: TextStyle(
                                                          color: AppCubit.get(
                                                                      context)
                                                                  .isDark
                                                              ? Colors.white
                                                              : HexColor(
                                                                  '333739'),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      DropdownButtonFormField2(
                                                        isExpanded: true,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          prefixIcon: Icon(
                                                            Iconsax
                                                                .security_user,
                                                            color: AppCubit.get(
                                                                        context)
                                                                    .isDark
                                                                ? Colors.white
                                                                : Colors.black,
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            borderSide:
                                                                BorderSide(),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 2,
                                                              color: AppCubit.get(
                                                                          context)
                                                                      .isDark
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                            ),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            borderSide: BorderSide(
                                                                width: 2,
                                                                color: AppCubit.get(
                                                                            context)
                                                                        .isDark
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .orange),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 2,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                        hint: Text(
                                                          translator.translate(
                                                              'chooseNewPermission'),
                                                          style: TextStyle(
                                                              fontSize:
                                                                  screenWidth /
                                                                      25,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        items: permissionItems
                                                            .map((item) =>
                                                                DropdownMenuItem<
                                                                    String>(
                                                                  value: item,
                                                                  child: Text(
                                                                    item,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          screenWidth /
                                                                              20,
                                                                      color: AppCubit.get(context).isDark
                                                                          ? Colors
                                                                              .green
                                                                          : Colors
                                                                              .orange,
                                                                    ),
                                                                  ),
                                                                ))
                                                            .toList(),
                                                        validator: (value) {
                                                          if (value == null) {
                                                            return translator
                                                                .translate(
                                                                    'permissionmustntbeEmpty');
                                                          }
                                                        },
                                                        onChanged: (value) {
                                                          editPermission =
                                                              value;
                                                        },
                                                        buttonStyleData:
                                                            ButtonStyleData(
                                                          height: 60,
                                                        ),
                                                        iconStyleData:
                                                            IconStyleData(
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            color:
                                                                Colors.black45,
                                                          ),
                                                          iconSize: 30,
                                                        ),
                                                        dropdownStyleData:
                                                            DropdownStyleData(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      myButton(
                                                          text: translator
                                                              .translate(
                                                                  'submit'),
                                                          onPressed: () async {
                                                            if (formKey
                                                                .currentState!
                                                                .validate()) {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Users')
                                                                  .doc(Uid
                                                                      as String?)
                                                                  .update({
                                                                'permission':
                                                                    editPermission
                                                              }).then((value) {
                                                                Navigator.pop(
                                                                    context);
                                                              });
                                                            }
                                                          }),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(Iconsax.edit)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: ModalProgressHUD(
                inAsyncCall: true,
                child: Text(''),
              ),
            );
          }
        });
  }
}
