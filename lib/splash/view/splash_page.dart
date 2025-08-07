import '../../camera/cubit/camera_perm_cubit/camera_perm_cubit.dart';
import '../../shared/widgets/dialog_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../app/navigation/pages.dart';

class SplashPage extends StatefulWidget {
  static const String id = 'splash';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<CameraPermCubit>().handleCameraPerm();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<CameraPermCubit>().handleCameraPerm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CameraPermCubit, CameraPermState>(
      listener: (context, state) {
        if (state is CameraPermSuccess) {
          if (Navigator.of(context, rootNavigator: true).canPop()) {
            Navigator.of(context, rootNavigator: true).pop();
          }
          context.go(Routes.cameraRoute);
        } else if (state is CameraPermDenied ||
            state is CameraPermPermanentlyDenied) {
          PermissionDeniedDialog(
            context: context,
            confirmAction: () => openAppSettings(),
            title: 'camera.perm.title'.tr(),
            subtitle: 'camera.perm.subtitle'.tr(),
          ).show();
        }
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(
            'assets/icons/ic_logo.png',
            width: 0.35.sw,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
