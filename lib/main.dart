import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ContactManager',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ContactManager'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
