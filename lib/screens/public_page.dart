import 'package:flutter/material.dart';

class PublicPage extends StatelessWidget {
  const PublicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Public Page'),
      ),
      body: Center(
        child: Text('This is the Public Page'),
      ),
    );
  }
}
