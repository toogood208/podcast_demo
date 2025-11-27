import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:podcast_demo/utils/color_utils.dart';
import 'package:podcast_demo/views/podcast/main_page.dart';

import '../../providers/login/login_auth_notifier.dart';
import '../../providers/login/login_notifier.dart';
import '../shared/app_icon.dart';
import '../shared/custom_button.dart';
import '../shared/custom_text_field.dart';
import '../shared/error_overlay.dart';
import '../shared/loading_overlay.dart';

class LoginPage extends ConsumerStatefulWidget {
  @Preview(name: "login view")
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool showText = true;
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = ref.watch(loginProvider);
    final isValid = ref.watch(loginAuthProvider);
    ref.listen(loginProvider, (prev, next) {
      if (next.response != null && next.error == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainPage()),
        );
      }

      if (next.error != null) {
        debugPrint("Login error: ${next.error}");
      }
    });
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(backgroundColor: backgroundColor),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 22.w),
              child: Column(
                mainAxisAlignment: .start,
                crossAxisAlignment: .start,
                children: [
                  AppIcon(),
                  Text(
                    "Welcome back",
                    style: GoogleFonts.montserrat(
                      fontSize: 30.sp,
                      fontWeight: .w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "Welcome back! Please enter your details.",
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: .w400,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  CustomTextField(
                    formatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      ref
                          .read(loginAuthProvider.notifier)
                          .checkCredentials(
                            phoneController.text,
                            passwordController.text,
                          );
                    },
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    prefix: Image.asset("assets/images/naija.png"),
                    hintText: "Enter your phone number",
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    onChanged: (value) {
                      ref
                          .read(loginAuthProvider.notifier)
                          .checkCredentials(
                            phoneController.text,
                            passwordController.text,
                          );
                    },
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: showText,
                    suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          showText = !showText;
                        });
                      },
                      child: Icon(
                        showText
                            ? Icons.visibility_sharp
                            : Icons.visibility_off_sharp,
                        size: 20.r,
                      ),
                    ),
                    hintText: "Enter your password",
                  ),
                  SizedBox(height: 30.h),
                  CustomButton(
                    onPressed: () {
                      if (isValid) {
                        ref
                            .read(loginProvider.notifier)
                            .login(
                              phoneController.text,
                              passwordController.text,
                            );
                      }
                    },
                  ),
                  SizedBox(height: 17.h),
                  Row(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        "By proceeding, you agree and accept our ",
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: .w400,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "T&C",
                        style: GoogleFonts.poppins(
                          decoration: .underline,
                          decorationColor: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: .w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            LoadingOverlay(isLoading: provider.loading),

            ErrorOverlay(
              errorMessage: provider.error,
              onDismiss: () {
                ref.read(loginProvider.notifier).clearError();
              },
            ),
          ],
        ),
      ),
    );
  }
}
