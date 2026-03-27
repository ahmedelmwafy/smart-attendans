import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';

class SplashViewModel {
  void navigateToNext(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.welcome);
      }
    });
  }
}