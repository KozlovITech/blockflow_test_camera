part of 'camera_perm_cubit.dart';

sealed class CameraPermState extends Equatable {
  const CameraPermState();
  @override
  List<Object> get props => [];
}

final class CameraPermInitial extends CameraPermState {}

final class CameraPermSuccess extends CameraPermState {}

final class CameraPermDenied extends CameraPermState {}

final class CameraPermPermanentlyDenied extends CameraPermState {}

final class CameraPermError extends CameraPermState {
  final String error;
  const CameraPermError({required this.error});

  @override
  List<Object> get props => [error];
}
