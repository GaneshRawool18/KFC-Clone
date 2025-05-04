import 'package:flutter/material.dart';

class MyFavoriteMenuPage extends StatelessWidget {
  const MyFavoriteMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorite Menu'),
      ),
      body: const Center(
        child: Text(
          'Your favorite menu items will appear here!',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}