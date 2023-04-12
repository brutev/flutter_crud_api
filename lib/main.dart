import 'package:flutter/material.dart';
import 'package:flutter_crud_api/views/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CRUD APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login()
    );
  }
}

