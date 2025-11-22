import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    this.hintText = "",
    this.prefix,
    this.suffix,
    this.obscureText = false,
    this.keyboardType,
    this.controller,
    this.onChanged,
  });
  final String hintText;
  final Widget? prefix, suffix;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      cursorColor: Colors.white,
      style: GoogleFonts.nunito(
        color: Colors.white,
        fontSize: 16.sp
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        prefixIcon: prefix,
        suffixIcon: suffix,
        hintText: hintText,
        hintStyle: GoogleFonts.nunito(
          fontSize: 16.sp,
          color: Color(0xffe4e4e4),
        ),
        fillColor: Color(0xff383838),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: .circular(30.r),
          borderSide: BorderSide(width: 2, color: Color(0xff383838)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: .circular(30.r),
          borderSide: BorderSide(width: 2, color: Color(0xff383838)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: .circular(30.r),
          borderSide: BorderSide(width: 2, color: Color(0xff383838)),
        ),
      ),
    );
  }
}
