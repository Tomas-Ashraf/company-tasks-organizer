// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, annotate_overrides, override_on_non_overriding_member, prefer_const_constructors, avoid_print, use_build_context_synchronously, unused_local_variable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_tasks_organizer/layout/admin_layout/admin_layout.dart';
import 'package:company_tasks_organizer/shared/components/components.dart';
import 'package:company_tasks_organizer/shared/components/defaultTextFormField.dart';
import 'package:company_tasks_organizer/shared/cubit/cubit.dart';
import 'package:company_tasks_organizer/shared/cubit/states.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  @override
  static String id = 'LoginScreen';
  String? email, password;
  var formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return BlocConsumer<AppLoginCubit, AppLoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: formKey,
          child: ModalProgressHUD(
            inAsyncCall: AppLoginCubit.get(context).isLoading,
            blur: 10,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Company Task Organizer',
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 35,
                  horizontal: 25,
                ),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AppCubit.get(context).isDark
                            ? Image.asset('assets/images/login_dark.png')
                            : Image.asset('assets/images/login.png'),
                        SizedBox(
                          height: 50,
                        ),
                        defaultTextFormFieldM(
                          label: 'Email',
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icons.email_outlined,
                          onChanged: (value) {
                            email = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '       Email mustn\'t be Empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        defaultTextFormFieldM(
                          label: 'Password',
                          maxLines: 1,
                          obscureText: AppLoginCubit.get(context).isSecure,
                          keyboardType: TextInputType.visiblePassword,
                          prefixIcon: Icons.password_outlined,
                          suffixIcon: AppLoginCubit.get(context).isSecure
                              ? Iconsax.eye
                              : Iconsax.eye_slash,
                          suffixOnPressed: () {
                            AppLoginCubit.get(context).securePassword();
                          },
                          onChanged: (value) {
                            password = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '       Password mustn\'t be Empty';
                            }
                            return null;
                          },
                          onFiledSubmitted: (value) async {
                            if (formKey.currentState!.validate()) {
                              try {
                                await loginUser();
                                print(FirebaseAuth.instance.currentUser!.email);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AdminLayout()));
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  showSnackBar(
                                      context,
                                      'No user found for that email.',
                                      Colors.red);
                                } else if (e.code == 'wrong-password') {
                                  showSnackBar(
                                      context,
                                      'Wrong password provided for that user.',
                                      Colors.red);
                                }
                              }
                            }
                          },
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        myButton(
                            text: 'Login',
                            onPressed: () async {
                              AppLoginCubit.get(context).loadingPage();
                              if (formKey.currentState!.validate()) {
                                try {
                                  await loginUser();
                                  await addToken();
                                  await getPermission();
                                  await getCode();
                                  print(FirebaseAuth.instance.currentUser!.uid);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AdminLayout()),
                                      (route) => false);
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    showSnackBar(
                                        context,
                                        'No user found for that email.',
                                        Colors.red);
                                  } else if (e.code == 'wrong-password') {
                                    showSnackBar(
                                        context,
                                        'Wrong password provided for that user.',
                                        Colors.red);
                                  }
                                }
                              }
                              AppLoginCubit.get(context).loadingPage();
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> addToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    await FirebaseFirestore.instance
        .collection('tokens')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'token': token,
      'platform': Platform.operatingSystem,
    });
  }

  Future<void> loginUser() async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}

Future<void> getPermission() async {
  DocumentSnapshot user = await FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .get();
  String userPermission = user['permission'];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('userPermission', userPermission);
  print(prefs.getString('userPermission'));
}

Future<void> getCode() async {
  DocumentSnapshot user = await FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .get();
  String userCode = user['code'];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('userCode', userCode);
  print(prefs.getString('userCode'));
}
