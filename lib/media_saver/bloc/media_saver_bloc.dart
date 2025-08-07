import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../repo/media_server_repo.dart';

part 'media_saver_event.dart';
part 'media_saver_state.dart';

class MediaSaverBloc extends Bloc<MediaSaverEvent, MediaSaverState> {
  final MediaSaverRepository repository;

  MediaSaverBloc({required this.repository}) : super(MediaSaverInitial()) {
    on<SaveVideoRequested>(_onSaveVideo);
    on<SavePhotoRequested>(_onSavePhoto);
  }

  Future<void> _onSaveVideo(
    SaveVideoRequested event,
    Emitter<MediaSaverState> emit,
  ) async {
    emit(MediaSaverInProgress());
    final success = await repository.saveVideo(event.filePath);
    success ? emit(MediaSaverSuccess()) : emit(MediaSaverFailure());
  }

  Future<void> _onSavePhoto(
    SavePhotoRequested event,
    Emitter<MediaSaverState> emit,
  ) async {
    emit(MediaSaverInProgress());
    final success = await repository.savePhoto(event.filePath);
    success ? emit(MediaSaverSuccess()) : emit(MediaSaverFailure());
  }
}
