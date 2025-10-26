// lib/app/modules/plants/plants_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../core/Theme/app_theme.dart';

class PlantsScreen extends StatelessWidget {
  const PlantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: Text(
                'Solar Plants',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(PhosphorIcons.funnel()),
                  onPressed: () {},
                ),
                Gap(AppTheme.space8),
              ],
            ),
            SliverPadding(
              padding: EdgeInsets.all(AppTheme.space16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildOverviewCard(context),
                  Gap(AppTheme.space20),
                  Text(
                    'Your Plants',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(AppTheme.space16),
                  buildPlantCard(
                    context,
                    name: 'Rooftop Solar A',
                    location: 'Building 1, Pimpri',
                    capacity: '30 kW',
                    currentOutput: '22.5 kW',
                    efficiency: 92,
                    status: 'Active',
                    lastCleaned: '2 days ago',
                  ),
                  Gap(AppTheme.space16),
                  buildPlantCard(
                    context,
                    name: 'Ground Mount B',
                    location: 'Plot 5, Pune',
                    capacity: '50 kW',
                    currentOutput: '38.2 kW',
                    efficiency: 88,
                    status: 'Active',
                    lastCleaned: '5 days ago',
                  ),
                  Gap(AppTheme.space16),
                  _buildAddPlantCard(context),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppTheme.space20),
      decoration: BoxDecoration(
        // gradient: Theme.of(context).brightness == Brightness.dark
        //     ? AppTheme.darkPrimaryGradient
        //     : AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        boxShadow: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.darkShadowMedium
            : AppTheme.shadowMedium,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem('2', 'Active Plants'),
              Container(width: 1.w, height: 40.h, color: Colors.white30),
              _buildStatItem('80 kW', 'Total Capacity'),
              Container(width: 1.w, height: 40.h, color: Colors.white30),
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
            color: Colors.white,
          ),
        ),
        Gap(4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget buildPlantCard(
      BuildContext context, {
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
        boxShadow: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.darkShadowSmall
            : AppTheme.shadowSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  // gradient: Theme.of(context).brightness == Brightness.dark
                  //     ? AppTheme.darkPrimaryGradient
                  //     : AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: Icon(
                  PhosphorIcons.solarPanel(PhosphorIconsStyle.fill),
                  color: Colors.white,
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
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(4.h),
                    Row(
                      children: [
                        Icon(
                          PhosphorIcons.mapPin(PhosphorIconsStyle.fill),
                          size: 12.sp,
                          color: colorScheme.onSurface.withOpacity(0.6),
                        ),
                        Gap(4.w),
                        Text(
                          location,
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.space8,
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
          Container(
            padding: EdgeInsets.all(AppTheme.space12),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoItem(context, 'Capacity', capacity),
                _buildInfoItem(context, 'Current', currentOutput),
                _buildInfoItem(context, 'Efficiency', '$efficiency%'),
              ],
            ),
          ),
          Gap(AppTheme.space12),
          Row(
            children: [
              Icon(
                PhosphorIcons.sparkle(PhosphorIconsStyle.fill),
                size: 14.sp,
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
              Gap(6.w),
              Text(
                'Last cleaned: $lastCleaned',
                style: textTheme.bodySmall,
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Text('View Details'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            color: colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        Gap(4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildAddPlantCard(BuildContext context) {
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
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    'Register a new solar installation',
                    style: textTheme.bodySmall,
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