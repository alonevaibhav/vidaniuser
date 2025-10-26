import 'dart:developer' as developer;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:vidanisolar/app/modules/ButtomNevigation/widget/nav_items.dart';
import '../../core/services/ad_manager_service.dart';
import '../../core/theme/app_theme.dart';
import '../view/Cleaning/cleaning_screen.dart';
import '../view/Plants/plants_screen.dart';
import '../view/analysis/analysis_screen.dart';
import '../view/dashboard/dashboard_screen.dart';
import '../view/profile/profile.dart';
import 'main_controller.dart';

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

    return Obx(
      () => Scaffold(
        body: GestureDetector(
          // Track taps as clicks
          onTap: () {
            AdManager.to.incrementClick();
            developer.log(
              'Screen tapped (clicks: ${AdManager.to.clickCount.value})',
              name: 'MainScreen',
            );
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
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context, MainController controller) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(
      () => Container(
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
                buildNavItem(
                  context: context,
                  controller: controller,
                  index: 0,
                  icon: PhosphorIcons.house(),
                  filledIcon: PhosphorIcons.house(PhosphorIconsStyle.fill),
                  label: 'Dashboard',
                ),
                buildNavItem(
                  context: context,
                  controller: controller,
                  index: 1,
                  icon: PhosphorIcons.solarPanel(),
                  filledIcon: PhosphorIcons.solarPanel(PhosphorIconsStyle.fill),
                  label: 'Plants',
                ),
                buildNavItem(
                  context: context,
                  controller: controller,
                  index: 2,
                  icon: PhosphorIcons.sparkle(),
                  filledIcon: PhosphorIcons.sparkle(PhosphorIconsStyle.fill),
                  label: 'Cleaning',
                ),
                buildNavItem(
                  context: context,
                  controller: controller,
                  index: 3,
                  icon: PhosphorIcons.chartLine(),
                  filledIcon: PhosphorIcons.chartLine(PhosphorIconsStyle.fill),
                  label: 'Analysis',
                ),
                buildNavItem(
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
      ),
    );
  }
}
