import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/screens/home.dart';
import 'package:firebase_project/login.dart';
import 'package:flutter/material.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({Key? key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Delay the navigation until after the widget has been fully built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MyHomePage(title: "Home Page"),
          ),
        );
      });
    } else {
      // Delay the navigation until after the widget has been fully built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
