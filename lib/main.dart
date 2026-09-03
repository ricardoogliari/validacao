import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:validacao/firebase_options.dart';
import 'package:validacao/my_app.dart';

// TODO(codelab user): Get API key
const clientId = 'YOUR_CLIENT_ID';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp(clientId: clientId));
}
