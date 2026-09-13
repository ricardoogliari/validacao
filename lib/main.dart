import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
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

  // 1. Captura erros do Flutter (Ex: falhas de renderização, UI)
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    // Ou Sentry.captureException(errorDetails.exception);
  };

  // 2. Captura erros assíncronos do Dart fora do Flutter (Ex: Isolates, Promessas não tratadas)
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserViewModel(),
      child: const MyApp(clientId: clientId),
    ),
  );
}
