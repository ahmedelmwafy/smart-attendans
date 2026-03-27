import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import '../../../core/routes/app_routes.dart';

/// Fingerprint View Model
class FingerprintViewModel {
  /// Local Authentication instance
  final LocalAuthentication _localAuth = LocalAuthentication();

  /// Dispose method
  void dispose() {}

  /// Navigate back
  void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  /// Scan fingerprint with biometric authentication
  /// 
  /// This method attempts to authenticate the user using fingerprint scanning.
  /// If the device does not support biometrics, it displays an error message.
  /// If authentication is successful, it navigates to the student form.
  Future<void> scanFingerprint(BuildContext context) async {
    try {
      debugPrint('==== Fingerprint Start ====');
      
      // Check if device supports biometrics
      final bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      final bool isDeviceSupported = await _localAuth.isDeviceSupported();
      final List<BiometricType> availableBiometrics = await _localAuth.getAvailableBiometrics();
      
      debugPrint('isDeviceSupported: $isDeviceSupported');
      debugPrint('canCheckBiometrics: $canCheckBiometrics');
      debugPrint('availableBiometrics: $availableBiometrics');

      // If device does not support biometrics, show error message
      if (!canCheckBiometrics || !isDeviceSupported) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Biometric authentication is not available on this device'),
            ),
          );
        }
        return;
      }

      // Show biometric authentication dialog
      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Please verify your fingerprint to continue',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );

      debugPrint('didAuthenticate: $didAuthenticate');

      // If context is not mounted, return
      if (!context.mounted) return;

      // If authentication is successful, navigate to student form
      if (didAuthenticate) {
        Navigator.pushReplacementNamed(context, AppRoutes.studentForm);
      } else {
        // If authentication fails, show error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Fingerprint authentication failed'),
          ),
        );
      }
    } catch (e) {
      // If context is not mounted, return
      if (!context.mounted) return;
      
      debugPrint('Authentication error: $e');
      
      // If an error occurs, show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Authentication error: $e'),
        ),
      );
    }
  }
}