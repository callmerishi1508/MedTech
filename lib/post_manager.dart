// post_manager.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/model/post.dart';
// import 'post.dart';

class PostManager {
  static List<Post> posts = [];

  static Future<void> fetchPosts() async {
    // Fetch posts from Firebase Firestore
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('posts').get();

    // Convert query snapshot to a list of Post objects
    posts = querySnapshot.docs.map((doc) {
      return Post(
        title: doc['title'] ?? '', // Adjust these based on your data structure
        content: doc['content'] ?? '',
      );
    }).toList();
  }

  static void addPost(Post post) {
    // Add post locally and also upload it to Firebase
    posts.add(post);
    FirebaseFirestore.instance.collection('posts').add({
      'title': post.title,
      'content': post.content,
    });
  }

  static List<Post> getPosts() {
    return List.from(posts);
  }
}


