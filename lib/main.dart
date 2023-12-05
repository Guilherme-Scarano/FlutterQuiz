import 'package:flutter/material.dart';
import 'package:flutter_simple_quiz_app/bemvindo.dart';
import 'package:flutter_simple_quiz_app/quiz_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    home: BemVindoScreen(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BemVindoScreen(),
    );
  }
}
