import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase_ui_auth;
import 'package:flutter/material.dart';
import 'package:validacao/utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return firebase_ui_auth.ProfileScreen(
      providers: const [],
      appBar: AppBar(
        title: Text('Perfil do Usuário', style: fontProfileAppBarTitle),
        backgroundColor: Colors.white,
        foregroundColor: textPrimaryColor,
        elevation: 0,
      ),
      actions: [
        firebase_ui_auth.SignedOutAction((context) {
          Navigator.of(context).pop();
        }),
      ],
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: AspectRatio(
            aspectRatio: 1.5,
            child: Container(
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite_rounded,
                    color: primaryTeal,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Thank you for being part of AidConnect!',
                    textAlign: TextAlign.center,
                    style: fontProfileBannerTitle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
