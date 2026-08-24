import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const KhadamatApp());
}

class KhadamatApp extends StatelessWidget {
  const KhadamatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'خدمات',
      theme: ThemeData(fontFamily: 'Cairo', useMaterial3: true),
      home: const WelcomeScreen(),
    );
  }
}
