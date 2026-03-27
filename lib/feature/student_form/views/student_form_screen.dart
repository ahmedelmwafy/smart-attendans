import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/app_assets.dart';
import '../view_model/student_form_view_model.dart';
import '../widgets/generate_qr_button.dart';
import '../widgets/student_form_app_bar.dart';
import '../widgets/student_input_field.dart';

class StudentFormScreen extends StatefulWidget {
  const StudentFormScreen({super.key});

  @override
  State<StudentFormScreen> createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends State<StudentFormScreen> {
  final StudentFormViewModel _viewModel = StudentFormViewModel();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, bottom: 10.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyles.font24Primary500Weight(context).copyWith(
            fontSize: 28.sp,
            color: const Color(0xFF0B6170),
            fontWeight: FontWeight.w900,
            // shadows: [
            //   Shadow(
            //     color: Colors.black.withOpacity(0.25),
            //     offset: const Offset(0, 3),
            //     blurRadius: 4,
            //   ),
            // ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 18.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(context, label),
          StudentInputField(controller: controller),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              color: Colors.white.withOpacity(0.75),
            ),
          ),
          Column(
            children: [
              const StudentFormAppBar(),
              Expanded(
                child: SafeArea(
                  top: false,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
                    child: Column(
                      children: [
                        _buildField(
                          context: context,
                          label: 'Name',
                          controller: _viewModel.nameController,
                        ),
                        _buildField(
                          context: context,
                          label: 'ID',
                          controller: _viewModel.idController,
                        ),
                        _buildField(
                          context: context,
                          label: 'Department',
                          controller: _viewModel.departmentController,
                        ),
                        _buildField(
                          context: context,
                          label: 'The Band',
                          controller: _viewModel.bandController,
                        ),
                        _buildField(
                          context: context,
                          label: 'Branch',
                          controller: _viewModel.branchController,
                        ),
                        _buildField(
                          context: context,
                          label: 'The Course',
                          controller: _viewModel.courseController,
                        ),
                        SizedBox(height: 18.h),
                        GenerateQrButton(
                          onTap: () => _viewModel.generateQr(context),
                        ),
                        SizedBox(height: 40.h),
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