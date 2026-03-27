import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthContainer extends StatelessWidget {
  final Widget child;

  const AuthContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0F6B77).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(38.r),
      ),
      child: child,
    );
  }
}