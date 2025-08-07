import 'dart:math';

import 'package:flutter/material.dart';

class CustomWidgetLoader extends StatefulWidget {
  const CustomWidgetLoader({super.key});

  @override
  State<CustomWidgetLoader> createState() => _CustomWidgetLoaderState();
}

class _CustomWidgetLoaderState extends State<CustomWidgetLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotationAnimation;

  bool _isClockwise = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1750),
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isClockwise = !_isClockwise;
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _isClockwise = !_isClockwise;
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotationAnimation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _isClockwise
              ? _rotationAnimation.value
              : -_rotationAnimation.value,
          child: child,
        );
      },
      child: Image.asset('assets/icons/ic_logo.png', width: 150, height: 150),
    );
  }
}
