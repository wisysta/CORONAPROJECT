import 'package:flutter/material.dart';
import 'const/material_white.dart';
import 'main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      title: 'Corona Terminator',
      theme: ThemeData(
      primarySwatch: white,
      ),
    );
  }
}
