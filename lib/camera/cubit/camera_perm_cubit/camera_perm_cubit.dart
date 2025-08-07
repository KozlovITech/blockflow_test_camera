import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

part 'camera_perm_state.dart';

class CameraPermCubit extends Cubit<CameraPermState> {
  CameraPermCubit() : super(CameraPermInitial());

  Future<void> handleCameraPerm() async {
    emit(CameraPermInitial());
    try {
      var status = await Permission.camera.status;
      if (!status.isGranted) {
        status = await Permission.camera.request();
      }
      _handlePermStatus(status);
    } on Exception catch (e) {
      emit(CameraPermError(error: 'Error $e'));
    }
  }

  void _handlePermStatus(PermissionStatus status) {
    if (status.isGranted) {
      emit(CameraPermSuccess());
    } else if (status.isPermanentlyDenied || status.isDenied) {
      emit(CameraPermDenied());
    }
  }
}
