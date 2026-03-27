import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/widgets/app_svg.dart';

class FingerprintScannerWidget extends StatelessWidget {
  final VoidCallback onTap;

  const FingerprintScannerWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
             AppAssets.fingerprint,
            width: 180.w,
            height: 180.h,
            
          ),
          SizedBox(height: 18.h),
          Text(
            'Tap to scan fingerprint',
            style: TextStyles.font20Black500Weight(context).copyWith(
              color: ColorsManager.teal,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}