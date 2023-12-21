// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unnecessary_import, implementation_imports, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/forgotpassword.dart';
import 'package:firebase_project/main.dart';
import 'package:firebase_project/screens/home.dart';
import 'package:firebase_project/signuppage.dart';
import 'package:firebase_project/uihelper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override //gfdf
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login(String email, String password) async {
    //verified
    if (email == "" && password == "") {
      return UiHelper.CustomAlertBox(context, "Enter Required Fields");
    }
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Check if the userCredential is not null
      if (userCredential.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(
                    title: 'Home Page',
                  )),
        );
      } else {
        return UiHelper.CustomAlertBox(context, "Login failed");
      }
    } on FirebaseAuthException catch (ex) {
      return UiHelper.CustomAlertBox(context, ex.code.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(emailController, "Email", Icons.mail, false),
          UiHelper.CustomTextField(
              passwordController, "Password", Icons.password, true),
          SizedBox(height: 30),
          UiHelper.CustomButtom(() {
            login(emailController.text.toString(),
                passwordController.text.toString());
          }, "Login"),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already Have an Account?",
                style: TextStyle(fontSize: 16),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUPPage()));
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 77, 19, 178)),
                  ))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ForgotPassword()));
              },
              child: Text(
                "Forgot Password",
                style: TextStyle(fontSize: 20),
              ))
        ],
      ),
    );
  }
}
