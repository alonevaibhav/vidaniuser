import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:gap/gap.dart';
import 'package:vidanisolar/app/modules/view/analysis/widget/matric&comparison.dart';
import '../../../core/Theme/app_theme.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: Text(
                'Analytics',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(PhosphorIcons.downloadSimple()),
                  onPressed: () {},
                ),
                Gap(AppTheme.space8),
              ],
            ),
            SliverPadding(
              padding: EdgeInsets.all(AppTheme.space16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildTimePeriodSelector(context),
                  Gap(AppTheme.space20),
                  _buildEnergyChart(context),
                  Gap(AppTheme.space20),
                  _buildMetricsGrid(context),
                  Gap(AppTheme.space20),
                  _buildPerformanceCard(context),
                  Gap(AppTheme.space20),
                  _buildSavingsCard(context),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePeriodSelector(BuildContext context) {
    return Row(
      children: [
        _buildPeriodChip(context, 'Today', true),
        Gap(AppTheme.space8),
        _buildPeriodChip(context, 'Week', false),
        Gap(AppTheme.space8),
        _buildPeriodChip(context, 'Month', false),
        Gap(AppTheme.space8),
        _buildPeriodChip(context, 'Year', false),
      ],
    );
  }

  Widget _buildPeriodChip(BuildContext context, String label, bool selected) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppTheme.space16,
          vertical: AppTheme.space8,
        ),
        decoration: BoxDecoration(
          color: selected
              ? colorScheme.primary
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: selected
                ? colorScheme.onPrimary
                : colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ),
    );
  }

  Widget _buildEnergyChart(BuildContext context) {
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
          Text(
            'Energy Production',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(AppTheme.space8),
          Text(
            '287.5 kWh today',
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          Gap(AppTheme.space16),
          Container(
            height: 180.h,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIcons.chartLine(PhosphorIconsStyle.fill),
                    size: 48.sp,
                    color: colorScheme.primary.withOpacity(0.5),
                  ),
                  Gap(AppTheme.space8),
                  Text(
                    'Chart visualization here',
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: buildMetricCard(
            context,
            'Peak Power',
            '52.3 kW',
            '11:30 AM',
            PhosphorIcons.trendUp(PhosphorIconsStyle.fill),
            AppTheme.warning,
          ),
        ),
        Gap(AppTheme.space12),
        Expanded(
          child: buildMetricCard(
            context,
            'Efficiency',
            '92%',
            'Excellent',
            PhosphorIcons.chartPieSlice(PhosphorIconsStyle.fill),
            AppTheme.success,
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceCard(BuildContext context) {
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
          Text(
            'Performance Comparison',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(AppTheme.space16),
          buildComparisonRow(context, 'vs. Yesterday', '+12.5%', true),
          Gap(AppTheme.space12),
          buildComparisonRow(context, 'vs. Last Week', '+8.3%', true),
          Gap(AppTheme.space12),
          buildComparisonRow(context, 'vs. Last Month', '-2.1%', false),
        ],
      ),
    );
  }

  Widget _buildSavingsCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppTheme.space20),
      decoration: BoxDecoration(
        // gradient: AppTheme.successGradient,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        boxShadow: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.darkShadowMedium
            : AppTheme.shadowMedium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                PhosphorIcons.leaf(PhosphorIconsStyle.fill),
                color: Colors.white,
                size: 24.sp,
              ),
              Gap(AppTheme.space8),
              Text(
                'Environmental Impact',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Gap(AppTheme.space16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '156.3 kg',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Money Saved',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white.withOpacity(0.9),
                      ),
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
}