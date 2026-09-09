import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validacao/ui/view/aid_connect_screen.dart';

import '../view_models/user_view_model.dart' show UserViewModel;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Provider.of<UserViewModel>(context),
      builder: (context, _) =>
          AidConnectScreen(user: Provider.of<UserViewModel>(context).user),
    );
  }
}
