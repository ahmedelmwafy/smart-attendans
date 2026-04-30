import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_assets.dart';
import '../theme/text_styles.dart';

class FacultyInfoDialog extends StatelessWidget {
  const FacultyInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.asset(
                AppAssets.splashLogo, // Placeholder for faculty image
                height: 150.h,
                width: 250.w,
                fit: BoxFit.cover,
              ),
            ),
          SizedBox(height: 20.h),
          Text(
            'كلية التربية النوعية - جامعة المنصورة',
            style: TextStyles.font20Black500Weight(context).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'قسم تكنولوجيا التعليم',
            style: TextStyles.font16Dark400Weight(context).copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          const Divider(),
          SizedBox(height: 10.h),
          Text(
            'فريق العمل:',
            style: TextStyles.font16Dark400Weight(context).copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          _buildMemberName('شهد فتحي شوقي'),
          _buildMemberName('اسماء عبده عبدالهادي'),
          _buildMemberName('مني سرور الشحات'),
          SizedBox(height: 10.h),
        ],
      ),
    ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إغلاق'),
        ),
      ],
    );
  }

  Widget _buildMemberName(String name) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Text(
        name,
        style: TextStyle(fontSize: 16.sp),
        textAlign: TextAlign.center,
      ),
    );
  }
}

void showFacultyInfo(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const FacultyInfoDialog(),
  );
}
