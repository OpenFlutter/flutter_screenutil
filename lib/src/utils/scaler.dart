import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../models/view.dart';
import '../models/options.dart';
import '../types/scale_strategy.dart';

abstract class ScreenUtilScaler {
  const ScreenUtilScaler();

  double getFontScaleFactor(
    ScreenUtilView view,
    ScreenUtilOptions options,
  );

  double getWidthScaleFactor(
    ScreenUtilView view,
    ScreenUtilOptions options,
  );

  double getHeightScaleFactor(
    ScreenUtilView view,
    ScreenUtilOptions options,
  );

  double getPaddingScaleFactor(
    ScreenUtilView view,
    ScreenUtilOptions options,
  );
}

class ScreenUtilPassthroughScaler extends ScreenUtilScaler {
  const ScreenUtilPassthroughScaler();

  @override
  double getFontScaleFactor(_, __) => 1.0;

  @override
  double getWidthScaleFactor(_, __) => 1.0;

  @override
  double getHeightScaleFactor(_, __) => 1.0;

  @override
  double getPaddingScaleFactor(_, __) => 1.0;
}

class DefaultScreenUtilScaler implements ScreenUtilScaler {
  const DefaultScreenUtilScaler();

  Size getScreenSize(ScreenUtilView view, bool flipSizeWhenLandscape) {
    if (flipSizeWhenLandscape &&
        [TargetPlatform.android, TargetPlatform.iOS]
            .contains(defaultTargetPlatform) &&
        view.orientation == Orientation.landscape) {
      return Size(view.height, view.width);
    }
    return Size(view.width, view.height);
  }

  @override
  double getFontScaleFactor(
    ScreenUtilView view,
    ScreenUtilOptions options,
  ) {
    final screenSize = getScreenSize(view, options.flipSizeWhenLandscape);

    final widthFactor = screenSize.width / options.designSize.width;
    final heightFactor = screenSize.height / options.designSize.height;

    if (options.fontScaleStrategy == ScreenUtilScaleStrategy.both) {
      return (widthFactor * options.fontFactorByWidth +
              heightFactor * options.fontFactorByHeight) /
          (options.fontFactorByWidth + options.fontFactorByHeight);
    }
    if (options.fontScaleStrategy == ScreenUtilScaleStrategy.width) {
      return widthFactor;
    }
    if (options.fontScaleStrategy == ScreenUtilScaleStrategy.height) {
      return heightFactor;
    }

    return 1.0;
  }

  @override
  double getWidthScaleFactor(
    ScreenUtilView view,
    ScreenUtilOptions options,
  ) {
    final screenSize = getScreenSize(view, options.flipSizeWhenLandscape);
    return screenSize.width / options.designSize.width;
  }

  @override
  double getHeightScaleFactor(
    ScreenUtilView view,
    ScreenUtilOptions options,
  ) {
    final screenSize = getScreenSize(view, options.flipSizeWhenLandscape);
    return screenSize.height / options.designSize.height;
  }

  @override
  double getPaddingScaleFactor(
    ScreenUtilView view,
    ScreenUtilOptions options,
  ) {
    final screenSize = getScreenSize(view, options.flipSizeWhenLandscape);

    final widthFactor = screenSize.width / options.designSize.width;
    final heightFactor = screenSize.height / options.designSize.height;

    return (widthFactor + heightFactor) / 2;
  }
}
