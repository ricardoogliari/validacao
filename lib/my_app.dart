import 'package:flutter/material.dart';
import 'package:validacao/ui/view/aid_connect_screen.dart';

import 'auth_gate.dart';

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
      home: AidConnectScreen(), //AuthGate(clientId: clientId),
    );
  }
}
