import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restapp2/external/colors_setting.dart';

class CTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final int? maxLines;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;

  CTextField({
    required this.controller,
    required this.hint,
    required this.keyboardType,
    this.maxLines = 1,
    this.onFieldSubmitted,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsSet.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: ColorsSet.sage2,
            offset: Offset(0.0, 0.5),
            blurRadius: 1.0,
          ),
        ],
      ),
      margin: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 0.w),
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted,
        controller: controller,
        focusNode: focusNode,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: const TextStyle(color: ColorsSet.sage),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(8.w, 0.w, 8.w, 0.w),
            border: InputBorder.none,
            hintText: hint,
            hintStyle: const TextStyle(color: ColorsSet.sage2)),
      ),
    );
  }
}
