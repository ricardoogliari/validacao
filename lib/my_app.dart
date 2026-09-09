import 'package:flutter/material.dart';
import 'package:validacao/ui/view/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.clientId});

  final String clientId;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}
