// ignore_for_file: implementation_imports, unused_import, unnecessary_import, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/uihelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  forgotPassword(String email) async {
    if (email == "") {
      return UiHelper.CustomAlertBox(
          context, "Enter an Eamil To Reset Password");
    } else {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
        centerTitle: true,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        UiHelper.CustomTextField(emailController, "Email", Icons.email, false),
        SizedBox(
          height: 20,
        ),
        UiHelper.CustomButtom(() {
          forgotPassword(emailController.text.toString());
        }, "Reset Password")
      ]),
    );
  }
}
