import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/colors.dart';
import 'package:flutter_application_1/firebase/auth_gate.dart';
import 'package:flutter_application_1/firebase/firebase_options.dart';
import 'package:flutter_application_1/home_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoviePal',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colours.scaffoldBgColor,
        colorScheme: ColorScheme.dark(),
      ),
      home: const AuthGate(),
    );
  }
}