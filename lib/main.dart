// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/core/services/ad_manager_service.dart';
import 'app/core/services/api_service.dart';
import 'app/core/services/theme_service.dart';
import 'app/core/theme/app_theme.dart';
import 'app/route/app_routes.dart';
import 'apputils/services/Notification/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await GetStorage.init();

  // Initialize API Service
  await ApiService.init();

  // Initialize notification service
  await Get.putAsync(() => NotificationService().init());

  // Initialize AdManager
  await Get.putAsync(() => AdManager().init());

  // Initialize controllers
  Get.put(ThemeController(), permanent: true);

  runApp(const SolarApp());
}

class SolarApp extends StatelessWidget {
  const SolarApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: themeController.themeModeNotifier,
          builder: (context, themeMode, child) {
            return MaterialApp.router(
              title: 'Vidani Solar',
              debugShowCheckedModeBanner: false,
              routerConfig: AppRoutes.router,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
            );
          },
        );
      },
    );
  }
}
