import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, size: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => ProfileScreen(
                    appBar: AppBar(title: const Text('User Profile')),
                    actions: [
                      SignedOutAction((context) {
                        Navigator.of(context).pop();
                      }),
                    ],
                    children: [
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.asset('assets/flutterfire_300x.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text('Welcome!', style: Theme.of(context).textTheme.displaySmall),
            Text(user?.displayName ?? 'User'),
            Text(user?.email ?? 'User'),
            if (user?.photoURL != null) ...[
              () {
                final originalUrl = user!.photoURL!.replaceAll(
                  RegExp(r'=s\d+-c$'),
                  '',
                );
                // Using images.weserv.nl as a proxy to bypass 429 rate limiting from Google CDN
                final photoUrl =
                    'https://images.weserv.nl/?url=${Uri.encodeComponent(originalUrl)}';
                return Image.network(
                  photoUrl,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const CircularProgressIndicator();
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.person, size: 100);
                  },
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                );
              }(),
            ] else
              const Icon(Icons.person, size: 100),
            const SizedBox(height: 16),
            const SignOutButton(),
          ],
        ),
      ),
    );
  }
}
