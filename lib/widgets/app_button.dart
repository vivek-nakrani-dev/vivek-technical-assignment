import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String text;
  final double radius;
  final VoidCallback? onPressed;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const AppButton({
    super.key,
    required this.text,
    required this.radius,
    this.onPressed,
    this.isLoading = false,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(radius), // Fully rounded
        ),
        alignment: Alignment.center,
        child: isLoading
            ? SizedBox(
                width: 20.w,
                height: 20.h,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.sp),
              )
            : Text(
                text,
                style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.w500),
              ),
      ),
    );
  }
}
