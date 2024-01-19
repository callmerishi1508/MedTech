import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/model/post.dart';

class PostManager {
  static List<Post> posts = [];

  static Future<void> fetchPosts() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('posts').get();

    posts = querySnapshot.docs.map((doc) {
      return Post(
        title: doc['title'] ?? '',
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
