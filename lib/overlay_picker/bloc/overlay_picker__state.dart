part of 'overlay_picker__bloc.dart';

sealed class OverlayPickerState extends Equatable {
  const OverlayPickerState();

  @override
  List<Object?> get props => [];
}

class OverlayPickerInitial extends OverlayPickerState {}

class OverlayPickerSuccess extends OverlayPickerState {
  final File imageFile;

  const OverlayPickerSuccess(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}
