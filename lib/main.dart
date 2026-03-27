import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_attendance/feature/auth/view/login_screen.dart';
import 'package:smart_attendance/feature/auth/view/register_screen.dart';
import 'package:smart_attendance/feature/fingerprint/view/fingerprint_screen.dart';
import 'package:smart_attendance/feature/student_form/views/student_form_screen.dart';
import 'feature/splash/view/splash_screen.dart';
import 'feature/welcome/view/welcome_screen.dart';
import 'core/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splash,
          routes: {
            AppRoutes.splash: (_) => const SplashScreen(),
            AppRoutes.welcome: (_) => WelcomeScreen(),
            AppRoutes.login: (_) => const LoginScreen(),
            AppRoutes.register: (_) => const RegisterScreen(),
            AppRoutes.fingerprint: (_) => const FingerprintScreen(),
            AppRoutes.studentForm: (_) => const StudentFormScreen(),
          },
        );
      },
    );
  }
}

void main() {
  runApp(const MyApp());
}