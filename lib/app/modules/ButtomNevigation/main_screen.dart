// lib/app/modules/main/main_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../core/theme/app_theme.dart';
import '../view/Cleaning/cleaning_screen.dart';
import '../view/Plants/plants_screen.dart';
import '../view/analysis/analysis_screen.dart';
import '../view/dashboard/dashboard_screen.dart';
import '../view/profile/profile.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());

    return Obx(() => Scaffold(
      body: IndexedStack(
        index: controller.currentIndex.value,
        children: const [
          DashboardScreen(),
          PlantsScreen(),
          CleaningScreen(),
          AnalysisScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(context, controller),
    ));
  }

  Widget _buildBottomNav(BuildContext context, MainController controller) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(() => Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.05),
            blurRadius: 20.r,
            offset: Offset(0, -4.h),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 65.h,
          padding: EdgeInsets.symmetric(horizontal: AppTheme.space8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context: context,
                controller: controller,
                index: 0,
                icon: PhosphorIcons.house(),
                filledIcon: PhosphorIcons.house(PhosphorIconsStyle.fill),
                label: 'Dashboard',
              ),
              _buildNavItem(
                context: context,
                controller: controller,
                index: 1,
                icon: PhosphorIcons.solarPanel(),
                filledIcon: PhosphorIcons.solarPanel(PhosphorIconsStyle.fill),
                label: 'Plants',
              ),
              _buildNavItem(
                context: context,
                controller: controller,
                index: 2,
                icon: PhosphorIcons.sparkle(),
                filledIcon: PhosphorIcons.sparkle(PhosphorIconsStyle.fill),
                label: 'Cleaning',
              ),
              _buildNavItem(
                context: context,
                controller: controller,
                index: 3,
                icon: PhosphorIcons.chartLine(),
                filledIcon: PhosphorIcons.chartLine(PhosphorIconsStyle.fill),
                label: 'Analysis',
              ),
              _buildNavItem(
                context: context,
                controller: controller,
                index: 4,
                icon: PhosphorIcons.user(),
                filledIcon: PhosphorIcons.user(PhosphorIconsStyle.fill),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildNavItem({
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
}
// lib/app/modules/main/main_controller.dart
class MainController extends GetxController {
  var currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize with dashboard
    currentIndex.value = 0;
  }
}