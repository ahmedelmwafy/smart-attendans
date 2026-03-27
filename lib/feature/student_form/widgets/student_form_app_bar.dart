import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_assets.dart';
import 'app_bar_logo_section.dart';

class StudentFormAppBar extends StatelessWidget {
  const StudentFormAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A6A73),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            Image.asset(
              AppAssets.menu,
              width: 34.w,
              height: 34.h,
            ),
            Spacer(),
            AppBarLogoSection(),
            Spacer(),
            CircleAvatar(
              radius: 24.r,
              backgroundImage: const AssetImage(AppAssets.profile),
            ),
          ],
        ),
      ),
    );
  }
}