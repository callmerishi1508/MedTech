import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospital Authority Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HospitalAuthoritiesPage(),
    );
  }
}

class HospitalAuthoritiesPage extends StatefulWidget {
  @override
  _HospitalAuthoritiesPageState createState() =>
      _HospitalAuthoritiesPageState();
}

class _HospitalAuthoritiesPageState extends State<HospitalAuthoritiesPage> {
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospital Authority Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: codeController,
              decoration: InputDecoration(
                labelText: 'Code',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Handle login logic here
                String code = codeController.text;
                String password = passwordController.text;

                // You can implement authentication logic here
                // For simplicity, let's just print the values for now
                print('Code: $code');
                print('Password: $password');
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
