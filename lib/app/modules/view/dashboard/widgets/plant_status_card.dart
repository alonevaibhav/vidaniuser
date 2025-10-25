// // lib/app/modules/dashboard/widgets/plant_status_card.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
// import 'package:gap/gap.dart';
// import '../../../../core/Theme/app_theme.dart';
//
// class PlantStatusCard extends StatelessWidget {
//   const PlantStatusCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(AppTheme.space16),
//       decoration: BoxDecoration(
//         color: AppTheme.surface,
//         borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
//         boxShadow: AppTheme.shadowSmall,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Active Plants',
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w600,
//                   color: AppTheme.textPrimary,
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: Text('View All'),
//               ),
//             ],
//           ),
//           Gap(AppTheme.space12),
//           _buildPlantItem(
//             name: 'Rooftop Solar A',
//             location: 'Building 1, Pune',
//             capacity: '30 kW',
//             status: 'Active',
//             efficiency: 92,
//             isDemo: true,
//           ),
//           Gap(AppTheme.space12),
//           _buildPlantItem(
//             name: 'Ground Mount B',
//             location: 'Plot 5, Pune',
//             capacity: '50 kW',
//             status: 'Active',
//             efficiency: 88,
//             isDemo: true,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPlantItem({
//     required String name,
//     required String location,
//     required String capacity,
//     required String status,
//     required int efficiency,
//     required bool isDemo,
//   }) {
//     return Container(
//       padding: EdgeInsets.all(AppTheme.space12),
//       decoration: BoxDecoration(
//         color: AppTheme.surfaceVariant,
//         borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 48.w,
//             height: 48.w,
//             decoration: BoxDecoration(
//               gradient: AppTheme.primaryGradient,
//               borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
//             ),
//             child: Icon(
//               PhosphorIcons.solarPanel(PhosphorIconsStyle.fill),
//               color: Colors.white,
//               size: 24.sp,
//             ),
//           ),
//           Gap(AppTheme.space12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         name,
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w600,
//                           color: AppTheme.textPrimary,
//                         ),
//                       ),
//                     ),
//                     if (isDemo)
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 6.w,
//                           vertical: 2.h,
//                         ),
//                         decoration: BoxDecoration(
//                           color: AppTheme.demoMode.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(4.r),
//                         ),
//                         child: Text(
//                           'DEMO',
//                           style: TextStyle(
//                             fontSize: 9.sp,
//                             fontWeight: FontWeight.bold,
//                             color: AppTheme.demoMode,
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//                 Gap(4.h),
//                 Text(
//                   location,
//                   style: TextStyle(
//                     fontSize: 12.sp,
//                     color: AppTheme.textSecondary,
//                   ),
//                 ),
//                 Gap(8.h),
//                 Row(
//                   children: [
//                     Icon(
//                       PhosphorIcons.lightning(PhosphorIconsStyle.fill),
//                       size: 12.sp,
//                       color: AppTheme.success,
//                     ),
//                     Gap(4.w),
//                     Text(
//                       capacity,
//                       style: TextStyle(
//                         fontSize: 11.sp,
//                         color: AppTheme.textSecondary,
//                       ),
//                     ),
//                     Gap(12.w),
//                     Text(
//                       '•',
//                       style: TextStyle(color: AppTheme.textTertiary),
//                     ),
//                     Gap(12.w),
//                     Text(
//                       '$efficiency% Efficiency',
//                       style: TextStyle(
//                         fontSize: 11.sp,
//                         color: AppTheme.success,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // lib/app/modules/dashboard/widgets/quick_actions.dart
// class QuickActions extends StatelessWidget {
//   const QuickActions({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Quick Actions',
//           style: TextStyle(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.w600,
//             color: AppTheme.textPrimary,
//           ),
//         ),
//         Gap(AppTheme.space16),
//         Row(
//           children: [
//             Expanded(
//               child: _buildActionCard(
//                 icon: PhosphorIcons.sparkle(PhosphorIconsStyle.fill),
//                 label: 'Start Cleaning',
//                 color: AppTheme.cleaningActive,
//               ),
//             ),
//             Gap(AppTheme.space12),
//             Expanded(
//               child: _buildActionCard(
//                 icon: PhosphorIcons.calendar(PhosphorIconsStyle.fill),
//                 label: 'Schedule',
//                 color: AppTheme.info,
//               ),
//             ),
//           ],
//         ),
//         Gap(AppTheme.space12),
//         Row(
//           children: [
//             Expanded(
//               child: _buildActionCard(
//                 icon: PhosphorIcons.chartLine(PhosphorIconsStyle.fill),
//                 label: 'Analytics',
//                 color: AppTheme.primary,
//               ),
//             ),
//             Gap(AppTheme.space12),
//             Expanded(
//               child: _buildActionCard(
//                 icon: PhosphorIcons.wrench(PhosphorIconsStyle.fill),
//                 label: 'Maintenance',
//                 color: AppTheme.warning,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildActionCard({
//     required IconData icon,
//     required String label,
//     required Color color,
//   }) {
//     return InkWell(
//       onTap: () {},
//       borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
//       child: Container(
//         padding: EdgeInsets.all(AppTheme.space16),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
//           border: Border.all(
//             color: color.withOpacity(0.3),
//             width: 1.w,
//           ),
//         ),
//         child: Column(
//           children: [
//             Icon(
//               icon,
//               color: color,
//               size: 32.sp,
//             ),
//             Gap(AppTheme.space8),
//             Text(
//               label,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.w600,
//                 color: AppTheme.textPrimary,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // lib/app/modules/dashboard/widgets/features_showcase.dart
// class FeaturesShowcase extends StatelessWidget {
//   const FeaturesShowcase({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(AppTheme.space20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             AppTheme.primary.withOpacity(0.05),
//             AppTheme.secondary.withOpacity(0.05),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
//         border: Border.all(
//           color: AppTheme.primary.withOpacity(0.2),
//           width: 1.w,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(10.w),
//                 decoration: BoxDecoration(
//                   gradient: AppTheme.primaryGradient,
//                   borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
//                 ),
//                 child: Icon(
//                   PhosphorIcons.star(PhosphorIconsStyle.fill),
//                   color: Colors.white,
//                   size: 20.sp,
//                 ),
//               ),
//               Gap(AppTheme.space12),
//               Expanded(
//                 child: Text(
//                   'Premium Features',
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                     fontWeight: FontWeight.bold,
//                     color: AppTheme.textPrimary,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Gap(AppTheme.space16),
//           _buildFeature(
//             icon: PhosphorIcons.cloudArrowUp(PhosphorIconsStyle.fill),
//             title: 'Cloud Sync',
//             description: 'Access your data from anywhere',
//           ),
//           Gap(AppTheme.space12),
//           _buildFeature(
//             icon: PhosphorIcons.bellRinging(PhosphorIconsStyle.fill),
//             title: 'Smart Alerts',
//             description: 'Get notified of issues instantly',
//           ),
//           Gap(AppTheme.space12),
//           _buildFeature(
//             icon: PhosphorIcons.robot(PhosphorIconsStyle.fill),
//             title: 'Auto Cleaning',
//             description: 'Schedule automatic cleaning via MQTT',
//           ),
//           Gap(AppTheme.space12),
//           _buildFeature(
//             icon: PhosphorIcons.chartLineUp(PhosphorIconsStyle.fill),
//             title: 'Advanced Analytics',
//             description: 'Detailed reports and insights',
//           ),
//           Gap(AppTheme.space16),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppTheme.primary,
//                 padding: EdgeInsets.symmetric(vertical: AppTheme.space16),
//               ),
//               child: Text(
//                 'Unlock All Features',
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFeature({
//     required IconData icon,
//     required String title,
//     required String description,
//   }) {
//     return Row(
//       children: [
//         Container(
//           padding: EdgeInsets.all(8.w),
//           decoration: BoxDecoration(
//             color: AppTheme.primary.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8.r),
//           ),
//           child: Icon(
//             icon,
//             color: AppTheme.primary,
//             size: 18.sp,
//           ),
//         ),
//         Gap(AppTheme.space12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w600,
//                   color: AppTheme.textPrimary,
//                 ),
//               ),
//               Text(
//                 description,
//                 style: TextStyle(
//                   fontSize: 12.sp,
//                   color: AppTheme.textSecondary,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }