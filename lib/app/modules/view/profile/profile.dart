import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:gap/gap.dart';
import '../../../core/Theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDemoMode = true; // Get from controller

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(AppTheme.space16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  if (isDemoMode) _buildDemoUserCard(context) else _buildUserCard(context),
                  Gap(AppTheme.space24),
                  if (isDemoMode) _buildLoginSection(context),
                  if (isDemoMode) Gap(AppTheme.space24),
                  _buildMenuSection(context, 'Account Settings', [
                    _buildMenuItem(
                      context,
                      icon: PhosphorIcons.user(),
                      title: 'Personal Information',
                      subtitle: 'Update your details',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      context,
                      icon: PhosphorIcons.bell(),
                      title: 'Notifications',
                      subtitle: 'Manage notification preferences',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      context,
                      icon: PhosphorIcons.lock(),
                      title: 'Security',
                      subtitle: 'Password and authentication',
                      onTap: () {},
                    ),
                  ]),
                  Gap(AppTheme.space24),
                  _buildMenuSection(context, 'App Settings', [
                    _buildMenuItem(
                      context,
                      icon: PhosphorIcons.palette(),
                      title: 'Theme',
                      subtitle: Theme.of(context).brightness == Brightness.dark ? 'Dark mode' : 'Light mode',
                      trailing: Switch(value: Theme.of(context).brightness == Brightness.dark, onChanged: (v) {}),
                      onTap: null,
                    ),
                    _buildMenuItem(
                      context,
                      icon: PhosphorIcons.globe(),
                      title: 'Language',
                      subtitle: 'English',
                      onTap: () {},
                    ),
                  ]),
                  Gap(AppTheme.space24),
                  _buildMenuSection(context, 'Plans & Billing', [
                    _buildMenuItem(
                      context,
                      icon: PhosphorIcons.crownSimple(),
                      title: 'Subscription Plans',
                      subtitle: isDemoMode ? 'View pricing' : 'Pro Plan',
                      badge: isDemoMode ? null : 'Active',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      context,
                      icon: PhosphorIcons.creditCard(),
                      title: 'Payment Methods',
                      subtitle: 'Manage payment options',
                      onTap: () {},
                    ),
                  ]),
                  Gap(AppTheme.space24),
                  _buildMenuSection(context, 'Support', [
                    _buildMenuItem(
                      context,
                      icon: PhosphorIcons.info(),
                      title: 'About',
                      subtitle: 'Version 1.0.0',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      context,
                      icon: PhosphorIcons.headset(),
                      title: 'Help & Support',
                      subtitle: 'Get assistance',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      context,
                      icon: PhosphorIcons.shareNetwork(),
                      title: 'Share App',
                      subtitle: 'Tell your friends',
                      onTap: () {},
                    ),
                  ]),
                  Gap(AppTheme.space24),
                  _buildLogoutButton(context),
                  Gap(AppTheme.space48),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoUserCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(AppTheme.space20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary.withOpacity(0.1),
            colorScheme.secondary.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(
          color: colorScheme.primary.withOpacity(0.3),
          width: 1.w,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              PhosphorIcons.userCircle(PhosphorIconsStyle.fill),
              size: 48.sp,
              color: colorScheme.primary,
            ),
          ),
          Gap(AppTheme.space16),
          Text(
            'Guest User',
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(AppTheme.space8),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.space12,
              vertical: AppTheme.space8,
            ),
            decoration: BoxDecoration(
              color: AppTheme.demoMode.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              border: Border.all(
                color: AppTheme.demoMode.withOpacity(0.4),
                width: 1.w,
              ),
            ),
            child: Text(
              'DEMO MODE',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: AppTheme.demoMode,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppTheme.space20),
      decoration: BoxDecoration(
        gradient: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.darkPrimaryGradient
            : AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        boxShadow: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.darkShadowMedium
            : AppTheme.shadowMedium,
      ),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'JD',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary,
                ),
              ),
            ),
          ),
          Gap(AppTheme.space16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Gap(4.h),
                Text(
                  'john.doe@example.com',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                Gap(8.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppTheme.space8,
                    vertical: AppTheme.space4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                  ),
                  child: Text(
                    'PRO MEMBER',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(PhosphorIcons.pencilSimple(), color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildLoginSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(AppTheme.space20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        boxShadow: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.darkShadowSmall
            : AppTheme.shadowSmall,
      ),
      child: Column(
        children: [
          Icon(
            PhosphorIcons.rocketLaunch(PhosphorIconsStyle.fill),
            size: 48.sp,
            color: colorScheme.primary,
          ),
          Gap(AppTheme.space16),
          Text(
            'Unlock Full Experience',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(AppTheme.space8),
          Text(
            'Sign in to access all features and manage your solar plants',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          Gap(AppTheme.space20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                'Sign In',
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Gap(AppTheme.space12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              child: Text(
                'Create Account',
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context, String title, List<Widget> items) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: AppTheme.space4),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ),
        Gap(AppTheme.space12),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            boxShadow: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.darkShadowSmall
                : AppTheme.shadowSmall,
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildMenuItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        VoidCallback? onTap,
        Widget? trailing,
        String? badge,
      }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(AppTheme.space16),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(AppTheme.space16),
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              ),
              child: Icon(icon, color: colorScheme.primary, size: 20.sp),
            ),
            Gap(AppTheme.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: textTheme.titleMedium,
                      ),
                      if (badge != null) ...[
                        Gap(8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.success.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            badge,
                            style: TextStyle(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.success,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Gap(4.h),
                  Text(
                    subtitle,
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            trailing ??
                Icon(
                  PhosphorIcons.caretRight(),
                  color: colorScheme.onSurface.withOpacity(0.4),
                  size: 16.sp,
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      child: Container(
        padding: EdgeInsets.all(AppTheme.space16),
        decoration: BoxDecoration(
          color: AppTheme.error.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: Border.all(
            color: AppTheme.error.withOpacity(0.3),
            width: 1.w,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              PhosphorIcons.signOut(PhosphorIconsStyle.bold),
              color: AppTheme.error,
              size: 20.sp,
            ),
            Gap(AppTheme.space8),
            Text(
              'Logout',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: AppTheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}