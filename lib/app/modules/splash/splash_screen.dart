import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../../route/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _logoFadeAnimation;
  late Animation<Offset> _logoSlideAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _loadingFadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _navigateToHome();
  }

  void _setupAnimations() {
    // Main fade controller
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Slide controller
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    // Logo animations
    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    _logoSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
      ),
    );

    // Text animations
    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
      ),
    );

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    // Loading animation
    _loadingFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
      ),
    );

    _fadeController.forward();
    _slideController.forward();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 3500));
    if (mounted) {
      context.go(AppRoutes.mainDashboard);
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0E27) : Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF0A0E27),
              const Color(0xFF111827),
              const Color(0xFF0A0E27),
            ],
            stops: const [0.0, 0.5, 1.0],
          )
              : null,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Decorative elements
              if (!isDark) ...[
                Positioned(
                  top: -100,
                  right: -100,
                  child: Container(
                    width: 300.w,
                    height: 300.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFFFB84D).withOpacity(0.1),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -80,
                  left: -80,
                  child: Container(
                    width: 250.w,
                    height: 250.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFFF6B35).withOpacity(0.08),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],

              // Main content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),

                    // Logo with animations
                    FadeTransition(
                      opacity: _logoFadeAnimation,
                      child: SlideTransition(
                        position: _logoSlideAnimation,
                        child: Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDark
                                ? Colors.white.withOpacity(0.05)
                                : Colors.grey.withOpacity(0.05),
                            boxShadow: isDark
                                ? [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.1),
                                blurRadius: 40,
                                spreadRadius: 5,
                              ),
                            ]
                                : [
                              BoxShadow(
                                color: const Color(0xFFFF6B35)
                                    .withOpacity(0.15),
                                blurRadius: 30,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Lottie.asset(
                            'assets/animations/solar_animation.json',
                            width: 180.w,
                            height: 180.w,
                            fit: BoxFit.contain,
                            repeat: true,
                            animate: true,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 50.h),

                    // App Name
                    FadeTransition(
                      opacity: _textFadeAnimation,
                      child: SlideTransition(
                        position: _textSlideAnimation,
                        child: Column(
                          children: [
                            Text(
                              'Vidani Solar',
                              style: TextStyle(
                                fontSize: 36.sp,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : const Color(0xFF1F2937),
                                letterSpacing: -0.5,
                                height: 1.2,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.blue.withOpacity(0.1)
                                    : const Color(0xFFFF6B35).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: isDark
                                      ? Colors.blue.withOpacity(0.2)
                                      : const Color(0xFFFF6B35).withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                'Smart Solar Management',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: isDark
                                      ? Colors.blue.shade300
                                      : const Color(0xFFFF6B35),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(flex: 2),

                    // Loading indicator
                    FadeTransition(
                      opacity: _loadingFadeAnimation,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 32.w,
                            height: 32.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5.w,
                              strokeCap: StrokeCap.round,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                isDark
                                    ? Colors.blue.shade400
                                    : const Color(0xFFFF6B35),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Initializing',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? Colors.white.withOpacity(0.5)
                                  : Colors.grey.shade600,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 60.h),
                  ],
                ),
              ),

              // Version number (optional)
              Positioned(
                bottom: 30.h,
                left: 0,
                right: 0,
                child: FadeTransition(
                  opacity: _loadingFadeAnimation,
                  child: Center(
                    child: Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: isDark
                            ? Colors.white.withOpacity(0.3)
                            : Colors.grey.shade400,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}