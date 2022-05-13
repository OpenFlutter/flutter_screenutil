import 'package:flutter/widgets.dart';

import 'screen_util.dart';

typedef RebuildFactor = bool Function(MediaQueryData old, MediaQueryData data);

bool defaultRebuildFactor(old, data) => old.size != data.size;

class ScreenUtilInit extends StatefulWidget {
  /// A helper widget that initializes [ScreenUtil]
  const ScreenUtilInit({
    Key? key,
    this.builder,
    this.child,
    this.rebuildFactor = defaultRebuildFactor,
    this.designSize = ScreenUtil.defaultSize,
    this.splitScreenMode = false,
    this.minTextAdapt = false,
    this.useInheritedMediaQuery = false,
  })  : assert(
          builder != null || child != null,
          'You must either pass builder or child or both',
        ),
        super(key: key);

  final Widget Function(Widget? child)? builder;
  final Widget? child;
  final bool splitScreenMode;
  final bool minTextAdapt;
  final bool useInheritedMediaQuery;
  final RebuildFactor rebuildFactor;

  /// The [Size] of the device in the design draft, in dp
  final Size designSize;

  @override
  State<ScreenUtilInit> createState() => _ScreenUtilInitState();
}

class _ScreenUtilInitState extends State<ScreenUtilInit>
    with WidgetsBindingObserver {
  late MediaQueryData mediaQueryData;
  bool wrappedInMediaQuery = false;

  WidgetsBinding get binding => WidgetsFlutterBinding.ensureInitialized();

  MediaQueryData get newData {
    if (widget.useInheritedMediaQuery) {
      final el = context.getElementForInheritedWidgetOfExactType<MediaQuery>();
      final mq = el?.widget as MediaQuery?;
      final data = mq?.data;

      if (data != null) {
        wrappedInMediaQuery = true;
        return data;
      }
    }

    return MediaQueryData.fromWindow(binding.window);
  }

  Widget get child {
    return SizedBox(
      key: GlobalObjectKey(
        hashValues(
          this,
          mediaQueryData.size.width,
          mediaQueryData.size.height,
        ),
      ),
      child: widget.builder?.call(widget.child) ?? widget.child!,
    );
  }

  @override
  void initState() {
    super.initState();
    mediaQueryData = newData;
    binding.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    final old = mediaQueryData;
    final data = newData;

    if (widget.rebuildFactor(old, data)) setState(() => mediaQueryData = data);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    didChangeMetrics();
  }

  @override
  void dispose() {
    binding.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext _context) {
    if (mediaQueryData.size == Size.zero) return const SizedBox.shrink();
    if (!wrappedInMediaQuery) {
      return MediaQuery(
        // key: GlobalObjectKey('mediaQuery'),
        data: mediaQueryData,
        child: Builder(
          builder: (__context) {
            ScreenUtil.init(
              __context,
              designSize: widget.designSize,
              splitScreenMode: widget.splitScreenMode,
              minTextAdapt: widget.minTextAdapt,
            );
            return child;
          },
        ),
      );
    }

    ScreenUtil.init(
      _context,
      designSize: widget.designSize,
      splitScreenMode: widget.splitScreenMode,
      minTextAdapt: widget.minTextAdapt,
    );

    return child;
  }
}
