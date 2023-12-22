import 'package:flutter/material.dart';

class PublicPage extends StatelessWidget {
  const PublicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Public Page'),
      ),
      body: const Center(
        child: Text('This is the Public Page'),
      ),
    );
  }
}
