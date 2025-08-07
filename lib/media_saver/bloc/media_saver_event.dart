part of 'media_saver_bloc.dart';

sealed class MediaSaverEvent extends Equatable {
  const MediaSaverEvent();

  @override
  List<Object> get props => [];
}

class SaveVideoRequested extends MediaSaverEvent {
  final String filePath;
  const SaveVideoRequested(this.filePath);
}

class SavePhotoRequested extends MediaSaverEvent {
  final String filePath;
  const SavePhotoRequested(this.filePath);
}
