import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restapp2/external/colors_setting.dart';

class CButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double borderRadius;

  CButton({
    required this.text,
    required this.onTap,
    this.borderRadius = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 40.w,
      decoration: BoxDecoration(
          color: ColorsSet.sage,
          borderRadius: BorderRadius.circular(borderRadius)),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 20.sp,
                color: ColorsSet.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
