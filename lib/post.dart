import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  File? _pickedImage;
  final TextEditingController _postTextController = TextEditingController();

  late CollectionReference postsCollection;

  // Initialize Firestore collection reference in initState
  @override
  void initState() {
    super.initState();
    postsCollection = FirebaseFirestore.instance.collection('posts');
  }

  // Pick an image from the camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage == null) return;

    setState(() {
      _pickedImage = File(pickedImage.path);
    });
  }

  // Clear the selected image
  void _clearImage() {
    setState(() {
      _pickedImage = null;
    });
  }

  // Upload image to Cloud Storage and add post
  Future<void> _uploadImageAndAddPost() async {
    try {
      // Check if a user is authenticated
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        // Handle the case where the user is not authenticated
        print('User not authenticated');
        return;
      }

      // Check if an image is selected
      if (_pickedImage == null) {
        // Handle the case where no image is selected
        print('No image selected');
        return;
      }

      // Upload the image to Cloud Storage
      String userId = user.uid;
      String imagePath =
          'posts/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Show a loading indicator
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Uploading...'),
        duration: Duration(seconds: 5),
      ));

      // Upload the image
      await FirebaseStorage.instance.ref(imagePath).putFile(_pickedImage!);

      // Implement logic to save the post with image URL and text
      // You can use _pickedImage and _postTextController.text
      // Add your own implementation here
      await postsCollection.add({
        'title': 'New Post',
        'content': _postTextController.text,
        'imageUrl':
            'gs://practice-first-90f3b.appspot.com', // Update with your Storage URL
        'timestamp': FieldValue.serverTimestamp(),
      });
      // Clear the image and text fields after posting
      _clearImage();
      _postTextController.clear();

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Post added successfully!'),
      ));

      // Notify the calling widget that a post was added
      Navigator.pop(context, true);
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_pickedImage != null)
              Image.file(
                _pickedImage!,
                height: 200,
                fit: BoxFit.cover,
              ),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.camera),
                            title: Text('Take Photo'),
                            onTap: () {
                              _pickImage(ImageSource.camera);
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.image),
                            title: Text('Choose from Gallery'),
                            onTap: () {
                              _pickImage(ImageSource.gallery);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Icon(Icons.add_a_photo),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _postTextController,
              decoration: InputDecoration(
                hintText: 'Write anything...',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _uploadImageAndAddPost,
              child: Text('Add Post'),
            ),
          ],
        ),
      ),
    );
  }
}
