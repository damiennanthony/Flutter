import 'package:flutter_application_1/colors.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoviePal',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colours.scaffoldBgColor,
        colorScheme: ColorScheme.dark(),
      ),
      home: const HomeScreen(),
    );
  }
}