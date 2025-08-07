import 'dart:io';
import 'package:flutter/material.dart';

import '../../core/const/app_dimens.dart';

class OverlayPickerWidget extends StatelessWidget {
  final File imageFile;
  final bool isFrontCamera;
  final VoidCallback onClear;

  const OverlayPickerWidget({
    super.key,
    required this.imageFile,
    required this.isFrontCamera,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          // Overlay image with 20% opacity, mirrored if front camera
          Positioned.fill(
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.2,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..scale(isFrontCamera ? -1.0 : 1.0, 1.0, 1.0),
                  child: Image.file(imageFile, fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          Positioned(
            top:
            MediaQuery.of(context).padding.top +
                kToolbarHeight +
                AppDimens.huge,
            right: AppDimens.big,
            child: GestureDetector(
              onTap: onClear,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(30),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
