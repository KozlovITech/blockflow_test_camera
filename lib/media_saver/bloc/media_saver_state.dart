part of 'media_saver_bloc.dart';

sealed class MediaSaverState extends Equatable {
  @override
  List<Object> get props => [];
}

class MediaSaverInitial extends MediaSaverState {}

class MediaSaverInProgress extends MediaSaverState {}

class MediaSaverSuccess extends MediaSaverState {}

class MediaSaverFailure extends MediaSaverState {}
