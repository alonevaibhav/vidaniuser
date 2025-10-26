// lib/app/modules/dashboard/dashboard_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:gap/gap.dart';
import '../../core/Theme/app_theme.dart';

class DashboardController extends GetxController {
  final _storage = GetStorage();

  // Observable variables
  var isDemoMode = true.obs;
  var userName = 'User'.obs;
  var isLoading = false.obs;
  var currentEnergyProduction = 0.0.obs;
  var todayEnergyGeneration = 0.0.obs;
  var carbonSaved = 0.0.obs;
  var activePlants = 0.obs;
  var loginPromptShown = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkAuthStatus();
    _loadDashboardData();
    _scheduleLoginPrompt();
  }

  void _checkAuthStatus() {
    final token = _storage.read('auth_token');
    isDemoMode.value = token == null;
    if (!isDemoMode.value) {
      userName.value = _storage.read('user_name') ?? 'User';
    }
  }

  Future<void> _loadDashboardData() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));

    if (isDemoMode.value) {
      // Demo data
      currentEnergyProduction.value = 45.8;
      todayEnergyGeneration.value = 287.5;
      carbonSaved.value = 156.3;
      activePlants.value = 2;
    } else {
      // Load real data from API
      // await _fetchRealData();
    }

    isLoading.value = false;
  }

  Future<void> refreshData() async {
    await _loadDashboardData();
  }

  void _scheduleLoginPrompt() {
    if (isDemoMode.value && !loginPromptShown.value) {
      Future.delayed(const Duration(seconds: 30), () {
        if (isDemoMode.value && !loginPromptShown.value) {
          showLoginSheet();
          loginPromptShown.value = true;
        }
      });
    }
  }

  void showLoginSheet() {
    Get.bottomSheet(
      _LoginBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void openNotifications() {
    if (isDemoMode.value) {
      Fluttertoast.showToast(
        msg: "Login to access notifications",
        toastLength: Toast.LENGTH_SHORT,
      );
      showLoginSheet();
    } else {
      // Navigate to notifications
      Get.toNamed('/notifications');
    }
  }

  void startManualCleaning() {
    if (isDemoMode.value) {
      showLoginSheet();
    } else {
      // Start manual cleaning
      Get.toNamed('/cleaning/manual');
    }
  }
}

// Login Bottom Sheet Widget
class _LoginBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.r),
        ),
      ),
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Gap(24.h),
          Icon(
            PhosphorIcons.lockKey(PhosphorIconsStyle.fill),
            size: 48.sp,
            color: AppTheme.primary,
          ),
          Gap(16.h),
          Text(
            'Unlock Full Access',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(12.h),
          Text(
            'Sign in to access all features and manage your solar plants',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppTheme.textSecondary,
            ),
          ),
          Gap(24.h),
          _buildFeatureItem(
            icon: PhosphorIcons.chartLine(PhosphorIconsStyle.fill),
            title: 'Real-time Analytics',
            subtitle: 'Monitor your energy production',
          ),
          Gap(12.h),
          _buildFeatureItem(
            icon: PhosphorIcons.lightning(PhosphorIconsStyle.fill),
            title: 'MQTT Control',
            subtitle: 'Control cleaning remotely',
          ),
          Gap(12.h),
          _buildFeatureItem(
            icon: PhosphorIcons.bell(PhosphorIconsStyle.fill),
            title: 'Smart Alerts',
            subtitle: 'Get notified about issues',
          ),
          Gap(24.h),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.toNamed('/login');
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50.h),
              backgroundColor: AppTheme.primary,
            ),
            child: Text(
              'Sign In',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
          ),
          Gap(12.h),
          TextButton(
            onPressed: () {
              Get.back();
              Get.toNamed('/signup');
            },
            child: Text('Create Account'),
          ),
          Gap(8.h),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppTheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, color: AppTheme.primary, size: 24.sp),
        ),
        Gap(16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// DASHBOARD WIDGETS
// =============================================================================



class DemoModeBanner extends StatelessWidget {
  const DemoModeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppTheme.space16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.demoMode.withOpacity(0.1),
            AppTheme.accent.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border.all(
          color: AppTheme.demoMode.withOpacity(0.3),
          width: 1.5.w,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppTheme.demoMode.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
            child: Icon(
              PhosphorIcons.eye(PhosphorIconsStyle.fill),
              color: AppTheme.demoMode,
              size: 20.sp,
            ),
          ),
          Gap(AppTheme.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Demo Mode Active',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  'Exploring with sample data',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            PhosphorIcons.info(),
            color: AppTheme.demoMode,
            size: 20.sp,
          ),
        ],
      ),
    );
  }
}

// lib/app/modules/dashboard/widgets/energy_production_card.dart
class EnergyProductionCard extends StatelessWidget {
  const EnergyProductionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppTheme.space20),
      decoration: BoxDecoration(
        // gradient: AppTheme.energyGradient,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        boxShadow: AppTheme.shadowMedium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    PhosphorIcons.lightning(PhosphorIconsStyle.fill),
                    color: Colors.white,
                    size: 24.sp,
                  ),
                  Gap(AppTheme.space8),
                  Text(
                    'Current Production',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.space8,
                  vertical: AppTheme.space4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: const BoxDecoration(
                        color: Colors.greenAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Gap(4.w),
                    Text(
                      'Live',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(AppTheme.space16),
          Text(
            '45.8',
            style: TextStyle(
              fontSize: 48.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1,
            ),
          ),
          Text(
            'kW',
            style: TextStyle(
              fontSize: 20.sp,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          Gap(AppTheme.space16),
          Container(
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.76,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
          ),
          Gap(AppTheme.space8),
          Text(
            '76% of peak capacity (60 kW)',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}

// lib/app/modules/dashboard/widgets/stats_grid.dart
class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: PhosphorIcons.sun(PhosphorIconsStyle.fill),
            label: 'Today',
            value: '287.5',
            unit: 'kWh',
            color: AppTheme.warning,
          ),
        ),
        Gap(AppTheme.space12),
        Expanded(
          child: _buildStatCard(
            icon: PhosphorIcons.leaf(PhosphorIconsStyle.fill),
            label: 'CO₂ Saved',
            value: '156.3',
            unit: 'kg',
            color: AppTheme.success,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required String unit,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(AppTheme.space16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        boxShadow: AppTheme.shadowSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
            child: Icon(icon, color: color, size: 20.sp),
          ),
          Gap(AppTheme.space12),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppTheme.textSecondary,
            ),
          ),
          Gap(4.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              Gap(4.w),
              Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Text(
                  unit,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}