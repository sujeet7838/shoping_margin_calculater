import 'package:calculater/firebase_options.dart';
import 'package:calculater/screens/dashboard.dart';
import 'package:calculater/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: LoginScreen(),
    );
  }
}
