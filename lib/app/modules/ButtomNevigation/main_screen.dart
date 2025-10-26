import 'dart:developer' as developer;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../core/services/ad_manager_service.dart';
import '../../core/theme/app_theme.dart';
import '../view/Cleaning/cleaning_screen.dart';
import '../view/Plants/plants_screen.dart';
import '../view/analysis/analysis_screen.dart';
import '../view/dashboard/dashboard_screen.dart';
import '../view/profile/profile.dart';

class MainController extends GetxController {
  var currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;

    // Increment click counter
    AdManager.to.incrementClick();

    developer.log('Page changed to index $index (clicks: ${AdManager.to.clickCount.value})', name: 'MainController');

    // Check if we should show ad (after 10 clicks)
    if (AdManager.to.clickCount.value >= 10) {
      developer.log('10 clicks reached, trying to show ad', name: 'MainController');
      _tryShowAd();
    }
  }

  Future<void> _tryShowAd() async {
    // Add slight delay so ad doesn't interrupt navigation
    await Future.delayed(const Duration(milliseconds: 500));
    await AdOverlayManager.tryShowAd();
  }

  @override
  void onInit() {
    super.onInit();
    currentIndex.value = 0;
    developer.log('MainController initialized', name: 'MainController');
  }

  @override
  void onClose() {
    developer.log('MainController closed', name: 'MainController');
    super.onClose();
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());

    // Set overlay context after frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AdOverlayManager.setContext(context);
      developer.log('MainScreen context set for overlay', name: 'MainScreen');
    });

    return Obx(() => Scaffold(
      body: GestureDetector(
        // Track taps as clicks
        onTap: () {
          AdManager.to.incrementClick();
          developer.log('Screen tapped (clicks: ${AdManager.to.clickCount.value})', name: 'MainScreen');
        },
        child: IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            DashboardScreen(),
            PlantsScreen(),
            CleaningScreen(),
            AnalysisScreen(),
            ProfileScreen(),
          ],
        ),
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