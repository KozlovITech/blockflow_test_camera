import 'package:flutter/services.dart';

class MediaSaverRepository {
  static const _channel = MethodChannel('media_saver');

  Future<bool> saveVideo(String path) async {
    try {
      return await _channel.invokeMethod('saveVideo', {'path': path}) == true;
    }  on Exception catch (_) {
      return false;
    }
  }
  Future<bool> savePhoto(String path) async {
    try {
      return await _channel.invokeMethod('savePhoto', {'path': path}) == true;
    } on Exception catch (_) {
      return false;
    }
  }
}
