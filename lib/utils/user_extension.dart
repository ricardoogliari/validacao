import 'package:firebase_auth/firebase_auth.dart';

extension UserExtension on User {
  String get customId => '$email***$displayName';
}
