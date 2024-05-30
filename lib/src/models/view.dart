import 'package:flutter/widgets.dart';

class ScreenUtilView {
  final double width;
  final double height;
  final Orientation orientation;

  const ScreenUtilView({
    required this.width,
    required this.height,
    required this.orientation,
  });

  @override
  String toString() {
    return 'ScreenUtilView(width: $width, height: $height, orientation: $orientation)';
  }
}
