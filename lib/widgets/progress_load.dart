import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restapp2/external/colors_setting.dart';

class ProgressLoad extends StatelessWidget {
  const ProgressLoad({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        Padding(
          padding: EdgeInsets.only(top: 16.w, left: 32.w, right: 32.w),
          child: Text(
            "Loading restaurant data please wait...",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorsSet.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}
