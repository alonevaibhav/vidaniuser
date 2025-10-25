import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/Theme/app_theme.dart';

Widget buildActivityItem(
  String title,
  String plant,
  String time,
  bool completed,
) {
  return Padding(
    padding: EdgeInsets.only(bottom: AppTheme.space12),
    child: Row(
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: completed
                ? AppTheme.success.withOpacity(0.1)
                : AppTheme.warning.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            completed
                ? PhosphorIcons.checkCircle(PhosphorIconsStyle.fill)
                : PhosphorIcons.clock(PhosphorIconsStyle.fill),
            color: completed ? AppTheme.success : AppTheme.warning,
            size: 20.sp,
          ),
        ),
        Gap(AppTheme.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              Gap(4.h),
              Text(
                '$plant • $time',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
