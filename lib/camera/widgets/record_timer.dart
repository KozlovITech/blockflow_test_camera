import '../../core/const/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/camera_cubit/camera_cubit.dart';

class RecordTimer extends StatelessWidget {
  const RecordTimer({super.key});

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraCubit, CameraState>(
      buildWhen: (previous, current) =>
          current is CameraReady &&
          current.elapsedSeconds !=
              (previous is CameraReady ? previous.elapsedSeconds : null),
      builder: (context, state) {
        if (state is CameraReady && context.read<CameraCubit>().isRecording) {
          return Row(
            spacing: AppDimens.tiny,
            children: [
              Icon(Icons.fiber_manual_record, color: Colors.red, size: 18),
              Text(
                _formatTime(state.elapsedSeconds),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
