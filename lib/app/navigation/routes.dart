part of 'pages.dart';

abstract class Routes {
  Routes._();

  static const splashRoute = '/${_Paths.splash}';
  static const cameraRoute = '/${_Paths.camera}';
}

abstract class _Paths {
  static const splash = SplashPage.id;
  static const camera = CameraPage.id;
}
