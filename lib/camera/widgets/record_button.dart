import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/const/app_color.dart';
import '../cubit/camera_cubit/camera_cubit.dart';

class RecordButton extends StatelessWidget {
  const RecordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isRecording = context.select((CameraCubit c) => c.isRecording);
    return GestureDetector(
      onTap: () => context.read<CameraCubit>().startStopRecording(),
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.white, width: 4),
        ),
        child: Center(
          child: Container(
            width: isRecording ? 24 : 55,
            height: isRecording ? 24 : 55,
            decoration: BoxDecoration(
              color: AppColors.red,
              shape: isRecording ? BoxShape.rectangle : BoxShape.circle,
              borderRadius: isRecording ? BorderRadius.circular(4) : null,
            ),
          ),
        ),
      ),
    );
  }
}
