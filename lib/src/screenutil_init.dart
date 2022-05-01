import 'package:flutter/widgets.dart';

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
  })  : assert(
          builder != null || child != null,
          'You must either pass builder or child or both',
        ),
        super(key: key);

  final Widget Function(Widget? child)? builder;
  final Widget? child;
  final bool splitScreenMode;
  final bool minTextAdapt;

  /// The [Size] of the device in the design draft, in dp
  final Size designSize;

  @override
  Widget build(BuildContext context) {
    bool firstFrameAllowed = false;
    final binding = WidgetsFlutterBinding.ensureInitialized();
    binding.deferFirstFrame();

    final rootMediaQueryData = (context
            .getElementForInheritedWidgetOfExactType<MediaQuery>()
            ?.widget as MediaQuery?)
        ?.data;

    return LayoutBuilder(
      builder: (_, constraints) {
        if (constraints.biggest == Size.zero) return const SizedBox.shrink();

        if (!firstFrameAllowed) {
          binding.allowFirstFrame();
          firstFrameAllowed = true;
        }

        return MediaQuery(
          data: rootMediaQueryData ?? MediaQueryData.fromWindow(binding.window),
          child: Builder(builder: (_context) {
            ScreenUtil.init(
              _context,
              designSize: designSize,
              splitScreenMode: splitScreenMode,
              minTextAdapt: minTextAdapt,
            );
            return builder?.call(child) ?? child!;
          }),
        );
      },
    );
  }
}
