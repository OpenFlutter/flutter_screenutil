import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class ScreenUtilInit extends StatelessWidget {
  /// A helper widget that initializes [ScreenUtil]
  ScreenUtilInit({
    required this.builder,
    this.designSize = ScreenUtil.defaultSize,
    this.allowFontScaling = false,
    Key? key,
  }) : super(key: key);

  final Widget Function() builder;

  /// The [Size] of the device in the design draft, in dp
  final Size designSize;

  /// Sets whether the font size is scaled according to the system's "font size" assist option
  final bool allowFontScaling;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      return OrientationBuilder(
        builder: (_, Orientation orientation) {
          if (constraints.maxWidth != 0) {
            ScreenUtil.init(
              constraints,
              orientation: orientation,
              designSize: designSize,
              allowFontScaling: allowFontScaling,
            );
            return builder();
          }
          return Container();
        },
      );
    });
  }
}
