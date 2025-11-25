import 'package:calculater/screens/homeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//https://stackoverflow.com/questions/60323767/multiple-dependent-dropdown-in-flutter
  // This widget is the root of your application.
  //https://www.codementor.io/@nitishk72/flutter-bmi-calculator-app-1dlnjlhy6e
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculater App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
