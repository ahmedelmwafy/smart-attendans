import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_attendance/core/theme/text_styles.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/app_assets.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const AuthHeader({super.key, required this.title, this.onBack});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360.h,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: onBack ?? () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: ColorsManager.teal,
                    size: 28.sp,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Image.asset(AppAssets.splashLogo, width: 150.w, height: 150.h),
              SizedBox(height: 12.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyles.font24White500Weight(context).copyWith(
                  color: Colors.teal,
                  shadows: const [
                    Shadow(
                      color: Colors.white,
                      offset: Offset(2, 2),
                      blurRadius: 0,
                    ),
                  ],
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
