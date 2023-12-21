import 'package:firebase_project/screens/hospital_authorities.dart';
import 'package:firebase_project/screens/public_page.dart';
import 'package:flutter/material.dart';

class DonateRecieveScreen extends StatefulWidget {
  const DonateRecieveScreen({super.key});

  @override
  State<DonateRecieveScreen> createState() => _DonateRecieveScreenState();
}

class _DonateRecieveScreenState extends State<DonateRecieveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate-Recieve'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => PublicPage(),
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                backgroundColor: Color.fromRGBO(13, 2, 96, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Container(
                width: 300,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 50),
                child: Text(
                  'Public',
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => HospitalAuthoritiesPage(),
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                backgroundColor: Color.fromRGBO(13, 2, 96, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Container(
                width: 300,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 50),
                child: Text(
                  'Hospital Authorities',
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
