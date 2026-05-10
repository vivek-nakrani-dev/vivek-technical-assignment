import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vivek_technical_assignment/widgets/app_button.dart';

Future<void> logOutSheet({required BuildContext context, required Function() onLogOut}) async {
  await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16.r))),
    builder: (_) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16.h),
            Text(
              'Log Out',
              style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.sp),
            Text(
              'Are you sure you want to log out?.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: .spaceAround,
              children: [
                Expanded(
                  child: AppButton(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    radius: 20.r,
                    onPressed: () => context.pop(),
                    text: 'No',
                  ),
                ),
                SizedBox(width: 12.h),
                Expanded(
                  child: AppButton(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    radius: 20.r,
                    onPressed: () => onLogOut(),
                    text: 'Yes',
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

Future<void> deleteNoteSheet({required BuildContext context, required Function() onDelete}) async {
  await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,

    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16.r))),
    builder: (_) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16.h),
            Text(
              'Delete Note',
              style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.sp),
            Text(
              'Are you sure you want to delete?.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: .spaceAround,
              children: [
                Expanded(
                  child: AppButton(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    radius: 20.r,
                    onPressed: () => context.pop(),
                    text: 'No',
                  ),
                ),
                SizedBox(width: 12.h),
                Expanded(
                  child: AppButton(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    radius: 20.r,
                    onPressed: () => onDelete(),
                    text: 'Yes',
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
