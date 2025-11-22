import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,

      excludeFromSemantics: true,
      child: Container(
        width: .infinity,
        height: 66.h,
        decoration: BoxDecoration(
          borderRadius: .circular(30),
          color: Color(0xff003334),
        ),
        child: Center(
          child: Text(
            "Continue",
            style: GoogleFonts.nunito(
              fontWeight: .w700,
              color: Colors.white,
              fontSize: 20.sp,
            ),
          ),
        ),
      ),
    );
  }
}