//
// import 'package:flutter/material.dart';
// import '../../../core/Theme/app_theme.dart';
// import '../../../core/widgets/theme_toggle.dart';
//
// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           // Animated App Bar with Gradient
//           SliverAppBar(
//             expandedHeight: 200,
//             floating: false,
//             pinned: true,
//             backgroundColor: Colors.transparent,
//             flexibleSpace: FlexibleSpaceBar(
//               background: Container(
//                 decoration: BoxDecoration(gradient: AppTheme.primaryGradient),
//                 child: SafeArea(
//                   child: Padding(
//                     padding: EdgeInsets.all(AppTheme.space24),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Welcome Back! ☀️',
//                                   style: Theme.of(context).textTheme.titleLarge
//                                       ?.copyWith(color: Colors.white70),
//                                 ),
//                                 SizedBox(height: 4),
//                                 Text(
//                                   'Solar Dashboard',
//                                   style: Theme.of(context).textTheme.displaySmall
//                                       ?.copyWith(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             // Theme Toggle Button
//                             ThemeToggleButton(),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//
//           // Dashboard Content
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.all(AppTheme.space16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Quick Stats Grid
//                   _buildQuickStatsGrid(context),
//
//                   SizedBox(height: AppTheme.space24),
//
//                   // Live Production Card
//                   _buildLiveProductionCard(context),
//
//                   SizedBox(height: AppTheme.space24),
//
//                   // Plant Status Section
//                   Text(
//                     'Plant Status',
//                     style: Theme.of(context).textTheme.headlineMedium,
//                   ),
//                   SizedBox(height: AppTheme.space16),
//                   _buildPlantStatusCards(context),
//
//                   SizedBox(height: AppTheme.space24),
//
//                   // Cleaning Management
//                   Text(
//                     'Cleaning Management',
//                     style: Theme.of(context).textTheme.headlineMedium,
//                   ),
//                   SizedBox(height: AppTheme.space16),
//                   _buildCleaningSection(context),
//
//                   SizedBox(height: AppTheme.space24),
//
//                   // Quick Actions
//                   Text(
//                     'Quick Actions',
//                     style: Theme.of(context).textTheme.headlineMedium,
//                   ),
//                   SizedBox(height: AppTheme.space16),
//                   _buildQuickActions(context),
//
//                   SizedBox(height: AppTheme.space24),
//
//                   // Recent Activity
//                   _buildRecentActivity(context),
//
//                   SizedBox(height: AppTheme.space32),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       // Add unique heroTag to FloatingActionButton
//       floatingActionButton: FloatingActionButton.extended(
//         heroTag: 'dashboard_fab', // Add unique hero tag
//         onPressed: () {},
//         icon: Icon(Icons.add),
//         label: Text('New Plant'),
//       ),
//     );
//   }
//
//   // Quick Stats Grid
//   Widget _buildQuickStatsGrid(BuildContext context) {
//     return GridView.count(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       crossAxisCount: 2,
//       mainAxisSpacing: AppTheme.space16,
//       crossAxisSpacing: AppTheme.space16,
//       childAspectRatio: 1.3,
//       children: [
//         EnergyCard(
//           title: 'Current Power',
//           value: '45.2',
//           unit: 'kW',
//           icon: Icons.bolt,
//           color: AppTheme.energyProduction,
//         ),
//         EnergyCard(
//           title: "Today's Energy",
//           value: '320',
//           unit: 'kWh',
//           icon: Icons.wb_sunny,
//           color: AppTheme.primary,
//         ),
//         EnergyCard(
//           title: 'Total Plants',
//           value: '12',
//           unit: 'Active',
//           icon: Icons.solar_power,
//           color: AppTheme.accent,
//         ),
//         EnergyCard(
//           title: 'Monthly Savings',
//           value: '₹45k',
//           unit: 'Saved',
//           icon: Icons.savings,
//           color: AppTheme.success,
//         ),
//       ],
//     );
//   }
//
//   // Live Production Card with Progress
//   Widget _buildLiveProductionCard(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(AppTheme.space20),
//       decoration: BoxDecoration(
//         gradient: AppTheme.energyGradient,
//         borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
//         boxShadow: AppTheme.shadowLarge,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Live Production',
//                     style: Theme.of(
//                       context,
//                     ).textTheme.titleLarge?.copyWith(color: Colors.white),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     'Real-time monitoring',
//                     style: Theme.of(
//                       context,
//                     ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
//                   ),
//                 ],
//               ),
//               Container(
//                 padding: EdgeInsets.all(AppTheme.space12),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
//                 ),
//                 child: Icon(Icons.trending_up, color: Colors.white, size: 32),
//               ),
//             ],
//           ),
//           SizedBox(height: AppTheme.space24),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 '1,245',
//                 style: Theme.of(context).textTheme.displayLarge?.copyWith(
//                   color: Colors.white,
//                   fontSize: 48,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(width: AppTheme.space8),
//               Padding(
//                 padding: EdgeInsets.only(bottom: 12),
//                 child: Text(
//                   'kWh',
//                   style: Theme.of(
//                     context,
//                   ).textTheme.titleLarge?.copyWith(color: Colors.white70),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: AppTheme.space16),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(AppTheme.radiusCircular),
//             child: LinearProgressIndicator(
//               value: 0.73,
//               minHeight: 8,
//               backgroundColor: Colors.white.withOpacity(0.3),
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//             ),
//           ),
//           SizedBox(height: AppTheme.space8),
//           Text(
//             '73% of daily target achieved',
//             style: Theme.of(
//               context,
//             ).textTheme.bodySmall?.copyWith(color: Colors.white70),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Plant Status Cards
//   Widget _buildPlantStatusCards(BuildContext context) {
//     return Column(
//       children: [
//         PlantStatusCard(
//           plantName: 'Mumbai Solar Park',
//           location: 'Mumbai, Maharashtra',
//           capacity: '500 kW',
//           status: 'Operational',
//           efficiency: 94,
//           statusColor: AppTheme.success,
//         ),
//         SizedBox(height: AppTheme.space12),
//         PlantStatusCard(
//           plantName: 'Pune Industrial Plant',
//           location: 'Pune, Maharashtra',
//           capacity: '750 kW',
//           status: 'Maintenance',
//           efficiency: 0,
//           statusColor: AppTheme.warning,
//         ),
//         SizedBox(height: AppTheme.space12),
//         PlantStatusCard(
//           plantName: 'Nashik Rooftop',
//           location: 'Nashik, Maharashtra',
//           capacity: '250 kW',
//           status: 'Operational',
//           efficiency: 89,
//           statusColor: AppTheme.success,
//         ),
//       ],
//     );
//   }
//
//   // Cleaning Section
//   Widget _buildCleaningSection(BuildContext context) {
//     return Column(
//       children: [
//         CleaningCard(
//           title: 'Manual Cleaning',
//           subtitle: 'Next scheduled: Tomorrow',
//           icon: Icons.people,
//           color: AppTheme.secondary,
//           onTap: () {},
//         ),
//         SizedBox(height: AppTheme.space12),
//         CleaningCard(
//           title: 'Automatic Cleaning',
//           subtitle: 'MQTT Connected • 3 Robots Active',
//           icon: Icons.settings_remote,
//           color: AppTheme.cleaningActive,
//           onTap: () {},
//         ),
//         SizedBox(height: AppTheme.space12),
//         CleaningCard(
//           title: 'Inspection Report',
//           subtitle: 'Last inspection: 2 days ago',
//           icon: Icons.assessment,
//           color: AppTheme.accent,
//           onTap: () {},
//         ),
//       ],
//     );
//   }
//
//   // Quick Actions
//   Widget _buildQuickActions(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: GradientButton(
//             label: 'Start Cleaning',
//             icon: Icons.cleaning_services,
//             onPressed: () {},
//             gradient: AppTheme.successGradient,
//           ),
//         ),
//         SizedBox(width: AppTheme.space12),
//         Expanded(
//           child: GradientButton(
//             label: 'Schedule',
//             icon: Icons.calendar_today,
//             onPressed: () {},
//             gradient: AppTheme.skyGradient,
//           ),
//         ),
//       ],
//     );
//   }
//
//   // Recent Activity
//   Widget _buildRecentActivity(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(AppTheme.space20),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
//         boxShadow: AppTheme.shadowMedium,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Recent Activity',
//             style: Theme.of(context).textTheme.headlineSmall,
//           ),
//           SizedBox(height: AppTheme.space16),
//           _buildActivityItem(
//             context,
//             icon: Icons.check_circle,
//             title: 'Cleaning completed',
//             subtitle: 'Mumbai Solar Park • 2 hours ago',
//             color: AppTheme.success,
//           ),
//           _buildActivityItem(
//             context,
//             icon: Icons.build,
//             title: 'Maintenance started',
//             subtitle: 'Pune Industrial Plant • 5 hours ago',
//             color: AppTheme.warning,
//           ),
//           _buildActivityItem(
//             context,
//             icon: Icons.trending_up,
//             title: 'Record production achieved',
//             subtitle: 'Nashik Rooftop • Yesterday',
//             color: AppTheme.info,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildActivityItem(
//       BuildContext context, {
//         required IconData icon,
//         required String title,
//         required String subtitle,
//         required Color color,
//       }) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: AppTheme.space8),
//       child: Row(
//         children: [
//           Container(
//             padding: EdgeInsets.all(AppTheme.space8),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.15),
//               borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
//             ),
//             child: Icon(icon, color: color, size: 20),
//           ),
//           SizedBox(width: AppTheme.space12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title, style: Theme.of(context).textTheme.titleMedium),
//                 Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// // Energy Card Widget
// class EnergyCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final String unit;
//   final IconData icon;
//   final Color? color;
//
//   EnergyCard({
//     super.key,
//     required this.title,
//     required this.value,
//     required this.unit,
//     required this.icon,
//     this.color,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(AppTheme.space16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             color?.withOpacity(0.1) ?? AppTheme.primaryLight.withOpacity(0.1),
//             color?.withOpacity(0.05) ?? AppTheme.primaryLight.withOpacity(0.05),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
//         border: Border.all(
//           color: (color ?? AppTheme.primary).withOpacity(0.3),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   title,
//                   style: Theme.of(context).textTheme.titleSmall,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               SizedBox(width: 8),
//               Icon(icon, color: color ?? AppTheme.primary, size: 24),
//             ],
//           ),
//           SizedBox(height: AppTheme.space12),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Flexible(
//                 child: Text(
//                   value,
//                   style: Theme.of(context).textTheme.displaySmall?.copyWith(
//                     color: color ?? AppTheme.primary,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 28,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               SizedBox(width: AppTheme.space4),
//               Padding(
//                 padding: EdgeInsets.only(bottom: 4),
//                 child: Text(
//                   unit,
//                   style: Theme.of(context).textTheme.bodyMedium,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Status Badge
// class StatusBadge extends StatelessWidget {
//   final String label;
//   final Color color;
//   final IconData? icon;
//
//   StatusBadge({super.key, required this.label, required this.color, this.icon});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: AppTheme.space12,
//         vertical: AppTheme.space8,
//       ),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.15),
//         borderRadius: BorderRadius.circular(AppTheme.radiusCircular),
//         border: Border.all(color: color.withOpacity(0.3), width: 1),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (icon != null) ...[
//             Icon(icon, size: 14, color: color),
//             SizedBox(width: AppTheme.space4),
//           ],
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//               color: color,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Gradient Button
// class GradientButton extends StatelessWidget {
//   final String label;
//   final VoidCallback onPressed;
//   final Gradient? gradient;
//   final IconData? icon;
//
//   GradientButton({
//     super.key,
//     required this.label,
//     required this.onPressed,
//     this.gradient,
//     this.icon,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: gradient ?? AppTheme.primaryGradient,
//         borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
//         boxShadow: AppTheme.shadowMedium,
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onPressed,
//           borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: AppTheme.space20,
//               vertical: AppTheme.space16,
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 if (icon != null) ...[
//                   Icon(icon, color: Colors.white, size: 20),
//                   SizedBox(width: AppTheme.space8),
//                 ],
//                 Text(
//                   label,
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                     letterSpacing: 0.5,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // Plant Status Card
// class PlantStatusCard extends StatelessWidget {
//   final String plantName;
//   final String location;
//   final String capacity;
//   final String status;
//   final int efficiency;
//   final Color statusColor;
//
//   PlantStatusCard({
//     super.key,
//     required this.plantName,
//     required this.location,
//     required this.capacity,
//     required this.status,
//     required this.efficiency,
//     required this.statusColor,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(AppTheme.space16),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
//         boxShadow: AppTheme.shadowSmall,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       plantName,
//                       style: Theme.of(context).textTheme.titleLarge,
//                     ),
//                     SizedBox(height: 4),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.location_on,
//                           size: 14,
//                           color: Theme.of(context).textTheme.bodySmall?.color,
//                         ),
//                         SizedBox(width: 4),
//                         Expanded(
//                           child: Text(
//                             location,
//                             style: Theme.of(context).textTheme.bodySmall,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               StatusBadge(label: status, color: statusColor),
//             ],
//           ),
//           SizedBox(height: AppTheme.space16),
//           Row(
//             children: [
//               Expanded(
//                 child: _buildInfoChip(
//                   context,
//                   icon: Icons.bolt,
//                   label: capacity,
//                 ),
//               ),
//               SizedBox(width: AppTheme.space8),
//               Expanded(
//                 child: _buildInfoChip(
//                   context,
//                   icon: Icons.percent,
//                   label: efficiency > 0 ? '$efficiency% Eff.' : 'Offline',
//                 ),
//               ),
//             ],
//           ),
//           if (efficiency > 0) ...[
//             SizedBox(height: AppTheme.space12),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(AppTheme.radiusCircular),
//               child: LinearProgressIndicator(
//                 value: efficiency / 100,
//                 minHeight: 6,
//                 backgroundColor: statusColor.withOpacity(0.2),
//                 valueColor: AlwaysStoppedAnimation<Color>(statusColor),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInfoChip(
//       BuildContext context, {
//         required IconData icon,
//         required String label,
//       }) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: AppTheme.space12,
//         vertical: AppTheme.space8,
//       ),
//       decoration: BoxDecoration(
//         color: Theme.of(context).brightness == Brightness.light
//             ? AppTheme.surfaceVariant
//             : Color(0xFF2C2C2C),
//         borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 16, color: AppTheme.primary),
//           SizedBox(width: 6),
//           Flexible(
//             child: Text(
//               label,
//               style: Theme.of(
//                 context,
//               ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Cleaning Card
// class CleaningCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final IconData icon;
//   final Color color;
//   final VoidCallback onTap;
//
//   CleaningCard({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.icon,
//     required this.color,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
//         boxShadow: AppTheme.shadowSmall,
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
//           child: Padding(
//             padding: EdgeInsets.all(AppTheme.space16),
//             child: Row(
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(AppTheme.space12),
//                   decoration: BoxDecoration(
//                     color: color.withOpacity(0.15),
//                     borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
//                   ),
//                   child: Icon(icon, color: color, size: 24),
//                 ),
//                 SizedBox(width: AppTheme.space16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         title,
//                         style: Theme.of(context).textTheme.titleMedium,
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         subtitle,
//                         style: Theme.of(context).textTheme.bodySmall,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Icon(
//                   Icons.arrow_forward_ios,
//                   size: 16,
//                   color: Theme.of(context).textTheme.bodySmall?.color,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../core/Theme/app_theme.dart';
import '../../../core/widgets/theme_toggle.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedPlantIndex = 0;
  bool _isMonitoring = false;

  @override
  Widget build(BuildContext context) {
    // Use Theme.of(context) directly - it rebuilds when theme changes
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Modern App Bar
          SliverAppBar(
            expandedHeight: 250,
            floating: false,
            pinned: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            actions: [
              ThemeToggleButton(),
              SizedBox(width: AppTheme.space8),
              IconButton(
                icon: Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
              SizedBox(width: AppTheme.space8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppTheme.radiusXLarge),
                    bottomRight: Radius.circular(AppTheme.radiusXLarge),
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      AppTheme.space24,
                      60,
                      AppTheme.space24,
                      AppTheme.space24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppTheme.space12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.success.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppTheme.success.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppTheme.success,
                                    ),
                                  ),
                                  SizedBox(width: AppTheme.space8),
                                  Text(
                                    'Live',
                                    style: textTheme.labelMedium?.copyWith(
                                      color: AppTheme.success,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppTheme.space16),
                        Text(
                          'Solar Dashboard',
                          style: textTheme.displaySmall,
                        ),
                        SizedBox(height: AppTheme.space8),
                        Text(
                          'Monitor your solar energy in real-time',
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: AnimationLimiter(
              child: Column(
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 375),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(child: widget),
                  ),
                  children: [
                    SizedBox(height: AppTheme.space24),
                    _buildStatsCards(),
                    SizedBox(height: AppTheme.space24),
                    _buildModernPlantSelector(),
                    SizedBox(height: AppTheme.space24),
                    _buildEnergyFlowCard(),
                    SizedBox(height: AppTheme.space24),
                    _buildQuickActions(),
                    SizedBox(height: AppTheme.space24),
                    _buildFeaturesGrid(),
                    SizedBox(height: AppTheme.space24),
                    _buildModernSocialProof(),
                    SizedBox(height: AppTheme.space24),
                    _buildModernCTA(),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final stats = [
      {
        'icon': Icons.bolt,
        'value': '45.2',
        'unit': 'kW',
        'label': 'Power',
        'color': AppTheme.primary
      },
      {
        'icon': Icons.eco,
        'value': '1.2',
        'unit': 'tons',
        'label': 'CO₂ Saved',
        'color': AppTheme.success
      },
      {
        'icon': Icons.savings,
        'value': '₹8.5',
        'unit': 'K',
        'label': 'Saved',
        'color': AppTheme.warning
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.space16),
      child: Row(
        children: stats.map((stat) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: AppTheme.space4),
              padding: EdgeInsets.all(AppTheme.space16),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                boxShadow: theme.brightness == Brightness.dark
                    ? AppTheme.darkShadowSmall
                    : AppTheme.shadowSmall,
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: (stat['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                    ),
                    child: Icon(
                      stat['icon'] as IconData,
                      color: stat['color'] as Color,
                      size: 24,
                    ),
                  ),
                  SizedBox(height: AppTheme.space12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        stat['value'] as String,
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 2),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Text(
                          stat['unit'] as String,
                          style: textTheme.labelSmall,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppTheme.space4),
                  Text(
                    stat['label'] as String,
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildModernPlantSelector() {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final plants = [
      {
        'name': 'Mumbai Solar Park',
        'power': '45.2 kW',
        'efficiency': 94,
        'icon': Icons.apartment
      },
      {
        'name': 'Pune Industrial',
        'power': '38.7 kW',
        'efficiency': 89,
        'icon': Icons.factory
      },
      {
        'name': 'Nashik Rooftop',
        'power': '22.5 kW',
        'efficiency': 91,
        'icon': Icons.home
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppTheme.space20),
          child: Text(
            'Your Plants',
            style: textTheme.headlineMedium,
          ),
        ),
        SizedBox(height: AppTheme.space16),
        Container(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: AppTheme.space16),
            itemCount: plants.length,
            itemBuilder: (context, index) {
              final isSelected = index == _selectedPlantIndex;
              return GestureDetector(
                onTap: () => setState(() => _selectedPlantIndex = index),
                child: Container(
                  width: 280,
                  margin: EdgeInsets.only(right: AppTheme.space12),
                  padding: EdgeInsets.all(AppTheme.space20),
                  decoration: BoxDecoration(
                    color: isSelected ? colorScheme.primary : colorScheme.surface,
                    borderRadius: BorderRadius.circular(AppTheme.radiusXLarge),
                    border: isSelected
                        ? null
                        : Border.all(color: colorScheme.outline),
                    boxShadow: isSelected
                        ? [
                      BoxShadow(
                        color: colorScheme.primary.withOpacity(0.3),
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ]
                        : (theme.brightness == Brightness.dark
                        ? AppTheme.darkShadowSmall
                        : AppTheme.shadowSmall),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(AppTheme.space12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white.withOpacity(0.2)
                                  : colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                            ),
                            child: Icon(
                              plants[index]['icon'] as IconData,
                              color: isSelected ? Colors.white : colorScheme.primary,
                              size: 28,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppTheme.space12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white.withOpacity(0.2)
                                  : AppTheme.success.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                            ),
                            child: Text(
                              '${plants[index]['efficiency']}%',
                              style: textTheme.labelMedium?.copyWith(
                                color: isSelected ? Colors.white : AppTheme.success,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Text(
                        plants[index]['name'] as String,
                        style: textTheme.titleLarge?.copyWith(
                          color: isSelected ? Colors.white : null,
                        ),
                      ),
                      SizedBox(height: AppTheme.space8),
                      Row(
                        children: [
                          Icon(
                            Icons.bolt,
                            size: 16,
                            color: isSelected
                                ? Colors.white70
                                : textTheme.bodyMedium?.color?.withOpacity(0.7),
                          ),
                          SizedBox(width: 4),
                          Text(
                            plants[index]['power'] as String,
                            style: textTheme.bodyMedium?.copyWith(
                              color: isSelected ? Colors.white70 : null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEnergyFlowCard() {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.space16),
      child: Container(
        padding: EdgeInsets.all(AppTheme.space24),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusXLarge),
          boxShadow: theme.brightness == Brightness.dark
              ? AppTheme.darkShadowSmall
              : AppTheme.shadowSmall,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Energy Flow',
                  style: textTheme.titleLarge,
                ),
                Switch.adaptive(
                  value: _isMonitoring,
                  onChanged: (value) => setState(() => _isMonitoring = value),
                  activeColor: AppTheme.success,
                ),
              ],
            ),
            SizedBox(height: AppTheme.space32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFlowNode('Solar', Icons.wb_sunny, AppTheme.warning),
                Icon(Icons.arrow_forward, color: colorScheme.outline),
                _buildFlowNode('Battery', Icons.battery_charging_full, colorScheme.primary),
                Icon(Icons.arrow_forward, color: colorScheme.outline),
                _buildFlowNode('Home', Icons.home, AppTheme.success),
              ],
            ),
            SizedBox(height: AppTheme.space32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Production',
                      style: textTheme.titleMedium,
                    ),
                    Text(
                      '45.2 kW',
                      style: textTheme.titleLarge?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppTheme.space12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: 0.75,
                    minHeight: 8,
                    backgroundColor: colorScheme.outline.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation(colorScheme.primary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlowNode(String label, IconData icon, Color color) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.3), width: 2),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(height: AppTheme.space8),
        Text(
          label,
          style: textTheme.labelMedium,
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final actions = [
      {
        'icon': Icons.cleaning_services,
        'title': 'Start\nCleaning',
        'color': AppTheme.success
      },
      {
        'icon': Icons.play_circle_outline,
        'title': 'Auto\nMode',
        'color': colorScheme.primary
      },
      {'icon': Icons.schedule, 'title': 'Schedule', 'color': AppTheme.warning},
      {'icon': Icons.analytics, 'title': 'Reports', 'color': AppTheme.accent},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppTheme.space20),
          child: Text(
            'Quick Actions',
            style: textTheme.headlineMedium,
          ),
        ),
        SizedBox(height: AppTheme.space16),
        Container(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: AppTheme.space16),
            itemCount: actions.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  width: 100,
                  margin: EdgeInsets.only(right: AppTheme.space12),
                  padding: EdgeInsets.all(AppTheme.space16),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                    border: Border.all(color: colorScheme.outline),
                    boxShadow: theme.brightness == Brightness.dark
                        ? AppTheme.darkShadowSmall
                        : AppTheme.shadowSmall,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: (actions[index]['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                        ),
                        child: Icon(
                          actions[index]['icon'] as IconData,
                          color: actions[index]['color'] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(height: AppTheme.space8),
                      Text(
                        actions[index]['title'] as String,
                        textAlign: TextAlign.center,
                        style: textTheme.labelSmall?.copyWith(
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesGrid() {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final features = [
      {
        'icon': Icons.phone_android,
        'title': 'Remote Control',
        'desc': 'Control from anywhere',
        'color': colorScheme.primary,
      },
      {
        'icon': Icons.notifications_active,
        'title': 'Smart Alerts',
        'desc': 'Get instant notifications',
        'color': AppTheme.warning,
      },
      {
        'icon': Icons.eco,
        'title': 'Eco Impact',
        'desc': 'Track carbon reduction',
        'color': AppTheme.success,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppTheme.space20),
          child: Text(
            'Features',
            style: textTheme.headlineMedium,
          ),
        ),
        SizedBox(height: AppTheme.space16),
        ...features.map((feature) => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppTheme.space16,
            vertical: 6,
          ),
          child: Container(
            padding: EdgeInsets.all(AppTheme.space20),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
              border: Border.all(color: colorScheme.outline),
              boxShadow: theme.brightness == Brightness.dark
                  ? AppTheme.darkShadowSmall
                  : AppTheme.shadowSmall,
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: (feature['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                  ),
                  child: Icon(
                    feature['icon'] as IconData,
                    color: feature['color'] as Color,
                    size: 28,
                  ),
                ),
                SizedBox(width: AppTheme.space16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        feature['title'] as String,
                        style: textTheme.titleMedium,
                      ),
                      SizedBox(height: 4),
                      Text(
                        feature['desc'] as String,
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: colorScheme.outline,
                ),
              ],
            ),
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildModernSocialProof() {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.space16),
      child: Container(
        padding: EdgeInsets.all(AppTheme.space24),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusXLarge),
          border: Border.all(color: colorScheme.outline),
          boxShadow: theme.brightness == Brightness.dark
              ? AppTheme.darkShadowSmall
              : AppTheme.shadowSmall,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('500+', 'Plants', textTheme, colorScheme),
            Container(width: 1, height: 40, color: colorScheme.outline),
            _buildStatItem('10K+', 'Users', textTheme, colorScheme),
            Container(width: 1, height: 40, color: colorScheme.outline),
            _buildStatItem('₹2Cr+', 'Saved', textTheme, colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, TextTheme textTheme, ColorScheme colorScheme) {
    return Column(
      children: [
        Text(
          value,
          style: textTheme.headlineMedium?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildModernCTA() {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.space16),
      child: Container(
        padding: EdgeInsets.all(AppTheme.space32),
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withOpacity(0.3),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              '🚀',
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: AppTheme.space16),
            Text(
              'Ready to Get Started?',
              style: textTheme.headlineMedium?.copyWith(
                color: colorScheme.onPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppTheme.space8),
            Text(
              'Join thousands of users saving energy',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onPrimary.withOpacity(0.9),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppTheme.space24),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.onPrimary,
                foregroundColor: colorScheme.primary,
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.space32,
                  vertical: AppTheme.space16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Create Free Account',
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  SizedBox(width: AppTheme.space8),
                  Icon(Icons.arrow_forward, size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}