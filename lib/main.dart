import 'package:flutter/material.dart';
import 'package:multi_quiz/pages/home.dart';
import 'package:multi_quiz/pages/lanuch_screen.dart';
import 'package:multi_quiz/pages/multiquestion.dart';
import 'package:multi_quiz/pages/truefalse_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LaunchScreen(),
      routes: {
        '/homePage': (context) => const HomePage(),
        '/level1': (context) => const TruefalseQuiz(),
        '/level2': (context) => const MultiquestionQuiz(),
      },
    );
  }
}
