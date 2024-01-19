// ignore_for_file: implementation_imports, unnecessary_import, unused_import, unused_local_variable, prefer_const_constructors, body_might_complete_normally_nullable, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:math';
import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project/main.dart';
import 'package:firebase_project/screens/home.dart';
import 'package:firebase_project/uihelper.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';

class SignUPPage extends StatefulWidget {
  const SignUPPage({super.key});

  @override
  State<SignUPPage> createState() => _SignUPPageState();
}

class _SignUPPageState extends State<SignUPPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? pickedImage;

  showAlertBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Pick image from"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    pickImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.camera_alt),
                  title: Text("Camera"),
                ),
                ListTile(
                  onTap: () async {
                    await pickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.image),
                  title: Text("Gallery"),
                ),
              ],
            ),
          );
        });
  }

  signUp(String email, String password) async {
    if (email == "" && password == "" || pickedImage == null) {
      return UiHelper.CustomAlertBox(context, "Enter Required Fields");
    } else {
      BuildContext localContext = context;

      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        await uploadData();
        // Use Future.microtask to capture the BuildContext outside the asynchronous gap
        Future.microtask(() {
          if (userCredential?.user != null) {
            Navigator.push(
              localContext,
              MaterialPageRoute(
                builder: (context) => MyHomePage(title: "HomePage"),
              ),
            );
          } else {
            UiHelper.CustomAlertBox(localContext, "Sign Up failed");
          }
        });
      } on FirebaseAuthException catch (ex) {
        // Use Future.microtask to capture the BuildContext outside the asynchronous gap
        Future.microtask(() {
          UiHelper.CustomAlertBox(localContext, ex.code.toString());
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up Page"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              showAlertBox();
            },
            child: pickedImage != null
                ? CircleAvatar(
                    radius: 80,
                    backgroundImage: FileImage(pickedImage!),
                  )
                : CircleAvatar(
                    radius: 80,
                    child: Icon(
                      Icons.person,
                      size: 80,
                    ),
                  ),
          ),
          UiHelper.CustomTextField(emailController, "Email", Icons.mail, false),
          UiHelper.CustomTextField(
              passwordController, "Password", Icons.password, true),
          SizedBox(height: 30),
          UiHelper.CustomButtom(() {
            signUp(emailController.text.toString(),
                passwordController.text.toString());
          }, "Sign Up")
        ],
      ),
    );
  }

  pickImage(ImageSource imageSource) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageSource);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });
    } catch (ex) {
      developer.log(ex.toString());
    }
  }

  uploadData() async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref("Profile Pics")
        .child(emailController.text.toString())
        .putFile(pickedImage!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String url = await taskSnapshot.ref.getDownloadURL();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(emailController.text.toString())
        .set({
      "Email": emailController.text.toString(),
      "Image": url,
    }).then((value) {
      developer.log("User Uploaded");
    });
  }
}
