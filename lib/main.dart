import 'package:flutter/material.dart';
import 'package:valorant_companion/screens/landing_screen.dart';
import 'package:valorant_companion/utils/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: colorCustom,
        brightness: Brightness.dark
      ),
      home: const LandingScreen(),
    );
  }
}
