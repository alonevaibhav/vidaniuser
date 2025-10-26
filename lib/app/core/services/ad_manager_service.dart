// // lib/app/core/services/ad_manager.dart
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
//
// enum AdType {
//   login,
//   contactUs,
//   rateApp,
//   upgradePlan,
// }
//
// class AdManager extends GetxService {
//   static AdManager get to => Get.find();
//
//   final _storage = GetStorage();
//
//   // Ad configuration - UPDATED: More aggressive for login
//   static const int minSessionsBeforeFirstAd = 1; // Changed from 2 to 1
//   static const int minScreenVisitsBeforeAd = 0; // Changed from 4 to 0
//   static const int minMinutesBetweenAds = 120; // 2 hours
//   static const int maxAdsPerDay = 3;
//   static const int minInteractionsBeforeAd = 0; // Changed from 3 to 0
//
//   // Tracking observables
//   final sessionCount = 0.obs;
//   final screenVisitCount = 0.obs;
//   final interactionCount = 0.obs;
//   final adsShownToday = 0.obs;
//
//   Future<AdManager> init() async {
//     await _loadAdData();
//     _incrementSessionCount();
//     _checkDailyReset();
//     return this;
//   }
//
//   Future<void> _loadAdData() async {
//     sessionCount.value = _storage.read('session_count') ?? 0;
//     screenVisitCount.value = _storage.read('screen_visit_count') ?? 0;
//     interactionCount.value = _storage.read('interaction_count') ?? 0;
//     adsShownToday.value = _storage.read('ads_shown_today') ?? 0;
//   }
//
//   void _checkDailyReset() {
//     final lastResetDate = _storage.read<String>('last_reset_date');
//     final today = DateTime.now().toIso8601String().split('T')[0];
//
//     if (lastResetDate != today) {
//       adsShownToday.value = 0;
//       _storage.write('ads_shown_today', 0);
//       _storage.write('last_reset_date', today);
//     }
//   }
//
//   void _incrementSessionCount() {
//     sessionCount.value++;
//     _storage.write('session_count', sessionCount.value);
//   }
//
//   void incrementScreenVisit() {
//     screenVisitCount.value++;
//     _storage.write('screen_visit_count', screenVisitCount.value);
//   }
//
//   void incrementInteraction() {
//     interactionCount.value++;
//     _storage.write('interaction_count', interactionCount.value);
//   }
//
//   Future<bool> shouldShowAd({AdType? preferredType}) async {
//     // SPECIAL CASE: Login ad can show immediately on first session
//     if (preferredType == AdType.login && !_isUserLoggedIn()) {
//       // Allow login ad to bypass most restrictions
//       if (adsShownToday.value >= maxAdsPerDay) {
//         return false;
//       }
//
//       // Still check time between ads if not first ad ever
//       final lastAdTimestamp = _storage.read<int>('last_ad_timestamp');
//       if (lastAdTimestamp != null) {
//         final lastAdTime = DateTime.fromMillisecondsSinceEpoch(lastAdTimestamp);
//         final minutesSinceLastAd = DateTime.now().difference(lastAdTime).inMinutes;
//
//         if (minutesSinceLastAd < minMinutesBetweenAds) {
//           return false;
//         }
//       }
//
//       return true; // Login ad can show immediately
//     }
//
//     // Don't show login ad if already logged in
//     if (preferredType == AdType.login && _isUserLoggedIn()) {
//       return false;
//     }
//
//     // Don't show rate app if already rated
//     if (preferredType == AdType.rateApp && _hasUserRated()) {
//       return false;
//     }
//
//     // Check daily limit
//     if (adsShownToday.value >= maxAdsPerDay) {
//       return false;
//     }
//
//     // First ad only after minimum sessions
//     if (sessionCount.value < minSessionsBeforeFirstAd) {
//       return false;
//     }
//
//     // Check minimum screen visits
//     if (screenVisitCount.value < minScreenVisitsBeforeAd) {
//       return false;
//     }
//
//     // Check minimum interactions (user is actually using the app)
//     if (interactionCount.value < minInteractionsBeforeAd) {
//       return false;
//     }
//
//     // Check time between ads
//     final lastAdTimestamp = _storage.read<int>('last_ad_timestamp');
//     if (lastAdTimestamp != null) {
//       final lastAdTime = DateTime.fromMillisecondsSinceEpoch(lastAdTimestamp);
//       final minutesSinceLastAd = DateTime.now().difference(lastAdTime).inMinutes;
//
//       if (minutesSinceLastAd < minMinutesBetweenAds) {
//         return false;
//       }
//     }
//
//     return true;
//   }
//
//   Future<AdType?> getNextAdToShow() async {
//     // PRIORITY: Show login ad immediately if user not logged in
//     if (!_isUserLoggedIn()) {
//       if (await shouldShowAd(preferredType: AdType.login)) {
//         return AdType.login;
//       }
//     }
//
//     if (!await shouldShowAd()) return null;
//
//     if (sessionCount.value >= 10 && !_hasUserRated()) {
//       if (await shouldShowAd(preferredType: AdType.rateApp)) {
//         return AdType.rateApp;
//       }
//     }
//
//     // Rotate between other ad types
//     final lastShownType = _storage.read<String>('last_ad_type');
//
//     if (lastShownType != AdType.contactUs.name) {
//       return AdType.contactUs;
//     } else if (lastShownType != AdType.upgradePlan.name && _isUserLoggedIn()) {
//       return AdType.upgradePlan;
//     }
//
//     return AdType.contactUs;
//   }
//
//   Future<void> markAdAsShown(AdType type) async {
//     final now = DateTime.now();
//     await _storage.write('last_ad_timestamp', now.millisecondsSinceEpoch);
//     await _storage.write('last_ad_type', type.name);
//
//     adsShownToday.value++;
//     await _storage.write('ads_shown_today', adsShownToday.value);
//
//     // Reset interaction count to require fresh engagement
//     interactionCount.value = 0;
//     await _storage.write('interaction_count', 0);
//   }
//
//   Future<void> dismissAd(AdType type) async {
//     // Track dismissals to reduce frequency
//     final dismissCount = _storage.read<int>('${type.name}_dismiss_count') ?? 0;
//     await _storage.write('${type.name}_dismiss_count', dismissCount + 1);
//
//     // If dismissed too many times, delay next show
//     if (dismissCount >= 3) {
//       final delayUntil = DateTime.now().add(const Duration(days: 7));
//       await _storage.write('${type.name}_delay_until', delayUntil.millisecondsSinceEpoch);
//     }
//   }
//
//   bool _isUserLoggedIn() {
//     return _storage.read<bool>('is_logged_in') ?? false;
//   }
//
//   bool _hasUserRated() {
//     return _storage.read<bool>('has_rated_app') ?? false;
//   }
//
//   Future<void> markUserAsLoggedIn() async {
//     await _storage.write('is_logged_in', true);
//   }
//
//   Future<void> markAppAsRated() async {
//     await _storage.write('has_rated_app', true);
//   }
//
//   // Reset for testing purposes
//   Future<void> resetAdData() async {
//     await _storage.remove('last_ad_timestamp');
//     await _storage.remove('ads_shown_today');
//     await _storage.remove('interaction_count');
//     adsShownToday.value = 0;
//     interactionCount.value = 0;
//   }
// }
//
//
//
// class FloatingAdCard extends StatefulWidget {
//   final AdType adType;
//   final VoidCallback onDismiss;
//
//   const FloatingAdCard({
//     super.key,
//     required this.adType,
//     required this.onDismiss,
//   });
//
//   @override
//   State<FloatingAdCard> createState() => _FloatingAdCardState();
// }
//
// class _FloatingAdCardState extends State<FloatingAdCard>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<Offset> _slideAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 400),
//       vsync: this,
//     );
//
//     _scaleAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeOutBack,
//     );
//
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 1),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeOutCubic,
//     ));
//
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _handleDismiss() async {
//     await _controller.reverse();
//     await AdManager.to.dismissAd(widget.adType);
//     widget.onDismiss();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final adContent = _getAdContent();
//
//     return SlideTransition(
//       position: _slideAnimation,
//       child: ScaleTransition(
//         scale: _scaleAnimation,
//         child: Container(
//           margin: EdgeInsets.all(16.w),
//           padding: EdgeInsets.all(20.w),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 colorScheme.primaryContainer,
//                 colorScheme.secondaryContainer,
//               ],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(20.r),
//             boxShadow: [
//               BoxShadow(
//                 color: colorScheme.primary.withOpacity(0.3),
//                 blurRadius: 20.r,
//                 offset: Offset(0, 10.h),
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(12.w),
//                     decoration: BoxDecoration(
//                       color: colorScheme.primary.withOpacity(0.2),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       adContent.icon,
//                       color: colorScheme.primary,
//                       size: 28.sp,
//                     ),
//                   ),
//                   SizedBox(width: 16.w),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           adContent.title,
//                           style: TextStyle(
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.bold,
//                             color: colorScheme.onPrimaryContainer,
//                           ),
//                         ),
//                         SizedBox(height: 4.h),
//                         Text(
//                           adContent.description,
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             color: colorScheme.onPrimaryContainer.withOpacity(0.8),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: _handleDismiss,
//                     icon: Icon(
//                       PhosphorIcons.x(),
//                       color: colorScheme.onPrimaryContainer.withOpacity(0.6),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16.h),
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: _handleDismiss,
//                       style: OutlinedButton.styleFrom(
//                         side: BorderSide(color: colorScheme.primary),
//                         foregroundColor: colorScheme.primary,
//                         padding: EdgeInsets.symmetric(vertical: 12.h),
//                       ),
//                       child: Text('Maybe Later'),
//                     ),
//                   ),
//                   SizedBox(width: 12.w),
//                   Expanded(
//                     flex: 2,
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         await _controller.reverse();
//                         await AdManager.to.markAdAsShown(widget.adType);
//                         widget.onDismiss();
//                         adContent.onAction();
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: colorScheme.primary,
//                         foregroundColor: colorScheme.onPrimary,
//                         padding: EdgeInsets.symmetric(vertical: 12.h),
//                       ),
//                       child: Text(adContent.actionText),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   _AdContent _getAdContent() {
//     switch (widget.adType) {
//       case AdType.login:
//         return _AdContent(
//           icon: PhosphorIcons.userCirclePlus(PhosphorIconsStyle.fill),
//           title: 'Unlock Full Features!',
//           description: 'Sign in to access real-time monitoring, alerts, and more.',
//           actionText: 'Sign In Now',
//           onAction: () => Get.toNamed('/login'),
//         );
//       case AdType.contactUs:
//         return _AdContent(
//           icon: PhosphorIcons.chatCircleDots(PhosphorIconsStyle.fill),
//           title: 'Need Help?',
//           description: 'Our solar experts are ready to assist you 24/7.',
//           actionText: 'Contact Us',
//           onAction: () => Get.toNamed('/contact'),
//         );
//       case AdType.rateApp:
//         return _AdContent(
//           icon: PhosphorIcons.star(PhosphorIconsStyle.fill),
//           title: 'Enjoying the App?',
//           description: 'Rate us 5 stars and help others discover great solar management!',
//           actionText: 'Rate Now',
//           onAction: () async {
//             await AdManager.to.markAppAsRated();
//             // Open app store rating
//           },
//         );
//       case AdType.upgradePlan:
//         return _AdContent(
//           icon: PhosphorIcons.crownSimple(PhosphorIconsStyle.fill),
//           title: 'Upgrade to Premium',
//           description: 'Get advanced analytics, priority support, and unlimited plants.',
//           actionText: 'View Plans',
//           onAction: () => Get.toNamed('/plans'),
//         );
//     }
//   }
// }
//
// class _AdContent {
//   final IconData icon;
//   final String title;
//   final String description;
//   final String actionText;
//   final VoidCallback onAction;
//
//   _AdContent({
//     required this.icon,
//     required this.title,
//     required this.description,
//     required this.actionText,
//     required this.onAction,
//   });
// }
//
//
// class AdOverlayManager {
//   static OverlayEntry? _currentOverlay;
//
//   static Future<void> tryShowAd() async {
//     if (_currentOverlay != null) return; // Already showing an ad
//
//     final adType = await AdManager.to.getNextAdToShow();
//     if (adType == null) return;
//
//     _showOverlay(adType);
//   }
//
//   static void _showOverlay(AdType adType) {
//     _currentOverlay = OverlayEntry(
//       builder: (context) => Positioned(
//         bottom: 80,
//         left: 0,
//         right: 0,
//         child: Material(
//           color: Colors.transparent,
//           child: FloatingAdCard(
//             adType: adType,
//             onDismiss: _dismissOverlay,
//           ),
//         ),
//       ),
//     );
//
//     final overlay = Get.overlayContext?.findRenderObject();
//     if (overlay != null) {
//       Overlay.of(Get.overlayContext!).insert(_currentOverlay!);
//     }
//   }
//
//   static void _dismissOverlay() {
//     _currentOverlay?.remove();
//     _currentOverlay = null;
//   }
// }


import 'dart:developer' as developer;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:go_router/go_router.dart';

enum AdType {
  login,
  contactUs,
  rateApp,
  upgradePlan,
}


class AdManager extends GetxService {
  static AdManager get to => Get.find();

  final _storage = GetStorage();

  // Simple click tracking
  final clickCount = 0.obs;
  static const int clicksBeforeAd = 10;

  Future<AdManager> init() async {
    await _loadAdData();

    developer.log(
      'AdManager initialized',
      name: 'AdManager',
      error: {
        'clicks': clickCount.value,
      },
    );

    return this;
  }

  Future<void> _loadAdData() async {
    clickCount.value = _storage.read('click_count') ?? 0;
  }

  void incrementClick() {
    clickCount.value++;
    _storage.write('click_count', clickCount.value);
    developer.log('Click count: ${clickCount.value}', name: 'AdManager');
  }

  Future<bool> shouldShowAd({AdType? preferredType}) async {
    developer.log(
      'Checking if should show ad',
      name: 'AdManager',
      error: {'clicks': clickCount.value, 'preferredType': preferredType?.name},
    );

    // Don't show login ad if already logged in
    if (preferredType == AdType.login && isUserLoggedIn()) {
      developer.log('User already logged in', name: 'AdManager');
      return false;
    }

    // Don't show rate app if already rated
    if (preferredType == AdType.rateApp && hasUserRated()) {
      developer.log('User already rated app', name: 'AdManager');
      return false;
    }

    // Check if 10 clicks reached
    if (clickCount.value >= clicksBeforeAd) {
      developer.log('10 clicks reached, ad approved', name: 'AdManager');
      return true;
    }

    developer.log('Not enough clicks: ${clickCount.value}', name: 'AdManager');
    return false;
  }

  Future<AdType?> getNextAdToShow() async {
    developer.log('Getting next ad to show', name: 'AdManager');

    if (!await shouldShowAd()) {
      developer.log('No ad should be shown', name: 'AdManager');
      return null;
    }

    // Priority 1: Show login ad if user not logged in
    if (!isUserLoggedIn()) {
      if (await shouldShowAd(preferredType: AdType.login)) {
        developer.log('Returning login ad', name: 'AdManager');
        return AdType.login;
      }
    }

    // Priority 2: Show rate app if not rated
    if (!hasUserRated()) {
      if (await shouldShowAd(preferredType: AdType.rateApp)) {
        developer.log('Returning rate app ad', name: 'AdManager');
        return AdType.rateApp;
      }
    }

    // Rotate between other ad types
    final lastShownType = _storage.read<String>('last_ad_type');

    if (lastShownType != AdType.contactUs.name) {
      developer.log('Returning contact us ad', name: 'AdManager');
      return AdType.contactUs;
    } else if (lastShownType != AdType.upgradePlan.name && isUserLoggedIn()) {
      developer.log('Returning upgrade plan ad', name: 'AdManager');
      return AdType.upgradePlan;
    }

    developer.log('Returning contact us ad (default)', name: 'AdManager');
    return AdType.contactUs;
  }

  Future<void> markAdAsShown(AdType type) async {
    await _storage.write('last_ad_type', type.name);

    // Reset click count to 0 after showing ad
    clickCount.value = 0;
    await _storage.write('click_count', 0);

    developer.log('Ad marked as shown: ${type.name}, clicks reset', name: 'AdManager');
  }

  Future<void> dismissAd(AdType type) async {
    developer.log('Ad dismissed: ${type.name}', name: 'AdManager');
    // Reset click count even on dismiss
    clickCount.value = 0;
    await _storage.write('click_count', 0);
  }

  // Public methods for checking user status
  bool isUserLoggedIn() {
    return _storage.read<bool>('is_logged_in') ?? false;
  }

  bool hasUserRated() {
    return _storage.read<bool>('has_rated_app') ?? false;
  }

  Future<void> markUserAsLoggedIn() async {
    await _storage.write('is_logged_in', true);
    developer.log('User marked as logged in', name: 'AdManager');
  }

  Future<void> markAppAsRated() async {
    await _storage.write('has_rated_app', true);
    developer.log('App marked as rated', name: 'AdManager');
  }

  // Reset for testing purposes
  Future<void> resetAdData() async {
    await _storage.remove('click_count');
    await _storage.remove('last_ad_type');
    await _storage.remove('is_logged_in');
    await _storage.remove('has_rated_app');
    clickCount.value = 0;
    developer.log('Ad data reset', name: 'AdManager');
  }
}


class FloatingAdCard extends StatefulWidget {
  final AdType adType;
  final VoidCallback onDismiss;

  const FloatingAdCard({
    super.key,
    required this.adType,
    required this.onDismiss,
  });

  @override
  State<FloatingAdCard> createState() => _FloatingAdCardState();
}

class _FloatingAdCardState extends State<FloatingAdCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();
    developer.log('FloatingAdCard shown: ${widget.adType.name}', name: 'AdManager');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDismiss() async {
    developer.log('User dismissed ad: ${widget.adType.name}', name: 'AdManager');
    await _controller.reverse();
    await AdManager.to.dismissAd(widget.adType);
    widget.onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final adContent = _getAdContent(context);

    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          margin: EdgeInsets.all(16.w),
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.primaryContainer,
                colorScheme.secondaryContainer,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withOpacity(0.3),
                blurRadius: 20.r,
                offset: Offset(0, 10.h),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      adContent.icon,
                      color: colorScheme.primary,
                      size: 28.sp,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          adContent.title,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          adContent.description,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: colorScheme.onPrimaryContainer.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: _handleDismiss,
                    icon: Icon(
                      PhosphorIcons.x(),
                      color: colorScheme.onPrimaryContainer.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _handleDismiss,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: colorScheme.primary),
                        foregroundColor: colorScheme.primary,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: const Text('Maybe Later'),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () async {
                        developer.log('User clicked ad action: ${widget.adType.name}', name: 'AdManager');
                        await _controller.reverse();
                        await AdManager.to.markAdAsShown(widget.adType);
                        widget.onDismiss();
                        adContent.onAction();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text(adContent.actionText),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _AdContent _getAdContent(BuildContext context) {
    switch (widget.adType) {
      case AdType.login:
        return _AdContent(
          icon: PhosphorIcons.userCirclePlus(PhosphorIconsStyle.fill),
          title: 'Unlock Full Features!',
          description: 'Sign in to access real-time monitoring, alerts, and more.',
          actionText: 'Sign In Now',
          onAction: () => context.push('/login'),
        );
      case AdType.contactUs:
        return _AdContent(
          icon: PhosphorIcons.chatCircleDots(PhosphorIconsStyle.fill),
          title: 'Need Help?',
          description: 'Our solar experts are ready to assist you 24/7.',
          actionText: 'Contact Us',
          onAction: () => context.push('/contact'),
        );
      case AdType.rateApp:
        return _AdContent(
          icon: PhosphorIcons.star(PhosphorIconsStyle.fill),
          title: 'Enjoying the App?',
          description: 'Rate us 5 stars and help others discover great solar management!',
          actionText: 'Rate Now',
          onAction: () async {
            await AdManager.to.markAppAsRated();
            // Open app store rating
            final uri = Uri.parse('https://play.google.com/store/apps/details?id=your.app.id');

          },
        );
      case AdType.upgradePlan:
        return _AdContent(
          icon: PhosphorIcons.crownSimple(PhosphorIconsStyle.fill),
          title: 'Upgrade to Premium',
          description: 'Get advanced analytics, priority support, and unlimited plants.',
          actionText: 'View Plans',
          onAction: () => context.push('/plans'),
        );
    }
  }
}

class _AdContent {
  final IconData icon;
  final String title;
  final String description;
  final String actionText;
  final VoidCallback onAction;

  _AdContent({
    required this.icon,
    required this.title,
    required this.description,
    required this.actionText,
    required this.onAction,
  });
}



class AdOverlayManager {
  static OverlayEntry? _currentOverlay;
  static BuildContext? _overlayContext;
  static List<AdType> _adQueue = [];
  static bool _isShowingAd = false;

  // Call this from your main screen to set the context
  static void setContext(BuildContext context) {
    _overlayContext = context;
    developer.log('Overlay context set', name: 'AdOverlayManager');
  }

  static Future<void> tryShowAd() async {
    developer.log('Attempting to show ad', name: 'AdOverlayManager');

    if (_isShowingAd) {
      developer.log('Ad already showing, skipping', name: 'AdOverlayManager');
      return;
    }

    // Get all available ads to show
    _adQueue = await _getAdQueue();

    if (_adQueue.isEmpty) {
      developer.log('No ads to show', name: 'AdOverlayManager');
      return;
    }

    developer.log('Ad queue prepared: ${_adQueue.length} ads', name: 'AdOverlayManager');

    // Start showing ads in sequence
    _showNextAdInQueue();
  }

  static Future<List<AdType>> _getAdQueue() async {
    final List<AdType> queue = [];

    // Check if we should show ads at all
    final shouldShow = await AdManager.to.shouldShowAd();
    if (!shouldShow) {
      return queue;
    }

    final isLoggedIn = AdManager.to.isUserLoggedIn();
    final hasRated = AdManager.to.hasUserRated();

    // Add login ad if user is not logged in
    if (!isLoggedIn) {
      queue.add(AdType.login);
      developer.log('Added login ad to queue', name: 'AdOverlayManager');
    }

    // Add rate app ad if user hasn't rated
    if (!hasRated) {
      queue.add(AdType.rateApp);
      developer.log('Added rate app ad to queue', name: 'AdOverlayManager');
    }

    // Always add contact us ad
    queue.add(AdType.contactUs);
    developer.log('Added contact us ad to queue', name: 'AdOverlayManager');

    // Add upgrade plan if user is logged in
    if (isLoggedIn) {
      queue.add(AdType.upgradePlan);
      developer.log('Added upgrade plan ad to queue', name: 'AdOverlayManager');
    }

    return queue;
  }

  static void _showNextAdInQueue() {
    if (_adQueue.isEmpty) {
      developer.log('All ads shown, queue empty', name: 'AdOverlayManager');
      _isShowingAd = false;
      // Mark ad cycle as complete
      if (_adQueue.isEmpty) {
        AdManager.to.markAdAsShown(AdType.contactUs); // Reset clicks
      }
      return;
    }

    final adType = _adQueue.removeAt(0);
    developer.log('Showing ad ${adType.name} (${_adQueue.length} remaining)', name: 'AdOverlayManager');

    _isShowingAd = true;
    _showOverlay(adType);
  }

  static void _showOverlay(AdType adType) {
    if (_overlayContext == null || !_overlayContext!.mounted) {
      developer.log('Overlay context not available', name: 'AdOverlayManager', error: 'Context is null or not mounted');
      _isShowingAd = false;
      return;
    }

    _currentOverlay = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 80,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: FloatingAdCard(
            adType: adType,
            onDismiss: () => _dismissOverlay(adType),
          ),
        ),
      ),
    );

    try {
      Overlay.of(_overlayContext!).insert(_currentOverlay!);
      developer.log('Ad overlay inserted successfully: ${adType.name}', name: 'AdOverlayManager');
    } catch (e) {
      developer.log('Error inserting overlay', name: 'AdOverlayManager', error: e);
      _currentOverlay = null;
      _isShowingAd = false;
    }
  }

  static void _dismissOverlay(AdType adType) {
    _currentOverlay?.remove();
    _currentOverlay = null;

    developer.log('Ad overlay dismissed: ${adType.name}', name: 'AdOverlayManager');

    // Wait a bit before showing next ad
    Future.delayed(const Duration(milliseconds: 500), () {
      _showNextAdInQueue();
    });
  }

  // Force clear everything (for testing)
  static void clearAll() {
    _currentOverlay?.remove();
    _currentOverlay = null;
    _adQueue.clear();
    _isShowingAd = false;
    developer.log('All ads cleared', name: 'AdOverlayManager');
  }
}