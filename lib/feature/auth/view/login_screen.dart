import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_attendance/core/widgets/auth_container.dart';
import 'package:smart_attendance/core/widgets/auth_header.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/widgets/auth_action_button.dart';
import '../../../core/widgets/auth_text_field.dart';
import '../view_model/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginViewModel _viewModel = LoginViewModel();

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
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            children: [
              AuthHeader(title: 'Log In', onBack: () => Navigator.pop(context)),
              Transform.translate(
                offset: Offset(0, -20.h),
                child: AuthContainer(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20.h),
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
                      SizedBox(height: 28.h),
                      AuthActionButton(
                        title: 'Log In',
                        onPressed: () => _viewModel.login(context),
                      ),
                      SizedBox(height: 30.h),
                      GestureDetector(
                        onTap: () => _viewModel.goToRegister(context),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Don't have an account ? ",
                                style: TextStyles.font24Yellow700Weight(
                                  context,
                                ).copyWith(fontSize: 18.sp),
                              ),
                              TextSpan(
                                text: "Sign Up",
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
                      SizedBox(height: 26.h),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
