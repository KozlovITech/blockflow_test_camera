// ignore_for_file: avoid_redundant_argument_values, use_build_context_synchronously, lines_longer_than_80_chars

import 'dart:io';
import '../../core/const/app_color.dart';
import '../../core/const/app_dimens.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../overlay_picker/bloc/overlay_picker__bloc.dart';
import '../../overlay_picker/view/overlay_picker_widget.dart';
import '../../media_saver/repo/media_server_repo.dart';
import '../../shared/widgets/loader_widgets.dart';
import '../cubit/camera_cubit/camera_cubit.dart';
import '../../media_saver/bloc/media_saver_bloc.dart';
import '../widgets/error_loading_camera_widget.dart';
import '../widgets/record_button.dart';
import '../widgets/record_timer.dart';

class CameraPage extends StatefulWidget {
  static const String id = 'camera';
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool showFlashEffect = false;

  @override
  Widget build(BuildContext context) {
    final headerHeight =
        MediaQuery.of(context).padding.top +
        kToolbarHeight +
        AppDimens.medium * 2;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CameraCubit()..initCamera()),
        BlocProvider(
          create: (_) => MediaSaverBloc(repository: MediaSaverRepository()),
        ),
        BlocProvider(create: (_) => OverlayPickerBloc()),
      ],
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(backgroundColor: AppColors.white, elevation: 0),
        body: BlocListener<CameraCubit, CameraState>(
          listener: (context, state) async {
            if (state is CameraPhotoTaken) {
              context.read<MediaSaverBloc>().add(
                SavePhotoRequested(state.filePath),
              );
              setState(() => showFlashEffect = true);
              await Future.delayed(const Duration(milliseconds: 50));
              setState(() => showFlashEffect = false);
            } else if (state is CameraVideoRecorded) {
              context.read<MediaSaverBloc>().add(
                SaveVideoRequested(state.filePath),
              );
            }
          },
          child: BlocBuilder<CameraCubit, CameraState>(
            builder: (context, state) {
              final cubit = context.read<CameraCubit>();

              if (state is CameraReady) {
                final isFront =
                    state.controller.description.lensDirection ==
                    CameraLensDirection.front;

                return Column(
                  children: [
                    SafeArea(
                      bottom: false,
                      child: Container(
                        width: double.infinity,
                        color: AppColors.white,
                        padding: EdgeInsets.all(AppDimens.medium),
                        child: Text(
                          'camera.test_task'.tr(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: Stack(
                        children: [
                          SafeArea(
                            bottom: false,
                            child: Container(
                              width: double.infinity,
                              color: AppColors.white,
                              padding: EdgeInsets.all(AppDimens.medium),
                              child: Text(
                                'camera.test_task'.tr(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 35.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.bottomCenter,
                            child: CameraPreview(state.controller),
                          ),

                          // Overlay
                          BlocBuilder<OverlayPickerBloc, OverlayPickerState>(
                            builder: (context, overlayState) {
                              if (overlayState is OverlayPickerSuccess) {
                                return OverlayPickerWidget(
                                  imageFile: overlayState.imageFile,
                                  isFrontCamera: isFront,
                                  onClear: () => context
                                      .read<OverlayPickerBloc>()
                                      .add(OverlayCleared()),
                                );
                              }
                              return const Positioned.fill(
                                child: ColoredBox(color: Colors.transparent),
                              );
                            },
                          ),

                          // Flash effect
                          if (showFlashEffect)
                            Positioned.fill(
                              child: Container(
                                color: Colors.black.withAlpha(200),
                              ),
                            ),

                          // Recording indicator + timer
                          if (cubit.isRecording)
                            Positioned(
                              top: headerHeight,
                              right: AppDimens.big,
                              child: const RecordTimer(),
                            ),

                          // Bottom control buttons
                          _buildActionButtons(context, cubit),
                        ],
                      ),
                    ),
                  ],
                );
              }

              if (state is CameraError) {
                return ErrorLoadingCameraWidget(
                  onRetry: () => context.read<CameraCubit>().initCamera(),
                );
              }
              return const Center(child: CustomWidgetLoader());
            },
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext ctx, CameraCubit cubit) {
    final overlayBloc = ctx.read<OverlayPickerBloc>();

    return Positioned(
      bottom: 32.h,
      left: 0,
      right: 50.w,
      child: SizedBox(
        height: 64.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.cameraswitch_outlined,
                    color: Colors.white,
                    size: AppDimens.huge,
                  ),
                  onPressed: cubit.toggleCamera,
                ),
                SizedBox(width: AppDimens.large),
                GestureDetector(
                  onTap: () async {
                    final result = await FilePicker.platform.pickFiles(
                      type: FileType.image,
                      withData: false,
                    );
                    if (!mounted) return;

                    if (result != null && result.files.single.path != null) {
                      final file = File(result.files.single.path!);
                      overlayBloc.add(OverlayPicked(file));
                    }
                  },
                  child: Container(
                    width: AppDimens.huge,
                    height: AppDimens.huge,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withAlpha(40),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(),
            const RecordButton(),
            SizedBox(),
            IconButton(
              icon: const Icon(
                Icons.photo_camera,
                color: Colors.white,
                size: AppDimens.huge,
              ),
              onPressed: cubit.takePhoto,
            ),
          ],
        ),
      ),
    );
  }
}
