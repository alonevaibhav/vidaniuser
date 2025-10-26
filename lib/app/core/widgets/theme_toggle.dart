import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/theme_service.dart';
import '../theme/app_theme.dart';

class ThemeToggleButton extends GetView<ThemeController> {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppTheme.radiusCircular),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => controller.toggleTheme(),
          borderRadius: BorderRadius.circular(AppTheme.radiusCircular),
          child: Padding(
            padding:  EdgeInsets.all(AppTheme.space12),
            child: AnimatedSwitcher(
              duration:  Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: animation,
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: Icon(
                controller.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                key: ValueKey(controller.isDarkMode),
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ),
      ),
    ));
  }
}