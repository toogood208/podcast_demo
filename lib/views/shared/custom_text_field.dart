import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText = "",
    this.prefix,
    this.suffix,
    this.obscureText = false,
    this.keyboardType,
    this.controller,
    this.onChanged,
    this.formatters
  });
  final String hintText;
  final Widget? prefix, suffix;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller ;
  final Function(String)? onChanged ;
  final List<TextInputFormatter>? formatters;

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters:formatters,
      onChanged: onChanged,
    controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        prefixIcon: prefix,
        suffixIcon: suffix,
        hintText: hintText,
        hintStyle: GoogleFonts.nunito(
          fontSize: 16.sp,
          color: Color(0xff5a5a5a),
        ),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: .circular(30.r),
          borderSide: BorderSide(width: 2, color: Color(0xffa3cb43)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: .circular(30.r),
          borderSide: BorderSide(width: 2, color: Color(0xffa3cb43)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: .circular(30.r),
          borderSide: BorderSide(width: 2, color: Color(0xffa3cb43)),
        ),
      ),
    );
  }
}
