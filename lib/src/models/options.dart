import 'package:flutter/widgets.dart';

import '../types/scale_strategy.dart';

class ScreenUtilOptions {
  final bool enable;
  final Size designSize;
  final double minTextScale, maxTextScale;
  final double fontFactorByWidth, fontFactorByHeight;
  final bool flipSizeWhenLandscape;
  final ScreenUtilScaleStrategy fontScaleStrategy,
      paddingScaleStrategy,
      widthScaleStrategy,
      heightScaleStrategy;

  const ScreenUtilOptions({
    this.enable = true,
    required this.designSize,
    double? fontFactorByWidth,
    double? fontFactorByHeight,
    double? minTextScale,
    double? maxTextScale,
    bool? flipSizeWhenLandscape,
    ScreenUtilScaleStrategy? fontScaleStrategy,
    ScreenUtilScaleStrategy? paddingScaleStrategy,
    ScreenUtilScaleStrategy? widthScaleStrategy,
    ScreenUtilScaleStrategy? heightScaleStrategy,
  })  : fontFactorByWidth = fontFactorByWidth ?? 1.0,
        fontFactorByHeight = fontFactorByHeight ?? 1.0,
        minTextScale = minTextScale ?? 0.2,
        maxTextScale = maxTextScale ?? 4.0,
        flipSizeWhenLandscape = flipSizeWhenLandscape ?? false,
        fontScaleStrategy = fontScaleStrategy ?? ScreenUtilScaleStrategy.width,
        paddingScaleStrategy =
            paddingScaleStrategy ?? ScreenUtilScaleStrategy.width,
        widthScaleStrategy =
            widthScaleStrategy ?? ScreenUtilScaleStrategy.width,
        heightScaleStrategy =
            heightScaleStrategy ?? ScreenUtilScaleStrategy.height;
}
