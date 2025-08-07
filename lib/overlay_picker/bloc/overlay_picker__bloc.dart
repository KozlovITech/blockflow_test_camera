import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'overlay_picker__event.dart';
part 'overlay_picker__state.dart';

class OverlayPickerBloc extends Bloc<OverlayPickerEvent, OverlayPickerState> {
  OverlayPickerBloc() : super(OverlayPickerInitial()) {
    on<OverlayPicked>((event, emit) {
      emit(OverlayPickerSuccess(event.imageFile));
    });

    on<OverlayCleared>((event, emit) {
      emit(OverlayPickerInitial());
    });
  }
}
