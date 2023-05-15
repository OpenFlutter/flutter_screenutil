import 'package:flutter/widgets.dart';

import 'screen_util.dart';

typedef RebuildFactor = bool Function(MediaQueryData old, MediaQueryData data);

typedef ScreenUtilInitBuilder = Widget Function(
  BuildContext context,
  Widget? child,
);

class RebuildFactors {
  const RebuildFactors._();

  static bool size(MediaQueryData old, MediaQueryData data) {
    return old.size != data.size;
  }

  static bool orientation(MediaQueryData old, MediaQueryData data) {
    return old.orientation != data.orientation;
  }

  static bool sizeAndViewInsets(MediaQueryData old, MediaQueryData data) {
    return old.viewInsets != data.viewInsets;
  }

  static bool all(MediaQueryData old, MediaQueryData data) {
    return old != data;
  }
}

class ScreenUtilInit extends StatefulWidget {
  /// A helper widget that initializes [ScreenUtil]
  const ScreenUtilInit(
      {Key? key,
      required this.builder,
      this.child,
      this.rebuildFactor = RebuildFactors.size,
      this.designSize = ScreenUtil.defaultSize,
      this.splitScreenMode = false,
      this.minTextAdapt = false,
      this.scaleByHeight = false})
      : super(key: key);

  final ScreenUtilInitBuilder builder;
  final Widget? child;
  final bool splitScreenMode;
  final bool minTextAdapt;
  final bool scaleByHeight;
  final RebuildFactor rebuildFactor;

  /// The [Size] of the device in the design draft, in dp
  final Size designSize;

  @override
  State<ScreenUtilInit> createState() => _ScreenUtilInitState();
}

class _ScreenUtilInitState extends State<ScreenUtilInit>
    with WidgetsBindingObserver {
  MediaQueryData? _mediaQueryData;

  WidgetsBinding get binding => WidgetsFlutterBinding.ensureInitialized();

  Widget get child {
    return widget.builder.call(context, widget.child);
  }

  @override
  void initState() {
    super.initState();
    binding.addObserver(this);
  }

  @override
  void dispose() {
    binding.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext _context) {
    if (_mediaQueryData?.size == Size.zero) return const SizedBox.shrink();
    return Builder(
      builder: (__context) {
        final deviceData = MediaQuery.maybeOf(__context);
        final deviceSize = deviceData?.size ?? widget.designSize;
        ScreenUtil.init(__context,
            designSize: widget.designSize,
            splitScreenMode: widget.splitScreenMode,
            minTextAdapt: widget.minTextAdapt,
            scaleByHeight: widget.scaleByHeight);
        return Container(
            width: deviceSize.width,
            height: deviceSize.height,
            child: FittedBox(
              fit: BoxFit.none,
              alignment: Alignment.center,
              child: Container(
                width: widget.scaleByHeight
                    ? (deviceSize.height * widget.designSize.width) /
                        widget.designSize.height
                    : deviceSize.width,
                height: deviceSize.height,
                child: child,
              ),
            ));
      },
    );
  }
}
