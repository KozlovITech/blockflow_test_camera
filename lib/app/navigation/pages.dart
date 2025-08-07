import 'package:go_router/go_router.dart';

import '../../camera/view/camera_page.dart';
import '../../error/view/error_page.dart';
import '../../splash/view/splash_page.dart';

part 'routes.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.splashRoute,
  errorPageBuilder: (_, state) =>
      NoTransitionPage(key: state.pageKey, child: const ErrorPage()),
  routes: [
    GoRoute(path: '/', redirect: (_, _) => Routes.splashRoute),
    GoRoute(
      name: _Paths.splash,
      path: Routes.splashRoute,
      pageBuilder: (_, state) =>
          NoTransitionPage(key: state.pageKey, child: const SplashPage()),
    ),
    GoRoute(
      name: _Paths.camera,
      path: Routes.cameraRoute,
      pageBuilder: (_, state) =>
          NoTransitionPage(key: state.pageKey, child: const CameraPage()),
    ),
  ],
);
