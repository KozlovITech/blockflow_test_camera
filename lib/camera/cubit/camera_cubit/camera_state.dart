part of 'camera_cubit.dart';


abstract  class CameraState extends Equatable {
  const CameraState();

  @override
  List<Object?> get props => [];
}

class CameraInitial extends CameraState {}

class CameraReady extends CameraState {
  final CameraController controller;
  final int elapsedSeconds;

  const CameraReady(this.controller, {this.elapsedSeconds = 0});

  @override
  List<Object?> get props => [controller, elapsedSeconds];
}

class CameraPhotoTaken extends CameraState {
  final String filePath;
  const CameraPhotoTaken(this.filePath);

  @override
  List<Object?> get props => [filePath];
}

class CameraVideoRecorded extends CameraState {
  final String filePath;
  const CameraVideoRecorded(this.filePath);

  @override
  List<Object?> get props => [filePath];
}

class CameraError extends CameraState {
  final String error;
  const CameraError(this.error);

  @override
  List<Object?> get props => [error];
}