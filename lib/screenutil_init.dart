import 'package:flutter/widgets.dart';

import 'screenutil.dart';

class ScreenUtilInit extends StatelessWidget {
  const ScreenUtilInit({
    @required this.child,
    this.designSize = ScreenUtil.defaultSize,
    this.allowFontScaling = false,
    Key key,
  }) : super(key: key);

  final Widget child;
  final Size designSize;
  final bool allowFontScaling;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        ScreenUtil.init(
          constraints,
          designSize: designSize,
          allowFontScaling: allowFontScaling,
        );

        return child;
      },
    );
  }
}
