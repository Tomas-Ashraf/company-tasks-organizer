// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, avoid_print, body_might_complete_normally_nullable, annotate_overrides, override_on_non_overriding_member, use_key_in_widget_constructors, must_be_immutable, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:company_tasks_organizer/shared/components/components.dart';
import 'package:company_tasks_organizer/shared/components/defaultTextFormField.dart';
import 'package:company_tasks_organizer/shared/cubit/cubit.dart';
import 'package:company_tasks_organizer/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AddEmployeeScreen extends StatelessWidget {
  @override
  static String id = 'AddEmployeeScreen';
  String? name, email, department, gender, permission, password, phone, code;
  var formKey = GlobalKey<FormState>();
  double screenHeight = 0;
  double screenWidth = 0;

  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  final List<String> permissionItems = [
    translator.translate('admin'),
    translator.translate('employee'),
  ];
  final List<String> genderItems = [
    translator.translate('male'),
    translator.translate('female'),
  ];

  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<AppLoginCubit, AppLoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Scaffold(
            appBar: AppBar(
              title: Text(translator.translate('addEmployee')),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 25,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      defaultTextFormFieldM(
                        label: translator.translate('name'),
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        prefixIcon: Iconsax.user_tag,
                        onChanged: (data) {
                          name = data;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return translator.translate('namemustntbeEmpty');
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      defaultTextFormFieldM(
                        label: translator.translate('email'),
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        prefixIcon: Icons.email_outlined,
                        onChanged: (value) {
                          email = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return translator.translate('emailmustntbeEmpty');
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      defaultTextFormFieldM(
                        label: translator.translate('phone'),
                        keyboardType: TextInputType.phone,
                        obscureText: false,
                        prefixIcon: Iconsax.mobile,
                        onChanged: (value) {
                          phone = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return translator.translate('phonemustntbeEmpty');
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      defaultTextFormFieldM(
                        label: translator.translate('password'),
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        obscureText: AppLoginCubit.get(context).isSecure,
                        suffixIcon: AppLoginCubit.get(context).isSecure
                            ? Iconsax.eye
                            : Iconsax.eye_slash,
                        suffixOnPressed: () {
                          AppLoginCubit.get(context).securePassword();
                        },
                        prefixIcon: Icons.password_rounded,
                        onChanged: (value) {
                          password = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return translator
                                .translate('passwordmustntbeEmpty');
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      defaultTextFormFieldM(
                        label: translator.translate('code'),
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        obscureText: AppLoginCubit.get(context).isSecureCode,
                        suffixIcon: AppLoginCubit.get(context).isSecureCode
                            ? Iconsax.eye
                            : Iconsax.eye_slash,
                        suffixOnPressed: () {
                          AppLoginCubit.get(context).secureCode();
                        },
                        prefixIcon: Iconsax.code,
                        onChanged: (value) {
                          code = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return translator.translate('codemustntbeEmpty');
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      defaultTextFormFieldM(
                        label: translator.translate('department'),
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        prefixIcon: Iconsax.buildings_2,
                        onChanged: (value) {
                          department = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return translator
                                .translate('departmentmustntbeEmpty');
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      DropdownButtonFormField2(
                        isExpanded: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: Icon(
                            Iconsax.man,
                            color: AppCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 2,
                              color: AppCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 2,
                                color: AppCubit.get(context).isDark
                                    ? Colors.green
                                    : Colors.orange),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        hint: Text(
                          translator.translate('gender'),
                          style: TextStyle(
                              fontSize: screenWidth / 20, color: Colors.grey),
                        ),
                        items: genderItems
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppCubit.get(context).isDark
                                          ? Colors.green
                                          : Colors.orange,
                                    ),
                                  ),
                                ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return translator.translate('gendermustntbeEmpty');
                          }
                        },
                        onChanged: (value) {
                          gender = value;
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 60,
                        ),
                        iconStyleData: IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 30,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      DropdownButtonFormField2(
                        isExpanded: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: Icon(
                            Iconsax.security_user,
                            color: AppCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 2,
                              color: AppCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 2,
                                color: AppCubit.get(context).isDark
                                    ? Colors.green
                                    : Colors.orange),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        hint: Text(
                          translator.translate('permission'),
                          style: TextStyle(
                              fontSize: screenWidth / 20, color: Colors.grey),
                        ),
                        items: permissionItems
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppCubit.get(context).isDark
                                          ? Colors.green
                                          : Colors.orange,
                                    ),
                                  ),
                                ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return translator
                                .translate('permissionmustntbeEmpty');
                          }
                        },
                        onChanged: (value) {
                          permission = value;
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 60,
                        ),
                        iconStyleData: IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 30,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      ConditionalBuilder(
                        condition: true,
                        builder: (context) => myButton(
                            text: 'Add',
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                FirebaseApp app = await Firebase.initializeApp(
                                    name: 'Secondary',
                                    options: Firebase.app().options);
                                try {
                                  UserCredential user =
                                      await FirebaseAuth.instanceFor(app: app)
                                          .createUserWithEmailAndPassword(
                                              email: email!,
                                              password: password!);
                                  users.doc(user.user!.uid).set({
                                    'name': name,
                                    'email': email,
                                    'phone': phone,
                                    'password': password,
                                    'code': code,
                                    'department': department,
                                    'gender': gender,
                                    'permission': permission,
                                    'Uid': user.user!.uid,
                                    'time': DateTime.now(),
                                  });
                                  print(user.user!.email);
                                  print(
                                      FirebaseAuth.instance.currentUser!.email);
                                  Navigator.pop(context);
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    showSnackBar(
                                        context, 'Weak Password', Colors.red);
                                  } else if (e.code == 'email-already-in-use') {
                                    showSnackBar(
                                        context,
                                        'The account already exists for that email',
                                        Colors.red);
                                  }
                                }
                              }
                            }),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.indigo[100],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
