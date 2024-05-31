import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/widgets.dart';
import 'package:restapp2/external/colors_setting.dart';

class Warning extends StatelessWidget {
  final String errorMessage;
  final String errorImage;

  Warning({
    required this.errorMessage,
    required this.errorImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          errorImage,
          width: 150.w,
          height: 150.w,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: EdgeInsets.only(top: 16.w, left: 32.w, right: 32.w),
          child: Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorsSet.sage,
                fontSize: 20.sp,
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}
