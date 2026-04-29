import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/widgets/liquid_glass_button.dart';
import '../view_model/welcome_view_model.dart';
import '../widgets/top_curve_clipper.dart';

class WelcomeScreen extends StatelessWidget {
  final WelcomeViewModel _viewModel = WelcomeViewModel();

  WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.splashBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            ClipPath(
              clipper: TopCurveClipper(),
              child: SizedBox(
                width: double.infinity,
                height: 370.h,
                child: Image.asset(AppAssets.welcomeBg, fit: BoxFit.cover),
              ),
            ),

            Text(
              'Log In',
              style: TextStyles.font24White500Weight(
                context,
              ).copyWith(fontSize: 55.sp, fontWeight: FontWeight.w700),
            ),

            SizedBox(height: 50.h),

            LiquidGlassButton(
              title: 'lecturer',
              imagePath: AppAssets.lecturer,
              onTap: () => _viewModel.onLecturerTap(context),
            ),

            SizedBox(height: 18.h),

            LiquidGlassButton(
              title: 'Student',
              imagePath: AppAssets.student,
              onTap: () => _viewModel.onStudentTap(context),
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
