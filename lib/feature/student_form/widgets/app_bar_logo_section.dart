import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/app_assets.dart';

class AppBarLogoSection extends StatelessWidget {
  const AppBarLogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          AppAssets.splashLogo,
          width: 150.w,
          height: 150.h,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}