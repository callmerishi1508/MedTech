import 'package:firebase_project/hospital_authorities_page.dart';
import 'package:firebase_project/uihelper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HospitalAuthoritiesLoginPage extends StatefulWidget {
  const HospitalAuthoritiesLoginPage({Key? key}) : super(key: key);

  @override
  _HospitalAuthoritiesLoginPageState createState() =>
      _HospitalAuthoritiesLoginPageState();
}

class _HospitalAuthoritiesLoginPageState
    extends State<HospitalAuthoritiesLoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  List<String> allowedEmails = ["test@example.com"];

  Future<void> login(String email, String password) async {
    // verified
    if (email == "" || password == "") {
      // You may handle this case as needed
      return;
    }
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if the userCredential is not null
      if (userCredential.user != null) {
        String userEmail = userCredential.user!.email ?? "";
        // Check if the logged-in user's email is in the allowedEmails list
        if (allowedEmails.contains(userEmail)) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HospitalAuthoritiesPage()),
          );
        } else {
          return UiHelper.CustomAlertBox(context, "Login failed");
        }
      }
    } on FirebaseAuthException catch (ex) {
      return UiHelper.CustomAlertBox(context, ex.code.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital Authority Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () async {
                // Use the login function here
                await login(emailController.text, passwordController.text);
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
