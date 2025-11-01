import 'package:flutter/material.dart';
import './WeatherApplication.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherScreen(),
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
    );
  }
}



















// Agar tum MaterialApp nahi likhoge aur seedha Scaffold ya AppBar lagane ki koshish karoge → error milega: