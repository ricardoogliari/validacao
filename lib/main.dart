import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validacao/firebase_options.dart';
import 'package:validacao/my_app.dart';
import 'package:validacao/ui/view_models/user_view_model.dart';

const clientId =
    '258122187304-t7i2alip3pqo35dui8mk43mhc0bemt1s.apps.googleusercontent.com';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserViewModel(),
      child: const MyApp(clientId: clientId),
    ),
  );
}
