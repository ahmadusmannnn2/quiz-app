import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/quiz_provider.dart';
import 'screens/start_screen.dart'; // Import halaman awal

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      child: MaterialApp(
        title: 'UsmanQuiz👋',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const StartScreen(), // Halaman awal
      ),
    );
  }
}
