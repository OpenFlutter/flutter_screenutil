import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';

import 'screen_util.dart';

class ScreenUtilInit extends StatelessWidget {
  /// A helper widget that initializes [ScreenUtil]
  const ScreenUtilInit({
    this.builder,
    this.child,
    this.designSize = ScreenUtil.defaultSize,
    this.splitScreenMode = false,
    this.minTextAdapt = false,
    Key? key,
  }) : super(key: key);

  final Widget Function(Widget? child)? builder;
  final Widget? child;
  final bool splitScreenMode;
  final bool minTextAdapt;

  /// The [Size] of the device in the design draft, in dp
  final Size designSize;

  @override
  Widget build(BuildContext _) {
    bool firstFrameAllowed = false;
    RendererBinding.instance!.deferFirstFrame();

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.biggest == Size.zero) return const SizedBox.shrink();

        ScreenUtil.init(
          null,
          deviceSize: constraints.biggest,
          designSize: designSize,
          splitScreenMode: splitScreenMode,
          minTextAdapt: minTextAdapt,
        );

        if (!firstFrameAllowed) {
          RendererBinding.instance!.allowFirstFrame();
          firstFrameAllowed = true;
        }

        return builder?.call(child) ?? child!;
      },
    );
  }
}
