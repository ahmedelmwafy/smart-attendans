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

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final LoginViewModel _viewModel = LoginViewModel();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Listen for tab changes to update the UI
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
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
              AuthHeader(
                title: 'تسجيل الدخول',
                onBack: () => Navigator.pop(context),
              ),
              Transform.translate(
                offset: Offset(0, -20.h),
                child: AuthContainer(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Premium Tab Selector
                      Container(
                        height: 60.h,
                        padding: EdgeInsets.all(5.w),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                ColorsManager.primary500,
                                Colors.blueAccent,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: [
                              BoxShadow(
                                color: ColorsManager.primary500.withOpacity(
                                  0.3,
                                ),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey[600],
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.transparent,
                          tabs: const [
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.supervisor_account_outlined,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text('دكتور'),
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.school_outlined, size: 20),
                                  SizedBox(width: 8),
                                  Text('طالب'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 35.h),

                      // Animated Content
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        child: _tabController.index == 0
                            ? Column(
                                children: [
                                  AuthTextField(
                                    controller: _viewModel.emailController,
                                    hintText: 'البريد الإلكتروني',
                                    iconPath: AppAssets.email,
                                  ),
                                  AuthTextField(
                                    controller: _viewModel.passwordController,
                                    hintText: 'كلمة المرور',
                                    iconPath: AppAssets.lock,
                                    obscureText: true,
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  AuthTextField(
                                    controller: _viewModel.nameController,
                                    hintText: 'الاسم بالكامل',
                                    iconPath: AppAssets.profile,
                                  ),
                                  AuthTextField(
                                    controller: _viewModel.idController,
                                    hintText: 'الرقم الجامعي',
                                    iconPath: AppAssets.idCard,
                                  ),
                                ],
                              ),
                      ),

                      SizedBox(height: 20.h),
                      ValueListenableBuilder<bool>(
                        valueListenable: _viewModel.isLoading,
                        builder: (context, isLoading, child) {
                          return AuthActionButton(
                            title: 'دخول',
                            isLoading: isLoading,
                            onPressed: () {
                              if (_tabController.index == 0) {
                                _viewModel.login(context);
                              } else {
                                _viewModel.loginAsStudent(context);
                              }
                            },
                          );
                        },
                      ),
                      SizedBox(height: 35.h),
                      GestureDetector(
                        onTap: () => _viewModel.goToRegister(context),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "ليس لديك حساب؟ ",
                                style: TextStyles.font24Yellow700Weight(
                                  context,
                                ).copyWith(fontSize: 18.sp),
                              ),
                              TextSpan(
                                text: "سجل الآن",
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
