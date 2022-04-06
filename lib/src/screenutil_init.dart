import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';

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

  final WidgetBuilder builder;
  final bool splitScreenMode;
  final bool minTextAdapt;

  /// The [Size] of the device in the design draft, in dp
  final Size designSize;

  @override
  Widget build(BuildContext _) {
    bool firstFrameAllowed = false;
    RendererBinding.instance!.deferFirstFrame();

    return MediaQuery.fromWindow(
      child: Builder(builder: (context) {
        if (MediaQuery.of(context).size == Size.zero) return const SizedBox();
        ScreenUtil.init(
          context,
          designSize: designSize,
          splitScreenMode: splitScreenMode,
          minTextAdapt: minTextAdapt,
        );

        if (!firstFrameAllowed) {
          RendererBinding.instance!.allowFirstFrame();
          firstFrameAllowed = true;
        }

        return builder(context);
      }),
    );
  }
}
