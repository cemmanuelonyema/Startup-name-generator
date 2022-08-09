import 'package:flutter/material.dart';
import './routes/home/widgets/random_words.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF045291),
          foregroundColor: Colors.white,
        ),
      ),
      home: const RandomWords(),
    );
  }
}
