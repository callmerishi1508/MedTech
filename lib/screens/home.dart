// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, duplicate_import, unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/login.dart';
import 'package:firebase_project/post.dart';
import 'package:firebase_project/screens/donate_recieve_screen.dart';
import 'package:firebase_project/settings.dart';
import 'package:firebase_project/post.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Post {
  final String title;
  final String content;

  Post({required this.title, required this.content});
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int myIndex = 0;
  List<AddPostPage> posts = []; // List to store posts

  List<Widget> widgetList = [
    Text('Home', style: TextStyle(fontSize: 40)),
    Text('Medicine', style: TextStyle(fontSize: 40)),
    Text('Hospital', style: TextStyle(fontSize: 40)),
    DonateRecieveScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          // title: Text(widget.title),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsTab(title: "Settings"),
                  ),
                );
              },
              icon: Icon(Icons.settings),
            )
          ],
        ),
      ),
      body: IndexedStack(
        children: widgetList,
        index: myIndex,
      ),
      floatingActionButton: myIndex == 0
          ? Positioned(
              bottom: 30,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton(
                  onPressed: () async {
                    // Navigate to AddPostPage and wait for a result
                    bool postAdded = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPostPage(),
                      ),
                    );

                    // If a post was added, refresh the UI
                    if (postAdded) {
                      // Reload posts from your data source (e.g., Firebase)
                      // For simplicity, let's assume posts is a List<Post> obtained from your data source
                      // Update the posts list as needed
                      setState(() {
                        // Example: posts = await fetchPostsFromFirebase();
                        // Make sure to update the posts list with the new data
                      });
                    }
                  },
                  tooltip: 'Add Post',
                  child: const Icon(Icons.add),
                ),
              ),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
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
            label: 'Home',
            backgroundColor: Color.fromARGB(255, 219, 186, 84),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medication),
            label: 'Medicine',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.horizontal_split_sharp),
            label: 'Hospital',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.heart_broken_rounded),
            label: 'Donate',
            backgroundColor: Colors.pink,
          ),
        ],
      ),
    );
  }
}
