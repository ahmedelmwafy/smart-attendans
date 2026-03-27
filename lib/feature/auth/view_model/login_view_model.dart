import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';

class LoginViewModel {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  void login(BuildContext context) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    Navigator.pushReplacementNamed(context, AppRoutes.fingerprint);
  }

  void goToRegister(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.register);
  }
}