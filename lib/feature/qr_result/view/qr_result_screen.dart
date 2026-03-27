import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/app_assets.dart';
import '../../student_form/widgets/student_form_app_bar.dart';
import '../model/student_qr_data.dart';
import '../view_model/qr_result_view_model.dart';
import '../widgets/qr_card.dart';

class QrResultScreen extends StatelessWidget {
  final StudentQrData data;

  const QrResultScreen({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = QrResultViewModel(data);

    return Scaffold(
      backgroundColor: ColorsManager.grey100,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppAssets.formBg,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.82),
            ),
          ),
          Column(
            children: [
              const StudentFormAppBar(),
              Expanded(
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        SizedBox(height: 90.h),
                        Text(
                          'Scan this QR to mark attendance',
                          textAlign: TextAlign.center,
                          style: TextStyles.font24Primary500Weight(context).copyWith(
                            fontSize: 24.sp,
                            color: ColorsManager.teal,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 50.h),
                        Center(
                          child: QrCard(
                            data: viewModel.qrData,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.home,
                          color: ColorsManager.teal,
                          size: 42.sp,
                        ),
                        SizedBox(height: 28.h),
                        Container(
                          height: 80.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0A6A73),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(36.r),
                              topRight: Radius.circular(36.r),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.18),
                                blurRadius: 10,
                                offset: const Offset(0, -3),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}