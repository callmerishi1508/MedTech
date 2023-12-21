import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/login.dart';
import 'package:firebase_project/screens/donate_recieve_screen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: unused_field
  int _counter = 0;
  int myIndex = 0;

  List<Widget> widgetList = [
    Text('Home', style: TextStyle(fontSize: 40)),
    Text('Medical Shops', style: TextStyle(fontSize: 40)),
    DonateRecieveScreen(),
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  logOut() async {
    await FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: IndexedStack(
        children: widgetList,
        index: myIndex,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: logOut,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
          // showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Color.fromARGB(255, 20, 5, 138),
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          currentIndex: myIndex,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home_mini_rounded),
                label: 'home',
                backgroundColor: Color.fromARGB(255, 219, 186, 84)),
            BottomNavigationBarItem(
                icon: Icon(Icons.medication),
                label: 'Medi',
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.heart_broken_rounded),
                label: 'Donate',
                backgroundColor: Colors.pink),
          ]),
    );
  }
}
