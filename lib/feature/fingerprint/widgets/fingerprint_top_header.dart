import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/app_assets.dart';

class FingerprintTopHeader extends StatelessWidget {
  final VoidCallback onBack;

  const FingerprintTopHeader({
    super.key,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340.h,
      child: Stack(
        children: [
          ClipPath(
            clipper: FingerprintHeaderClipper(),
            child: Container(
              height: 320.h,
              color: Colors.black.withOpacity(0.08),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onBack,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: ColorsManager.white,
                      size: 30.sp,
                    ),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 24.r,
                    backgroundImage: const AssetImage(AppAssets.profile),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FingerprintHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height - 40);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height + 30,
      size.width * 0.55,
      size.height - 10,
    );

    path.quadraticBezierTo(
      size.width * 0.82,
      size.height - 55,
      size.width,
      size.height - 5,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}