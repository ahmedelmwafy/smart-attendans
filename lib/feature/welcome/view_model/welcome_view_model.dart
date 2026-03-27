import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';

class WelcomeViewModel {
  void onLecturerTap(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.login);
  }

  void onStudentTap(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.login);
  }
}