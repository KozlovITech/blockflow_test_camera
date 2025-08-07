import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  int _selectedCameraIndex = 0;
  bool isRecording = false;

  Timer? _recordTimer;
  int _elapsedSeconds = 0;

  CameraCubit() : super(CameraInitial());

  Future<void> initCamera() async {
    try {
      _cameras = await availableCameras();
      _selectedCameraIndex = 0;

      _controller = CameraController(
        _cameras[_selectedCameraIndex],
        ResolutionPreset.high,
      );

      await _controller!.initialize();
      emit(CameraReady(_controller!));
    } on Exception catch (e) {
      emit(CameraError(e.toString()));
    }
  }

  Future<void> toggleCamera() async {
    if (_cameras.length < 2) return;
    _selectedCameraIndex = _selectedCameraIndex == 0 ? 1 : 0;
    await _controller?.dispose();

    _controller = CameraController(
      _cameras[_selectedCameraIndex],
      ResolutionPreset.high,
    );

    await _controller!.initialize();
    emit(CameraReady(_controller!));
  }

  Future<void> takePhoto() async {
    if (!(_controller?.value.isInitialized ?? false)) return;

    try {
      final file = await _controller!.takePicture();
      emit(CameraPhotoTaken(file.path));
      emitReadyState();
    } on Exception catch (e) {
      emit(CameraError('Photo error: $e'));
    }
  }

  Future<void> startStopRecording() async {
    if (!(_controller?.value.isInitialized ?? false)) return;

    try {
      if (isRecording) {
        final file = await _controller!.stopVideoRecording();
        isRecording = false;
        _stopTimer();
        emit(CameraVideoRecorded(file.path));
        emitReadyState();
      } else {
        await _controller!.prepareForVideoRecording();
        await _controller!.startVideoRecording();
        isRecording = true;
        _startTimer();
      }
    } on Exception catch (e) {
      emit(CameraError('Video error: $e'));
    }
  }

  void _startTimer() {
    _elapsedSeconds = 0;
    _recordTimer?.cancel();
    _recordTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _elapsedSeconds++;
      emit(CameraReady(_controller!, elapsedSeconds: _elapsedSeconds));
    });
  }

  void _stopTimer() {
    _recordTimer?.cancel();
    _elapsedSeconds = 0;
  }

  void emitReadyState() {
    if (_controller != null && _controller!.value.isInitialized) {
      emit(CameraReady(_controller!));
    }
  }

  @override
  Future<void> close() {
    _recordTimer?.cancel();
    return super.close();
  }
}
