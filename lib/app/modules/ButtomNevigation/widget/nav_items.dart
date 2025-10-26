

import 'dart:developer' as developer;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/Theme/app_theme.dart';
import '../main_controller.dart';


Widget buildNavItem({
  required BuildContext context,
  required MainController controller,
  required int index,
  required IconData icon,
  required IconData filledIcon,
  required String label,
}) {
  final colorScheme = Theme.of(context).colorScheme;
  final isSelected = controller.currentIndex.value == index;

  return GestureDetector(
    onTap: () => controller.changePage(index),
    behavior: HitTestBehavior.opaque,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(
        horizontal: isSelected ? 16.w : 12.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: isSelected
            ? colorScheme.primary.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? filledIcon : icon,
            color: isSelected
                ? colorScheme.primary
                : colorScheme.onSurface.withOpacity(0.6),
            size: 24.sp,
          ),
          SizedBox(height: 4.h),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: isSelected ? 11.sp : 10.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.onSurface.withOpacity(0.6),
            ),
            child: Text(label),
          ),
        ],
      ),
    ),
  );
}