// lib/app/modules/plants/plants_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:gap/gap.dart';
import '../../../core/Theme/app_theme.dart';

class PlantsScreen extends StatelessWidget {
  const PlantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: colorScheme.surface,
              title: Text(
                'Solar Plants',
                style: textTheme.headlineMedium,
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    PhosphorIcons.funnel(PhosphorIconsStyle.regular),
                    color: colorScheme.onSurface,
                  ),
                  onPressed: () {},
                ),
                Gap(AppTheme.space8),
              ],
            ),
            SliverPadding(
              padding: EdgeInsets.all(AppTheme.space16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildOverviewCard(context, isDark),
                  Gap(AppTheme.space24),
                  Text(
                    'Your Plants',
                    style: textTheme.headlineSmall,
                  ),
                  Gap(AppTheme.space16),
                  _buildPlantCard(
                    context,
                    isDark: isDark,
                    name: 'Rooftop Solar A',
                    location: 'Building 1, Pimpri',
                    capacity: '30 kW',
                    currentOutput: '22.5 kW',
                    efficiency: 92,
                    status: 'Active',
                    lastCleaned: '2 days ago',
                  ),
                  Gap(AppTheme.space16),
                  _buildPlantCard(
                    context,
                    isDark: isDark,
                    name: 'Ground Mount B',
                    location: 'Plot 5, Pune',
                    capacity: '50 kW',
                    currentOutput: '38.2 kW',
                    efficiency: 88,
                    status: 'Active',
                    lastCleaned: '5 days ago',
                  ),
                  Gap(AppTheme.space16),
                  _buildAddPlantCard(context, isDark),
                  Gap(AppTheme.space24),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(BuildContext context, bool isDark) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(AppTheme.space20),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        boxShadow: isDark ? AppTheme.darkShadowMedium : AppTheme.shadowMedium,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem('2', 'Active Plants'),
              Container(
                width: 1.w,
                height: 40.h,
                color: AppTheme.textOnPrimary.withOpacity(0.3),
              ),
              _buildStatItem('80 kW', 'Total Capacity'),
              Container(
                width: 1.w,
                height: 40.h,
                color: AppTheme.textOnPrimary.withOpacity(0.3),
              ),
              _buildStatItem('90%', 'Avg Efficiency'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppTheme.textOnPrimary,
          ),
        ),
        Gap(4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: AppTheme.textOnPrimary.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildPlantCard(
      BuildContext context, {
        required bool isDark,
        required String name,
        required String location,
        required String capacity,
        required String currentOutput,
        required int efficiency,
        required String status,
        required String lastCleaned,
      }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(AppTheme.space16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        boxShadow: isDark ? AppTheme.darkShadowSmall : AppTheme.shadowSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: Icon(
                  PhosphorIcons.solarPanel(PhosphorIconsStyle.fill),
                  color: AppTheme.textOnPrimary,
                  size: 28.sp,
                ),
              ),
              Gap(AppTheme.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: textTheme.titleLarge,
                    ),
                    Gap(4.h),
                    Row(
                      children: [
                        Icon(
                          PhosphorIcons.mapPin(PhosphorIconsStyle.fill),
                          size: 12.sp,
                          color: isDark
                              ? AppTheme.darkTextSecondary
                              : AppTheme.textSecondary,
                        ),
                        Gap(4.w),
                        Text(
                          location,
                          style: textTheme.bodySmall?.copyWith(
                            color: isDark
                                ? AppTheme.darkTextSecondary
                                : AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.space12,
                  vertical: AppTheme.space4,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.success,
                  ),
                ),
              ),
            ],
          ),
          Gap(AppTheme.space16),

          // Metrics Container
          Container(
            padding: EdgeInsets.all(AppTheme.space12),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoItem(
                  context,
                  'Capacity',
                  capacity,
                  PhosphorIcons.lightning(PhosphorIconsStyle.fill),
                  isDark,
                ),
                _buildInfoItem(
                  context,
                  'Current',
                  currentOutput,
                  PhosphorIcons.facebookLogo(PhosphorIconsStyle.fill),
                  isDark,
                ),
                _buildInfoItem(
                  context,
                  'Efficiency',
                  '$efficiency%',
                  PhosphorIcons.chartLine(PhosphorIconsStyle.fill),
                  isDark,
                ),
              ],
            ),
          ),
          Gap(AppTheme.space12),

          // Footer Row
          Row(
            children: [
              Icon(
                PhosphorIcons.sparkle(PhosphorIconsStyle.fill),
                size: 14.sp,
                color: isDark
                    ? AppTheme.darkTextSecondary
                    : AppTheme.textSecondary,
              ),
              Gap(6.w),
              Text(
                'Last cleaned: $lastCleaned',
                style: textTheme.bodySmall?.copyWith(
                  color: isDark
                      ? AppTheme.darkTextSecondary
                      : AppTheme.textSecondary,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppTheme.space12,
                    vertical: AppTheme.space8,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View Details',
                      style: textTheme.labelMedium?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                    Gap(4.w),
                    Icon(
                      PhosphorIcons.arrowRight(PhosphorIconsStyle.bold),
                      size: 14.sp,
                      color: colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
      BuildContext context,
      String label,
      String value,
      IconData icon,
      bool isDark,
      ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 12.sp,
                color: colorScheme.primary,
              ),
              Gap(4.w),
              Text(
                label,
                style: textTheme.labelSmall?.copyWith(
                  color: isDark
                      ? AppTheme.darkTextSecondary
                      : AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          Gap(4.h),
          Text(
            value,
            style: textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildAddPlantCard(BuildContext context, bool isDark) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      child: Container(
        padding: EdgeInsets.all(AppTheme.space20),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: Border.all(
            color: colorScheme.primary.withOpacity(0.3),
            width: 2.w,
            style: BorderStyle.solid,
          ),
          boxShadow: isDark ? AppTheme.darkShadowSmall : AppTheme.shadowSmall,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(AppTheme.space12),
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              ),
              child: Icon(
                PhosphorIcons.plus(PhosphorIconsStyle.bold),
                color: colorScheme.primary,
                size: 24.sp,
              ),
            ),
            Gap(AppTheme.space16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add New Plant',
                    style: textTheme.titleLarge,
                  ),
                  Gap(4.h),
                  Text(
                    'Register a new solar installation',
                    style: textTheme.bodySmall?.copyWith(
                      color: isDark
                          ? AppTheme.darkTextSecondary
                          : AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
              color: colorScheme.primary,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}