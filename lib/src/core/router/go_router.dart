import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/src/core/utils/logger/logger_helper.dart';
import '../base/api_client.dart';
import '../config/get_platform.dart';
import '../../features/auth/presentation/view/signin_screen.dart';
import '../../features/auth/presentation/view/signup_screen.dart';
import '../../features/home/presentation/view/home_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/settings/presentation/view/setting_screen.dart';
import '../../injector.dart';
import '../shared/maintenance_break/maintenance_break.dart';
import '../shared/page_not_found/page_not_found.dart';
import 'app_routes.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: AppRoutes.homeRoute,
  errorBuilder: (_, __) => const KPageNotFound(error: '404 - Page not found!'),
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.homeRoute,
      name: HomeScreen.name,
      builder: (_, __) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.signinRoute,
      name: SigninScreen.name,
      builder: (_, __) => const SigninScreen(),
    ),
    GoRoute(
      path: AppRoutes.signupRoute,
      name: SignupScreen.name,
      builder: (_, __) => const SignupScreen(),
    ),
    GoRoute(
      path: AppRoutes.settingsRoute,
      name: SettingsScreen.name,
      builder: (_, __) => const SettingsScreen(),
    ),
    GoRoute(
      path: AppRoutes.maintenanceBreakRoute,
      name: MaintenanceBreak.name,
      builder: (_, __) => const MaintenanceBreak(),
    ),
  ],
  redirect: (context, state) {
    final path = '/${state.fullPath?.split('/').last.toLowerCase()}';
    final loggedIn = sl<ApiClient>().isLoggedIn;
    log.f('Path: $path');

    /// Maintenance Break
    if (AppRoutes.isMaintenanceBreak) {
      log.f(
          'Redirecting to ${AppRoutes.maintenanceBreakRoute} from $path Reason: Maintenance Break.');
      return AppRoutes.maintenanceBreakRoute;
    }
    if (!AppRoutes.isMaintenanceBreak &&
        path == AppRoutes.maintenanceBreakRoute) {
      log.f(
          'Redirecting to ${AppRoutes.homeRoute} from $path Reason: Maintenance Break ended.');
      return AppRoutes.homeRoute;
    }

    /// Auth
    if (!loggedIn && AppRoutes.allAuthRequiredRoutes.contains(path)) {
      log.f(
          'Redirecting to ${AppRoutes.signinRoute} from $path Reason: Authentication.');
      return AppRoutes.signinRoute;
    }
    if (loggedIn && AppRoutes.authRelatedRoutes.contains(path)) {
      log.f(
          'Redirecting to ${AppRoutes.homeRoute} from $path Reason: Already logged in.');
      return AppRoutes.homeRoute;
    }
    return null;
  },
);

extension GoRouteExtension on BuildContext {
  goPush<T>(String route, {Object? extra}) => sl<PT>().isWeb
      ? GoRouter.of(this).go(route, extra: extra)
      : GoRouter.of(this).push(route, extra: extra);
}
