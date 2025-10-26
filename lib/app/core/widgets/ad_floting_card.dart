import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:go_router/go_router.dart';

import '../services/ad_manager_service.dart';

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