import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_attendance/core/utils/app_assets.dart';
import '../view_model/fingerprint_view_model.dart';
import '../widgets/fingerprint_scanner_widget.dart';
import '../widgets/fingerprint_top_header.dart';

class FingerprintScreen extends StatefulWidget {
  const FingerprintScreen({super.key});

  @override
  State<FingerprintScreen> createState() => _FingerprintScreenState();
}

class _FingerprintScreenState extends State<FingerprintScreen> {
  final FingerprintViewModel _viewModel = FingerprintViewModel();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('FingerprintScreen build');
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.fingerprintBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            FingerprintTopHeader(
              onBack: () => _viewModel.goBack(context),
            ),
            Spacer(),
            FingerprintScannerWidget(
              onTap: () async {
                await _viewModel.scanFingerprint(context);
              },
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}