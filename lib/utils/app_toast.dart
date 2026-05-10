import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

void appToast({String? message}) {
  final Widget widget = SingleChildScrollView(
    physics: const NeverScrollableScrollPhysics(),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      width: double.maxFinite,
      child: Text(
        message ?? " ",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13.sp),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );

  showToastWidget(
    widget,
    duration: const Duration(seconds: 3),
    position: ToastPosition.bottom,
    onDismiss: () {
      debugPrint('Toast has been dismissed.');
    },
  );
}
