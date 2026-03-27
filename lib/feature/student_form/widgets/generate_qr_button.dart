import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';

class GenerateQrButton extends StatelessWidget {
  final VoidCallback onTap;

  const GenerateQrButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 74.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: ColorsManager.primaryColor,
          borderRadius: BorderRadius.circular(30.r),
          
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Generate QR Code',
                style: TextStyles.font24Yellow700Weight(context).copyWith(
                  color: const Color(0xff00F0FF),
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: const Color(0xff00F0FF),
              size: 38.sp,
            ),
          ],
        ),
      ),
    );
  }
}