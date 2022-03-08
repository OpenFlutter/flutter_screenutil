import 'package:flutter/cupertino.dart';

import 'screen_util.dart';

class ScreenUtilInit extends StatelessWidget {
  /// A helper widget that initializes [ScreenUtil]
  const ScreenUtilInit({
    required this.builder,
    this.designSize = ScreenUtil.defaultSize,
    this.splitScreenMode = false,
    this.minTextAdapt = false,
    Key? key,
  }) : super(key: key);

  final Widget Function() builder;
  final bool splitScreenMode;
  final bool minTextAdapt;

  /// The [Size] of the device in the design draft, in dp
  final Size designSize;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance!.window),
      child: LayoutBuilder(builder: (_, BoxConstraints constraints) {
        if (constraints.maxWidth != 0) {
          final Orientation orientation =
              constraints.maxWidth > constraints.maxHeight
                  ? Orientation.landscape
                  : Orientation.portrait;
          ScreenUtil.init(constraints,
              context: _,
              orientation: orientation,
              designSize: designSize,
              splitScreenMode: splitScreenMode,
              minTextAdapt: minTextAdapt);
          return builder();
        }
        return Container();
      }),
    );
  }
}
