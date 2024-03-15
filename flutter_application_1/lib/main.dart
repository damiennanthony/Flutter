import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/colors.dart';
import 'package:flutter_application_1/dependency_injection.dart';
import 'package:flutter_application_1/firebase/auth_gate.dart';
import 'package:flutter_application_1/firebase/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DependencyInjection.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoviePal',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colours.scaffoldBgColor,
        colorScheme: ColorScheme.dark(),
      ),
      home: const LoginPage(),
    );
  }
}