import 'package:firebase_project/model/post.dart';
import 'package:firebase_project/post.dart';
import 'package:firebase_project/post_manager.dart';
import 'package:firebase_project/screens/donate_recieve_screen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int myIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    await PostManager.fetchPosts();
    setState(() {}); // Trigger a rebuild to show the loaded posts
  }

  @override
  Widget build(BuildContext context) {
    List<Post> posts = PostManager.getPosts();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                // Your existing code for settings
              },
              icon: Icon(Icons.settings),
            )
          ],
        ),
      ),
      body: IndexedStack(
        children: [
          _buildHomeScreen(posts), // Call tphe _buildHomeScreen method
          Text('Medicine', style: TextStyle(fontSize: 40)),
          Text('Hospital', style: TextStyle(fontSize: 40)),
          DonateRecieveScreen(),
        ],
        index: myIndex,
      ),
      floatingActionButton: myIndex == 0
          ? Positioned(
              bottom: 30,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton(
                  onPressed: () async {
                    bool postAdded = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPostPage(),
                      ),
                    );

                    if (postAdded) {
                      setState(() {
                        // Update posts list from PostManager
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

  Widget _buildHomeScreen(List<Post> posts) {
    // TODO: Implement the logic to display the list of posts here
    // You can use ListView.builder or other widgets to show the posts
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(posts[index].title),
          subtitle: Text(posts[index].content),
          // Add more UI elements as needed
        );
      },
    );
  }
}
