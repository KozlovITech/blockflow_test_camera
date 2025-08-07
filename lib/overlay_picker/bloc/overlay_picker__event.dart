part of 'overlay_picker__bloc.dart';

sealed class OverlayPickerEvent extends Equatable {
  const OverlayPickerEvent();

  @override
  List<Object?> get props => [];
}

class OverlayPicked extends OverlayPickerEvent {
  final File imageFile;
  const OverlayPicked(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}

class OverlayCleared extends OverlayPickerEvent {}
