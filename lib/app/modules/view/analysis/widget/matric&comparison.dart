import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/Theme/app_theme.dart';

Widget buildMetricCard(
    BuildContext context,
    String label,
    String value,
    String subtitle,
    IconData icon,
    Color color,
    ) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Container(
    padding: EdgeInsets.all(AppTheme.space16),
    decoration: BoxDecoration(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      boxShadow: Theme.of(context).brightness == Brightness.dark
          ? AppTheme.darkShadowSmall
          : AppTheme.shadowSmall,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 24.sp),
        Gap(AppTheme.space12),
        Text(
          label,
          style: textTheme.bodySmall,
        ),
        Gap(4.h),
        Text(
          value,
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle,
          style: textTheme.bodySmall?.copyWith(
            fontSize: 11.sp,
          ),
        ),
      ],
    ),
  );
}

Widget buildComparisonRow(BuildContext context, String label, String value, bool positive) {
  final colorScheme = Theme.of(context).colorScheme;

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 14.sp,
          color: colorScheme.onSurface.withOpacity(0.7),
        ),
      ),
      Row(
        children: [
          Icon(
            positive
                ? PhosphorIcons.trendUp(PhosphorIconsStyle.fill)
                : PhosphorIcons.trendDown(PhosphorIconsStyle.fill),
            color: positive ? AppTheme.success : AppTheme.error,
            size: 16.sp,
          ),
          Gap(4.w),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: positive ? AppTheme.success : AppTheme.error,
            ),
          ),
        ],
      ),
    ],
  );
}