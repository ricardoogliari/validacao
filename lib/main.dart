import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart' show Sentry, SentryFlutter;
import 'package:validacao/firebase_options.dart';
import 'package:validacao/my_app.dart';
import 'package:validacao/ui/view_models/user_view_model.dart';
import 'package:validacao/utils/constants.dart';
import 'package:web/web.dart' as web;

const clientId =
    '258122187304-t7i2alip3pqo35dui8mk43mhc0bemt1s.apps.googleusercontent.com';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 1. Configura a tela de fallback (Evita a "Tela Branca da Morte")
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    // Garante que o erro de renderização seja enviado ao Sentry
    Sentry.captureException(
      errorDetails.exception,
      stackTrace: errorDetails.stack,
    );

    // Retorna uma UI amigável em vez de quebrar o Canvas
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.orange,
                  size: 64,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Ops! Encontramos um problema.',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Nossa equipe técnica já foi notificada. Por favor, recarregue a página para continuar.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    // No Flutter Web, quando o Canvas quebra feio,
                    // a melhor solução é forçar o reload da página pelo navegador.
                    if (kIsWeb) {
                      web.window.location.reload();
                    }
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Recarregar Página'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  };

  await SentryFlutter.init(
    (options) {
      options.dsn = dsn;

      // Ajuste o sample rate para performance (1.0 = 100% das transações)
      options.tracesSampleRate = 1.0;

      // Útil no Flutter Web para ver o que o usuário fez antes do erro
      options.attachStacktrace = true;
    },
    // O appRunner envelopa o app em um Zone customizado do Sentry,
    // capturando erros de Isolates e Promessas não resolvidas automaticamente.
    appRunner: () => runApp(
      ChangeNotifierProvider(
        create: (context) => UserViewModel(),
        child: const MyApp(clientId: clientId),
      ),
    ),
  );
}
