import 'dart:math' show min;

import 'package:flutter/widgets.dart';

import './options.dart';
import './view.dart';
import '../utils/scaler.dart';

class ScreenUtilData {
  final double fontSizeScale;
  final double widthScale;
  final double heightScale;
  final double insetScale;
  final double radiusScale;

  const ScreenUtilData({
    double? fontSizeScale,
    double? widthScale,
    double? heightScale,
    double? paddingScale,
    double? radiusScale,
  })  : this.fontSizeScale =
            fontSizeScale == null || fontSizeScale <= 0 ? 1 : fontSizeScale,
        this.widthScale =
            widthScale == null || widthScale <= 0 ? 1 : widthScale,
        this.heightScale =
            heightScale == null || heightScale <= 0 ? 1 : heightScale,
        this.insetScale =
            paddingScale == null || paddingScale <= 0 ? 1 : paddingScale,
        this.radiusScale =
            radiusScale == null || radiusScale <= 0 ? 1 : radiusScale;

  factory ScreenUtilData.from({
    required Size screenSize,
    Orientation orientation = Orientation.portrait,
    required ScreenUtilOptions options,
    ScreenUtilScaler scaler = const DefaultScreenUtilScaler(),
  }) {
    final view = ScreenUtilView(
      width: screenSize.width,
      height: screenSize.height,
      orientation: orientation,
    );

    final fontSizeScale = scaler.getFontScaleFactor(view, options);
    final widthScale = scaler.getWidthScaleFactor(view, options);
    final heightScale = scaler.getHeightScaleFactor(view, options);
    final paddingScale = scaler.getPaddingScaleFactor(view, options);
    final radiusScale = min(widthScale, heightScale);

    return ScreenUtilData(
      fontSizeScale: fontSizeScale,
      widthScale: widthScale,
      heightScale: heightScale,
      radiusScale: radiusScale,
      paddingScale: paddingScale,
    );
  }

  factory ScreenUtilData.fromContext({
    required BuildContext context,
    required ScreenUtilOptions options,
    ScreenUtilScaler scaler = const DefaultScreenUtilScaler(),
  }) {
    return ScreenUtilData.from(
      options: options,
      screenSize: MediaQuery.sizeOf(context),
      orientation: MediaQuery.orientationOf(context),
      scaler: scaler,
    );
  }

  @override
  int get hashCode => Object.hash(
        fontSizeScale,
        widthScale,
        heightScale,
        insetScale,
        radiusScale,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScreenUtilData &&
        other.fontSizeScale == fontSizeScale &&
        other.widthScale == widthScale &&
        other.heightScale == heightScale &&
        other.insetScale == insetScale &&
        other.radiusScale == radiusScale;
  }

  @override
  String toString() {
    return """ScreenUtilData(
      fontSizeScale: $fontSizeScale,
      widthScale: $widthScale,
      heightScale: $heightScale,
      insetScale: $insetScale,
      radiusScale: $radiusScale,
    )""";
  }

  double sp(num size) {
    return size * fontSizeScale;
  }

  double w(num width) {
    return width * widthScale;
  }

  double h(num height) {
    return height * heightScale;
  }

  double r(num radius) {
    return radius * radiusScale;
  }

  double i(num padding) {
    return padding * insetScale;
  }
}

class EmptyScreenUtilData extends ScreenUtilData {
  const EmptyScreenUtilData() : super();
}
