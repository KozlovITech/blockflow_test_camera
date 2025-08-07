import '../shared/widgets/loader_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../core/app_theme.dart';
import '../core/const/app_color.dart';
import '../core/const/app_dimens.dart';
import 'navigation/pages.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppDimens.designSize,
      child: GlobalLoaderOverlay(
        duration: const Duration(milliseconds: 100),
        reverseDuration: const Duration(milliseconds: 100),
        overlayColor: AppColors.white.withValues(alpha: 0.25),
        overlayWidgetBuilder: (_) => const CustomWidgetLoader(),
        child: MaterialApp.router(
          theme: AppTheme.defaultTheme,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          locale: context.locale,
          routerConfig: router,
        ),
      ),
    );
  }
}
