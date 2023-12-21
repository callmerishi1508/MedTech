// ignore_for_file: prefer_const_constructors, unnecessary_import, implementation_imports, unused_import, file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/login.dart';
import 'package:firebase_project/main.dart';
import 'package:firebase_project/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  checkuser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return MyHomePage(title: "HomePage");
    } else {
      return LoginPage();
    }
  }
}
