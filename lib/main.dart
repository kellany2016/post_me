import 'package:flutter/material.dart';
import './home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF39796b),
        accentColor: Color(0xffb2dfdb)
      ),
      title:'Profile',
      home: Home(),
    );
  }
}