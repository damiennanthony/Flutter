import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase/auth_gate.dart';

class MyApp extends StatelessWidget {
 const MyApp({super.key});
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     theme: ThemeData(
       primarySwatch: Colors.blue,
     ),
     home: const LoginPage(),
   );
 }
}