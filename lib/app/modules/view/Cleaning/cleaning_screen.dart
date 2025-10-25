import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:vidanisolar/app/modules/view/Cleaning/widget/activity_items.dart';
import '../../../core/Theme/app_theme.dart';

class CleaningScreen extends StatelessWidget {
  const CleaningScreen({super.key});

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
                'Cleaning Management',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(AppTheme.space16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildControlCards(context),
                  Gap(AppTheme.space24),
                  Text(
                    'Scheduled Cleanings',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(AppTheme.space16),
                  buildScheduleCard(
                    context,
                    plantName: 'Rooftop Solar A',
                    type: 'Automatic',
                    date: 'Tomorrow, 8:00 AM',
                    status: 'Scheduled',
                  ),
                  Gap(AppTheme.space12),
                  buildScheduleCard(
                    context,
                    plantName: 'Ground Mount B',
                    type: 'Manual',
                    date: 'Today, 2:00 PM',
                    status: 'In Progress',
                  ),
                  Gap(AppTheme.space24),
                  Text(
                    'Recent Activity',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(AppTheme.space16),
                  buildActivityItem(
                    'Automatic cleaning completed',
                    'Rooftop Solar A',
                    '2 hours ago',
                    true,
                  ),
                  buildActivityItem(
                    'Manual cleaning started',
                    'Ground Mount B',
                    '4 hours ago',
                    false,
                  ),
                  buildActivityItem(
                    'Scheduled cleaning',
                    'Rooftop Solar A',
                    'Yesterday',
                    true,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(PhosphorIcons.sparkle(PhosphorIconsStyle.fill)),
        label: const Text('Start Cleaning'),
      ),
    );
  }

  Widget _buildControlCards(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: buildControlCard(
            context,
            icon: PhosphorIcons.play(PhosphorIconsStyle.fill),
            title: 'Manual',
            subtitle: 'Start now',
            color: AppTheme.primary,
          ),
        ),
        Gap(AppTheme.space12),
        Expanded(
          child: buildControlCard(
            context,
            icon: PhosphorIcons.clockClockwise(PhosphorIconsStyle.fill),
            title: 'Auto',
            subtitle: 'MQTT control',
            color: AppTheme.cleaningActive,
          ),
        ),
      ],
    );
  }

  Widget buildControlCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required Color color,
      }) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      child: Container(
        padding: EdgeInsets.all(AppTheme.space16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: Border.all(color: color.withOpacity(0.3), width: 1.w),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32.sp),
            Gap(AppTheme.space12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            Gap(4.h),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12.sp,
                color: colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildScheduleCard(
      BuildContext context, {
        required String plantName,
        required String type,
        required String date,
        required String status,
      }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isInProgress = status == 'In Progress';

    return Container(
      padding: EdgeInsets.all(AppTheme.space16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        boxShadow: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.darkShadowSmall
            : AppTheme.shadowSmall,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppTheme.space12),
            decoration: BoxDecoration(
              color: isInProgress
                  ? AppTheme.warning.withOpacity(0.1)
                  : colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
            child: Icon(
              isInProgress
                  ? PhosphorIcons.hourglass(PhosphorIconsStyle.fill)
                  : PhosphorIcons.calendar(PhosphorIconsStyle.fill),
              color: isInProgress ? AppTheme.warning : colorScheme.primary,
              size: 24.sp,
            ),
          ),
          Gap(AppTheme.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plantName,
                  style: textTheme.titleMedium,
                ),
                Gap(4.h),
                Row(
                  children: [
                    Text(
                      '$type • ',
                      style: textTheme.bodySmall,
                    ),
                    Text(
                      date,
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
              color: isInProgress
                  ? AppTheme.warning.withOpacity(0.1)
                  : AppTheme.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: isInProgress ? AppTheme.warning : AppTheme.success,
              ),
            ),
          ),
        ],
      ),
    );
  }
}