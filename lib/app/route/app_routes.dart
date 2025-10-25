//
// import 'dart:developer' as developer;
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../../apputils/services/Notification/notification_service.dart';
// import '../../main.dart';
// import '../modules/auth/login_view.dart';
// import '../modules/view/NotificationPage/notification_page.dart';
// import 'app_bindings.dart';
//
//
// class AppRoutes {
//   // Route names - keep same naming convention
//   static const login = '/login';
//   static const forgotPassword = '/forgotPassword';
//   static const mainDashboard = '/mainDashboard';
//   static const userDetail = '/user-detail';
//   static const userDetailInfo = '/user-userDetailInfo';
//
//
//   // Initialize bindings once at app start
//   static void initializeBindings() {
//     AppBindings().dependencies();
//   }
//
//   // Simple Go Router configuration for mobile
//   static final GoRouter
//   router = GoRouter(
//     initialLocation: mainDashboard,
//     routes: [
//
//
//       GoRoute(
//         path: mainDashboard,
//         builder: (context, state) => const DashboardScreen(),
//       ),
//
//
//
//     ],
//   );
// }
//
// // navigation_service.dart - Simple navigation helpers
// class NavigationService {
//   static final GoRouter _router = AppRoutes.router;
//
//   // Simple navigation methods
//   static void goToLogin() {
//     _router.go(AppRoutes.login);
//   }
//
//   static void goToMainDashboard() {
//     _router.go(AppRoutes.mainDashboard);
//   }
//
//   static void goBack() {
//     if (_router.canPop()) {
//       _router.pop();
//     }
//   }
//
//
//   static bool canGoBack() => _router.canPop();
// }



// lib/app/route/app_routes.dart


import 'package:go_router/go_router.dart';
import '../modules/ButtomNevigation/main_controller.dart';
import '../modules/ButtomNevigation/main_screen.dart';
import '../modules/splash/splash_screen.dart';
import 'app_bindings.dart';


class AppRoutes {
  // Route names
  static const splash = '/';
  static const mainDashboard = '/main';
  static const login = '/login';
  static const signup = '/signup';
  static const notifications = '/notifications';
  static const plantDetail = '/plant-detail';
  static const manualCleaning = '/cleaning/manual';
  static const scheduleView = '/cleaning/schedule';

  // Initialize bindings once at app start
  static void initializeBindings() {
    AppBindings().dependencies();
  }

  // Go Router configuration
  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      // Splash Screen
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
      ),

      // Main Screen with Bottom Navigation
      GoRoute(
        path: mainDashboard,
        builder: (context, state) => const MainScreen(),
      ),

      // Auth Routes
      // GoRoute(
      //   path: login,
      //   pageBuilder: (context, state) => MaterialPage(
      //     fullscreenDialog: true,
      //     child: const LoginView(),
      //   ),
      // ),

      // GoRoute(
      //   path: signup,
      //   pageBuilder: (context, state) => MaterialPage(
      //     fullscreenDialog: true,
      //     child: const SignupView(),
      //   ),
      // ),




    ],
  );
}

// Navigation Service
class NavigationService {
  static final GoRouter _router = AppRoutes.router;

  static void goToSplash() => _router.go(AppRoutes.splash);
  static void goToMainDashboard() => _router.go(AppRoutes.mainDashboard);
  static void goToLogin() => _router.push(AppRoutes.login);
  static void goToSignup() => _router.push(AppRoutes.signup);
  static void goToNotifications() => _router.push(AppRoutes.notifications);

  static void goBack() {
    if (_router.canPop()) {
      _router.pop();
    }
  }

  static bool canGoBack() => _router.canPop();
}

