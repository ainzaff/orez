import 'package:flutter/material.dart';
import './image_picker_screen.dart';
import 'package:tflite_demo/home_screen.dart';
import './paddy_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
      ImagePickerScreen.routeName: (ctx) => ImagePickerScreen(),
      PaddyScreen.routeName: (ctx) => PaddyScreen()
      },
    );
  }
}

