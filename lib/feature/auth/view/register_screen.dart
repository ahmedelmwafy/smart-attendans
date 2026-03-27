import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_attendance/core/widgets/auth_container.dart';
import 'package:smart_attendance/core/widgets/auth_header.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/widgets/auth_action_button.dart';
import '../../../core/widgets/auth_text_field.dart';
import '../view_model/register_view_model.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterViewModel _viewModel = RegisterViewModel();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.authBg),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 100,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  AuthHeader(
                    title: 'Create Your Account',
                    onBack: () => Navigator.pop(context),
                  ),
                  Transform.translate(
                    offset: Offset(0, -30.h),
                    child: AuthContainer(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AuthTextField(
                            controller: _viewModel.emailController,
                            hintText: 'Enter Your E-mail',
                            iconPath: AppAssets.email,
                          ),
                          AuthTextField(
                            controller: _viewModel.passwordController,
                            hintText: 'Enter Your Password',
                            iconPath: AppAssets.lock,
                            obscureText: true,
                          ),
                          AuthTextField(
                            controller: _viewModel.confirmPasswordController,
                            hintText: 'Confirm Your Password',
                            iconPath: AppAssets.lock,
                            obscureText: true,
                          ),
                          SizedBox(height: 10.h),
                          AuthActionButton(
                            title: 'Creat Account',
                            onPressed: () => _viewModel.register(context),
                          ),
                          SizedBox(height: 15.h),
                          GestureDetector(
                            onTap: () => _viewModel.goBack(context),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Already a member ? ",
                                    style: TextStyles.font24Yellow700Weight(context)
                                        .copyWith(
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Log In",
                                    style: TextStyles.font20White500Weight(context)
                                        .copyWith(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}