import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // 🎨 COLOR PALETTE - Modern Neo-Morphic Design
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  // Primary - Solar Gold/Orange (Energy, Warmth, Power)
  static const Color primary = Color(0xFFFF9800);
  static const Color primaryLight = Color(0xFFFFB74D);
  static const Color primaryDark = Color(0xFFF57C00);
  static const Color primaryGradientStart = Color(0xFFFFB347);
  static const Color primaryGradientEnd = Color(0xFFFF6B35);

  // Secondary - Sky Blue (Clean Energy, Technology)
  static const Color secondary = Color(0xFF2196F3);
  static const Color secondaryLight = Color(0xFF64B5F6);
  static const Color secondaryDark = Color(0xFF1976D2);

  // Accent - Electric Green (Sustainability, Growth)
  static const Color accent = Color(0xFF4CAF50);
  static const Color accentLight = Color(0xFF81C784);
  static const Color accentDark = Color(0xFF388E3C);

  // Neutral Colors - Light Theme
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F5F5);

  // Text Colors - Light Theme
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textTertiary = Color(0xFF999999);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Special Colors
  static const Color energyProduction = Color(0xFFFFB300);
  static const Color cleaningActive = Color(0xFF00BCD4);
  static const Color demoMode = Color(0xFFFF6F00);
  static const Color cardShadow = Color(0x1A000000);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF0F0F1E);
  static const Color darkSurface = Color(0xFF1A1A2E);
  static const Color darkSurfaceVariant = Color(0xFF252538);
  static const Color darkTextPrimary = Color(0xFFE8E8F0);
  static const Color darkTextSecondary = Color(0xFFB0B0C0);
  static const Color darkTextTertiary = Color(0xFF808090);
  static const Color darkCardShadow = Color(0x33000000);

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // 📐 SPACING SYSTEM (Responsive)
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static double get space4 => 4.w;
  static double get space8 => 8.w;
  static double get space12 => 12.w;
  static double get space16 => 16.w;
  static double get space20 => 20.w;
  static double get space24 => 24.w;
  static double get space32 => 32.w;
  static double get space48 => 48.w;

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // 🔲 BORDER RADIUS (Responsive)
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static double get radiusSmall => 8.r;
  static double get radiusMedium => 12.r;
  static double get radiusLarge => 16.r;
  static double get radiusXLarge => 24.r;
  static const double radiusCircular = 999.0;

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // ✨ ELEVATION & SHADOWS (Responsive)
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static List<BoxShadow> get shadowSmall => [BoxShadow(color: cardShadow, offset: Offset(0, 2.h), blurRadius: 8.r)];
  static List<BoxShadow> get shadowMedium => [BoxShadow(color: cardShadow, offset: Offset(0, 4.h), blurRadius: 16.r)];
  static List<BoxShadow> get shadowLarge => [BoxShadow(color: cardShadow, offset: Offset(0, 8.h), blurRadius: 24.r)];
  static List<BoxShadow> get darkShadowSmall => [BoxShadow(color: darkCardShadow, offset: Offset(0, 2.h), blurRadius: 8.r)];
  static List<BoxShadow> get darkShadowMedium => [BoxShadow(color: darkCardShadow, offset: Offset(0, 4.h), blurRadius: 16.r)];
  static List<BoxShadow> get darkShadowLarge => [BoxShadow(color: darkCardShadow, offset: Offset(0, 8.h), blurRadius: 24.r)];

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // 🎨 GRADIENTS
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static LinearGradient get primaryGradient => const LinearGradient(colors: [primaryGradientStart, primaryGradientEnd], begin: Alignment.topLeft, end: Alignment.bottomRight);
  static LinearGradient get energyGradient => const LinearGradient(colors: [Color(0xFFFFD700), Color(0xFFFFBB00)], begin: Alignment.topCenter, end: Alignment.bottomCenter);
  static LinearGradient get successGradient => const LinearGradient(colors: [Color(0xFF00E5CC), Color(0xFF00BFA5)], begin: Alignment.topLeft, end: Alignment.bottomRight);
  static LinearGradient get skyGradient => const LinearGradient(colors: [Color(0xFF7C4DFF), Color(0xFF5E35B1)], begin: Alignment.topCenter, end: Alignment.bottomCenter);
  static LinearGradient get darkPrimaryGradient => const LinearGradient(colors: [Color(0xFFFFB74D), Color(0xFFFF8A65)], begin: Alignment.topLeft, end: Alignment.bottomRight);

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // 📝 TEXT STYLE HELPER - Production Grade
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static TextStyle _text(double size, FontWeight weight, {Color? color, double? spacing, double? height}) =>
      TextStyle(inherit: true, fontFamily: GoogleFonts.inter().fontFamily, fontSize: size, fontWeight: weight, color: color, letterSpacing: spacing, height: height);

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // 🎨 LIGHT THEME (Production Ready)
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: primary, onPrimary: textOnPrimary, secondary: secondary, onSecondary: textOnPrimary,
        tertiary: accent, surface: surface, onSurface: textPrimary, error: error, onError: textOnPrimary,
        outline: Color(0xFFE0E0E0), shadow: cardShadow,
      ),
      scaffoldBackgroundColor: background,
      appBarTheme: AppBarTheme(
        backgroundColor: surface, foregroundColor: textPrimary, elevation: 0, centerTitle: false,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.light, statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.transparent),
        titleTextStyle: _text(20.sp, FontWeight.w600, color: textPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary, foregroundColor: textOnPrimary, elevation: 0, shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusMedium)),
          textStyle: _text(16.sp, FontWeight.w600, spacing: 0.5),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary, side: BorderSide(color: primary, width: 1.5.w),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusMedium)),
          textStyle: _text(16.sp, FontWeight.w600, spacing: 0.5),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary, padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusSmall)),
          textStyle: _text(14.sp, FontWeight.w600, spacing: 0.5),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true, fillColor: surfaceVariant,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(radiusMedium), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radiusMedium), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radiusMedium), borderSide: BorderSide(color: primary, width: 2.w)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radiusMedium), borderSide: BorderSide(color: error, width: 1.w)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        hintStyle: _text(14.sp, FontWeight.normal, color: textTertiary),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary, foregroundColor: textOnPrimary, elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusLarge)),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface, selectedItemColor: primary, unselectedItemColor: textTertiary,
        selectedLabelStyle: _text(12.sp, FontWeight.w600), unselectedLabelStyle: _text(12.sp, FontWeight.normal),
        type: BottomNavigationBarType.fixed, elevation: 8,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surfaceVariant, selectedColor: primaryLight,
        labelStyle: _text(12.sp, FontWeight.normal, color: textPrimary),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusSmall)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface, elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLarge))),
      ),
      dividerTheme: DividerThemeData(color: const Color(0xFFE0E0E0), thickness: 1.h, space: 1.h),
      textTheme: TextTheme(
        displayLarge: _text(32.sp, FontWeight.bold, spacing: -0.5, height: 1.2),
        displayMedium: _text(28.sp, FontWeight.bold, spacing: -0.5, height: 1.3),
        displaySmall: _text(24.sp, FontWeight.bold, spacing: -0.25, height: 1.3),
        headlineLarge: _text(22.sp, FontWeight.w600, height: 1.4),
        headlineMedium: _text(20.sp, FontWeight.w600, height: 1.4),
        headlineSmall: _text(18.sp, FontWeight.w600, height: 1.4),
        titleLarge: _text(16.sp, FontWeight.w600, height: 1.5),
        titleMedium: _text(14.sp, FontWeight.w600, height: 1.5),
        titleSmall: _text(12.sp, FontWeight.w600, height: 1.5),
        bodyLarge: _text(16.sp, FontWeight.normal, height: 1.6),
        bodyMedium: _text(14.sp, FontWeight.normal, height: 1.6),
        bodySmall: _text(12.sp, FontWeight.normal, height: 1.5),
        labelLarge: _text(14.sp, FontWeight.w600, spacing: 0.5),
        labelMedium: _text(12.sp, FontWeight.w600, spacing: 0.5),
        labelSmall: _text(10.sp, FontWeight.w600, spacing: 0.5),
      ),
      iconTheme: IconThemeData(color: textSecondary, size: 24.sp),
    );
  }

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // 🌙 DARK THEME (Production Ready - COMPLETE)
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: primaryLight, onPrimary: Color(0xFF000000), secondary: secondaryLight, onSecondary: Color(0xFF000000),
        tertiary: accentLight, onTertiary: Color(0xFF000000), surface: darkSurface, onSurface: darkTextPrimary,
        error: error, onError: Color(0xFFFFFFFF), outline: Color(0xFF3D3D50), shadow: darkCardShadow,
        surfaceContainerHighest: darkSurfaceVariant,
      ),
      scaffoldBackgroundColor: darkBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: darkSurface, foregroundColor: darkTextPrimary, elevation: 0, centerTitle: false,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.light, statusBarColor: Colors.transparent),
        titleTextStyle: _text(20.sp, FontWeight.w600, color: darkTextPrimary),
        iconTheme: IconThemeData(color: darkTextPrimary, size: 24.sp),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryLight, foregroundColor: const Color(0xFF000000), elevation: 0, shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusMedium)),
          textStyle: _text(16.sp, FontWeight.w600, spacing: 0.5),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryLight, side: BorderSide(color: primaryLight, width: 1.5.w),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusMedium)),
          textStyle: _text(16.sp, FontWeight.w600, spacing: 0.5),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryLight, padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusSmall)),
          textStyle: _text(14.sp, FontWeight.w600, spacing: 0.5),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(style: IconButton.styleFrom(foregroundColor: darkTextPrimary)),
      inputDecorationTheme: InputDecorationTheme(
        filled: true, fillColor: darkSurfaceVariant,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(radiusMedium), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radiusMedium), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radiusMedium), borderSide: BorderSide(color: primaryLight, width: 2.w)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radiusMedium), borderSide: BorderSide(color: error, width: 1.w)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        hintStyle: _text(14.sp, FontWeight.normal, color: darkTextSecondary),
        labelStyle: _text(14.sp, FontWeight.normal, color: darkTextSecondary),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryLight, foregroundColor: const Color(0xFF000000), elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusLarge)),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkSurface, selectedItemColor: primaryLight, unselectedItemColor: darkTextSecondary,
        selectedLabelStyle: _text(12.sp, FontWeight.w600), unselectedLabelStyle: _text(12.sp, FontWeight.normal),
        type: BottomNavigationBarType.fixed, elevation: 8,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: darkSurface, indicatorColor: primaryLight.withOpacity(0.2),
        iconTheme: WidgetStateProperty.resolveWith((states) => IconThemeData(
            color: states.contains(WidgetState.selected) ? primaryLight : darkTextSecondary, size: 24.sp)),
        labelTextStyle: WidgetStateProperty.resolveWith((states) => _text(12.sp,
            states.contains(WidgetState.selected) ? FontWeight.w600 : FontWeight.normal,
            color: states.contains(WidgetState.selected) ? primaryLight : darkTextSecondary)),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: darkSurfaceVariant, selectedColor: primaryLight.withOpacity(0.2), deleteIconColor: darkTextSecondary,
        labelStyle: _text(12.sp, FontWeight.normal, color: darkTextPrimary),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusSmall)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: darkSurface, modalBackgroundColor: darkSurface, elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLarge))),
      ),
      dividerTheme: DividerThemeData(color: const Color(0xFF3D3D50), thickness: 1.h, space: 1.h),
      listTileTheme: ListTileThemeData(
        tileColor: darkSurface, selectedTileColor: primaryLight.withOpacity(0.1),
        iconColor: darkTextSecondary, textColor: darkTextPrimary,
        titleTextStyle: _text(16.sp, FontWeight.w600, color: darkTextPrimary),
        subtitleTextStyle: _text(14.sp, FontWeight.normal, color: darkTextSecondary),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.selected) ? primaryLight : darkTextTertiary),
        trackColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.selected) ? primaryLight.withOpacity(0.5) : darkSurfaceVariant),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.selected) ? primaryLight : Colors.transparent),
        checkColor: WidgetStateProperty.all(const Color(0xFF000000)),
        side: BorderSide(color: darkTextSecondary, width: 2.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.selected) ? primaryLight : darkTextSecondary),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: primaryLight, inactiveTrackColor: darkSurfaceVariant, thumbColor: primaryLight,
        overlayColor: primaryLight.withOpacity(0.2), valueIndicatorColor: primaryLight,
        valueIndicatorTextStyle: _text(12.sp, FontWeight.w600, color: const Color(0xFF000000)),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primaryLight, linearTrackColor: darkSurfaceVariant, circularTrackColor: darkSurfaceVariant,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: darkSurfaceVariant, contentTextStyle: _text(14.sp, FontWeight.normal, color: darkTextPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusSmall)), behavior: SnackBarBehavior.floating,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(color: darkSurfaceVariant, borderRadius: BorderRadius.circular(radiusSmall)),
        textStyle: _text(12.sp, FontWeight.normal, color: darkTextPrimary),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: darkSurface, elevation: 8, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusMedium)),
        textStyle: _text(14.sp, FontWeight.normal, color: darkTextPrimary),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: darkSurface, elevation: 16,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(radiusLarge))),
      ),
      bannerTheme: MaterialBannerThemeData(
        backgroundColor: darkSurfaceVariant, contentTextStyle: _text(14.sp, FontWeight.normal, color: darkTextPrimary),
      ),
      textTheme: TextTheme(
        displayLarge: _text(32.sp, FontWeight.bold, color: darkTextPrimary, spacing: -0.5, height: 1.2),
        displayMedium: _text(28.sp, FontWeight.bold, color: darkTextPrimary, spacing: -0.5, height: 1.3),
        displaySmall: _text(24.sp, FontWeight.bold, color: darkTextPrimary, spacing: -0.25, height: 1.3),
        headlineLarge: _text(22.sp, FontWeight.w600, color: darkTextPrimary, height: 1.4),
        headlineMedium: _text(20.sp, FontWeight.w600, color: darkTextPrimary, height: 1.4),
        headlineSmall: _text(18.sp, FontWeight.w600, color: darkTextPrimary, height: 1.4),
        titleLarge: _text(16.sp, FontWeight.w600, color: darkTextPrimary, height: 1.5),
        titleMedium: _text(14.sp, FontWeight.w600, color: darkTextPrimary, height: 1.5),
        titleSmall: _text(12.sp, FontWeight.w600, color: darkTextPrimary, height: 1.5),
        bodyLarge: _text(16.sp, FontWeight.normal, color: darkTextPrimary, height: 1.6),
        bodyMedium: _text(14.sp, FontWeight.normal, color: darkTextPrimary, height: 1.6),
        bodySmall: _text(12.sp, FontWeight.normal, color: darkTextSecondary, height: 1.5),
        labelLarge: _text(14.sp, FontWeight.w600, color: darkTextPrimary, spacing: 0.5),
        labelMedium: _text(12.sp, FontWeight.w600, color: darkTextPrimary, spacing: 0.5),
        labelSmall: _text(10.sp, FontWeight.w600, color: darkTextSecondary, spacing: 0.5),
      ),
      iconTheme: IconThemeData(color: darkTextSecondary, size: 24.sp),
      primaryIconTheme: IconThemeData(color: primaryLight, size: 24.sp),
    );
  }
}