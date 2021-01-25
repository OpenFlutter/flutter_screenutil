import 'package:flutter/widgets.dart';

import 'screenutil.dart';

class ScreenUtilInit extends StatelessWidget {
  /// A helper widget that initializes [ScreenUtil]
  ScreenUtilInit({
    @required this.child,
    this.designSize = ScreenUtil.defaultSize,
    this.allowFontScaling = false,
    Key key,
  }) : super(key: key);

  final Widget child;

  /// The [Size] of the device in the design draft, in px
  final Size designSize;

  /// Sets whether the font size is scaled according to the system's "font size" assist option
  final bool allowFontScaling;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // ignore: missing_return
      builder: (_, BoxConstraints constraints) {
        if (constraints.maxWidth != 0) {
          ScreenUtil.init(
            constraints,
            designSize: designSize,
            allowFontScaling: allowFontScaling,
          );

          return child;
        }
        return Container();
      },
    );
  }
}
