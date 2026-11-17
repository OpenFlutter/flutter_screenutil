import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:math' show max, min;
import 'package:flutter/foundation.dart' show kDebugMode;

import 'package:flutter/widgets.dart';

import './_flutter_widgets.dart';
import 'screen_util.dart';
import 'screenutil_mixin.dart';

typedef RebuildFactor = bool Function(MediaQueryData old, MediaQueryData data);

typedef ScreenUtilInitBuilder = Widget Function(
  BuildContext context,
  Widget? child,
);

abstract class RebuildFactors {
  static bool size(MediaQueryData old, MediaQueryData data) {
    return old.size != data.size;
  }

  static bool orientation(MediaQueryData old, MediaQueryData data) {
    return old.orientation != data.orientation;
  }

  static bool sizeAndViewInsets(MediaQueryData old, MediaQueryData data) {
    return old.viewInsets != data.viewInsets;
  }

  static bool change(MediaQueryData old, MediaQueryData data) {
    return old != data;
  }

  static bool always(MediaQueryData _, MediaQueryData __) {
    return true;
  }

  static bool none(MediaQueryData _, MediaQueryData __) {
    return false;
  }
}

abstract class FontSizeResolvers {
  static double width(num fontSize, ScreenUtil instance) {
    return instance.setWidth(fontSize);
  }

  static double height(num fontSize, ScreenUtil instance) {
    return instance.setHeight(fontSize);
  }

  static double radius(num fontSize, ScreenUtil instance) {
    return instance.radius(fontSize);
  }

  static double diameter(num fontSize, ScreenUtil instance) {
    return instance.diameter(fontSize);
  }

  static double diagonal(num fontSize, ScreenUtil instance) {
    return instance.diagonal(fontSize);
  }
}

class ScreenUtilInit extends StatefulWidget {
  /// A helper widget that initializes [ScreenUtil]
  const ScreenUtilInit({
    Key? key,
    this.builder,
    this.child,
    this.rebuildFactor = RebuildFactors.size,
    this.designSize = ScreenUtil.defaultSize,
    this.splitScreenMode = false,
    this.minTextAdapt = false,
    this.useInheritedMediaQuery = false,
    this.ensureScreenSize = false,
    this.enableScaleWH,
    this.enableScaleText,
    this.responsiveWidgets,
    this.excludeWidgets,
    this.fontSizeResolver = FontSizeResolvers.width,
  }) : super(key: key);

  final ScreenUtilInitBuilder? builder;
  final Widget? child;
  final bool splitScreenMode;
  final bool minTextAdapt;
  final bool useInheritedMediaQuery;
  final bool ensureScreenSize;
  final bool Function()? enableScaleWH;
  final bool Function()? enableScaleText;
  final RebuildFactor rebuildFactor;
  final FontSizeResolver fontSizeResolver;

  /// The [Size] of the device in the design draft, in dp
  final Size designSize;
  final Iterable<String>? responsiveWidgets;
  final Iterable<String>? excludeWidgets;

  @override
  State<ScreenUtilInit> createState() => _ScreenUtilInitState();
}

class _ScreenUtilInitState extends State<ScreenUtilInit> with WidgetsBindingObserver {
  final _canMarkedToBuild = HashSet<String>();
  final _excludedWidgets = HashSet<String>();
  MediaQueryData? _mediaQueryData;
  double? _scaleOverride;
  final _binding = WidgetsBinding.instance;
  final _screenSizeCompleter = Completer<void>();

  @override
  void initState() {
    if (widget.responsiveWidgets != null) {
      _canMarkedToBuild.addAll(widget.responsiveWidgets!);
    }

    ScreenUtil.enableScale(enableWH: widget.enableScaleWH, enableText: widget.enableScaleText);

    _validateSize().then(_screenSizeCompleter.complete);

    super.initState();
    _binding.addObserver(this);
    ScreenUtil.wideLayoutRequests.addListener(_onWideLayoutChanged);
    ScreenUtil.rotatedLayout.addListener(_onWideLayoutChanged);
  }

  /// Route bật/tắt chế độ "wide" (full màn) → tính lại ngay, không đợi đổi kích thước.
  /// Không force: chỉ rebuild toàn cây khi layout thật sự đổi (size view hoặc scale).
  /// Vd iPad/Android đang DỌC thì wide không có tác dụng → không rebuild thừa.
  void _onWideLayoutChanged() {
    if (!mounted) return;
    _revalidate();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    _revalidate();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _revalidate();
  }

  MediaQueryData? _newData() {
    final view = View.maybeOf(context);
    if (view != null) {
      final layout = getSizeApp(context);
      _pendingScale = layout.scaleOverride;
      return MediaQueryData.fromView(view).copyWith(size: layout.sizeApp);
    }
    return null;
  }

  double? _pendingScale;

  Future<void> _validateSize() async {
    if (widget.ensureScreenSize) return ScreenUtil.ensureScreenSize();
  }

  void _markNeedsBuildIfAllowed(Element el) {
    final widgetName = el.widget.runtimeType.toString();
    if (_excludedWidgets.contains(widgetName)) return;
    final allowed = widget is SU ||
        _canMarkedToBuild.contains(widgetName) ||
        !(widgetName.startsWith('_') || flutterWidgets.contains(widgetName));

    if (allowed) el.markNeedsBuild();
  }

  void _updateTree(Element el) {
    _markNeedsBuildIfAllowed(el);
    el.visitChildren(_updateTree);
  }

  void _revalidate({void Function()? callback, bool force = false}) {
    final oldData = _mediaQueryData;
    final newData = _newData();

    if (newData == null) return;

    if (force || oldData == null || _scaleOverride != _pendingScale || widget.rebuildFactor(oldData, newData)) {
      setState(() {
        _mediaQueryData = newData;
        _scaleOverride = _pendingScale;
        _updateTree(context as Element);
        callback?.call();
      });
    }
  }

  /// designSize theo hướng của view khi KHÔNG có scaleOverride (logic cũ: 375x812 dọc / 812x375 ngang).
  /// Tự xoay ở đây thay vì phụ thuộc widget cha: khi route wide bật/tắt, chỉ ScreenUtilInit
  /// tính lại còn widget cha (nơi truyền designSize) không build lại → designSize cũ, scale lệch → tràn pixel.
  /// Có scaleOverride thì scale đều, designSize không ảnh hưởng.
  Size _effectiveDesignSize(Size viewSize) {
    final d = widget.designSize;
    if (_scaleOverride != null) return d;
    final viewLandscape = viewSize.width > viewSize.height;
    final designLandscape = d.width > d.height;
    return viewLandscape == designLandscape ? d : Size(d.height, d.width);
  }

  @override
  Widget build(BuildContext context) {
    final mq = _mediaQueryData;

    if (mq == null) return const SizedBox.shrink();

    if (!widget.ensureScreenSize) {
      ScreenUtil.configure(
        data: mq,
        designSize: _effectiveDesignSize(mq.size),
        splitScreenMode: widget.splitScreenMode,
        minTextAdapt: widget.minTextAdapt,
        fontSizeResolver: widget.fontSizeResolver,
        scaleOverride: _scaleOverride,
      );

      return widget.builder?.call(context, widget.child) ?? widget.child!;
    }

    return FutureBuilder<void>(
      future: _screenSizeCompleter.future,
      builder: (c, snapshot) {
        ScreenUtil.configure(
          data: mq,
          designSize: _effectiveDesignSize(mq.size),
          splitScreenMode: widget.splitScreenMode,
          minTextAdapt: widget.minTextAdapt,
          fontSizeResolver: widget.fontSizeResolver,
          scaleOverride: _scaleOverride,
        );

        if (snapshot.connectionState == ConnectionState.done) {
          return widget.builder?.call(context, widget.child) ?? widget.child!;
        }

        return const SizedBox.shrink();
      },
    );
  }

  @override
  void dispose() {
    ScreenUtil.wideLayoutRequests.removeListener(_onWideLayoutChanged);
    ScreenUtil.rotatedLayout.removeListener(_onWideLayoutChanged);
    _binding.removeObserver(this);
    super.dispose();
  }
}

/// Chế độ bố cục theo kích thước hiện tại (tính lại mỗi lần kích thước đổi).
enum ScreenLayoutMode {
  /// Điện thoại thường: giữ nguyên logic cũ.
  phone,

  /// Máy có bản lề, đang gập (shortestSide < 480), khóa dọc.
  foldedCompact,

  /// shortestSide >= 480 và H >= W.
  expandedPortrait,

  /// W > H trên màn lớn (kể cả split-screen ngang).
  expandedLandscape,
}

/// Rate thiết kế nội bộ (375x812) và các hằng của bố cục.
abstract class ScreenLayoutConstants {
  static const double designWidth = 375;
  static const double designHeight = 812;

  /// Cạnh ngắn < 480dp mới là điện thoại / màn gập. (Điện thoại lớn nhất ~440dp;
  /// Material: chiều cao compact < 480.) Không dùng 600 vì tablet density cao
  /// (vd Pixel Tablet emulator 2448x1848 @480dpi → 816x584dp) bị nhận nhầm là điện thoại.
  static const double compactShortestSide = 480;
  static const double minScale = 0.85;

  /// Tỉ lệ cao : rộng tối đa của khung khi ngang (4:3).
  static const double maxFrameHeightPerWidth = 3 / 4;

  /// Lề tối thiểu hai bên khung.
  static const double frameMargin = 16;

  /// Chế độ wide (bảng giá ngang, chart): design 812x667.
  static const double wideDesignWidth = 812;
  static const double wideDesignHeight = 667;

  /// Điện thoại ngang có tỉ lệ tối đa ~2.4; split-screen ngang trên tablet lớn hơn nhiều.
  static const double phoneLandscapeMaxAspect = 2.5;
}

/// Xác định mode từ kích thước cửa sổ.
/// [isFoldable]: máy có bản lề (native báo, gọi 1 lần lúc khởi động).
ScreenLayoutMode resolveLayoutMode(Size size, {required bool isFoldable}) {
  final shortest = size.shortestSide;
  final isLandscape = size.width > size.height;
  if (shortest < ScreenLayoutConstants.compactShortestSide) {
    // Điện thoại/màn gập ở chế độ ngang (trang market_info xoay ngang): giữ logic cũ.
    // Chỉ coi là expandedLandscape khi tỉ lệ vượt xa điện thoại (split-screen trên tablet).
    if (isLandscape && size.width / size.height > ScreenLayoutConstants.phoneLandscapeMaxAspect) {
      return ScreenLayoutMode.expandedLandscape;
    }
    if (isLandscape) return ScreenLayoutMode.phone;
    return isFoldable ? ScreenLayoutMode.foldedCompact : ScreenLayoutMode.phone;
  }
  return isLandscape ? ScreenLayoutMode.expandedLandscape : ScreenLayoutMode.expandedPortrait;
}

/// Kích thước view tốt nhất theo rate thiết kế 375x812, fit trong [frame]:
/// `s = max(0.85, min(frameW/375, frameH/812))` → `Size(375·s, 812·s)`.
Size resolveRateSize(Size frame, {bool withFloor = false}) {
  final s = resolveScale(frame, withFloor: withFloor);
  return Size(ScreenLayoutConstants.designWidth * s, ScreenLayoutConstants.designHeight * s);
}

/// Hệ số scale đều theo rate 375x812, ưu tiên chiều cao và chặn theo chiều rộng: `s = min(W/375, H/812)`.
/// [withFloor]: chặn dưới 0.85, chỉ dùng cho khung ngang (split-screen rất thấp). Màn dọc KHÔNG chặn,
/// nếu chặn thì màn thấp (vd Fold8 màn ngoài) sẽ có view cao hơn màn → tràn dọc.
double resolveScale(Size size, {bool withFloor = false}) {
  final s = min(size.width / ScreenLayoutConstants.designWidth, size.height / ScreenLayoutConstants.designHeight);
  return withFloor ? max(ScreenLayoutConstants.minScale, s) : s;
}

/// Hệ số scale của route wide (full màn): `s = min(W/812, H/667)`.
double resolveWideScale(Size size) {
  return min(size.width / ScreenLayoutConstants.wideDesignWidth, size.height / ScreenLayoutConstants.wideDesignHeight);
}

/// Bề rộng khung hiển thị khi ngang (cao : rộng = 4 : 3): `min(W - 32, H * 3/4)`.
double resolveFrameWidth(Size size) {
  return min(
    size.width - ScreenLayoutConstants.frameMargin * 2,
    size.height * ScreenLayoutConstants.maxFrameHeightPerWidth,
  );
}

/// Kết quả bố cục cho một kích thước cửa sổ.
class ScreenLayout {
  const ScreenLayout({
    required this.mode,
    required this.screenSize,
    required this.frameSize,
    required this.bodySize,
    required this.scaleOverride,
    required this.isMobile,
    required this.isFullBleed,
  });

  final ScreenLayoutMode mode;

  /// Kích thước cửa sổ thật.
  final Size screenSize;

  /// Khung hiển thị: 4:3 (cao : rộng) khi ngang có khung, ngược lại = màn hình.
  /// Chỉ dùng để đóng khung / layout, KHÔNG dùng để tính scale.
  final Size frameSize;

  /// Kích thước view đưa vào ScreenUtil: rate 375x812 fit tốt nhất trong [frameSize]
  /// (phone/iOS giữ logic cũ).
  final Size bodySize;

  /// Hệ số scale đều; null = dùng logic cũ (scaleWidth/scaleHeight theo designSize).
  final double? scaleOverride;

  /// Cờ cũ (dùng cho textScaler): false với màn lớn.
  final bool isMobile;

  /// true khi route wide đang bật trên màn ngang: không vẽ khung.
  final bool isFullBleed;

  /// Có vẽ khung hẹp ở giữa hay không (chỉ khi expandedLandscape và không full bleed).
  bool get isFramed => mode == ScreenLayoutMode.expandedLandscape && !isFullBleed;
}

/// Tính bố cục thuần theo kích thước (dễ test). Không cache.
ScreenLayout resolveScreenLayout(
  Size size, {
  bool isFoldable = false,
  bool wideLayout = false,
  bool? isIOS,
}) {
  final onIOS = isIOS ?? Platform.isIOS;
  final isLandscape = size.width > size.height;
  final isMobile = !((!isLandscape && size.width >= 530) || (isLandscape && size.height >= 600));

  if (onIOS) {
    // iOS giữ nguyên logic cũ, chỉ bỏ cache một lần (tính từ cạnh dài/ngắn nên không đổi khi xoay).
    const rate = 812 / 375;
    final longest = size.longestSide;
    final shortest = size.shortestSide;
    if (isMobile) {
      if ((longest / shortest - 16 / 9).abs() < 0.05) {
        final body = isLandscape ? Size(size.width, size.width / rate) : Size(size.height / rate, size.height);
        return ScreenLayout(
          mode: ScreenLayoutMode.phone,
          screenSize: size,
          frameSize: size,
          bodySize: body,
          scaleOverride: null,
          isMobile: isMobile,
          isFullBleed: false,
        );
      }
    } else {
      // iPad NGANG (trừ route wide): đóng khung 4:3 giống Android expandedLandscape.
      // Khung = min(W − 32, H·3/4) x H; view = rate 375x812 fit trong khung.
      if (isLandscape && !wideLayout) {
        final frame = Size(resolveFrameWidth(size), size.height);
        return ScreenLayout(
          mode: ScreenLayoutMode.expandedLandscape,
          screenSize: size,
          frameSize: frame,
          bodySize: resolveRateSize(frame, withFloor: true),
          scaleOverride: resolveScale(frame, withFloor: true),
          isMobile: isMobile,
          isFullBleed: false,
        );
      }
      // iPad dọc / route wide khi ngang: giữ logic cũ.
      var buffHeight = longest;
      final buffWidth = longest / rate;
      if (buffWidth > shortest) buffHeight = shortest * rate;
      final body = isLandscape ? Size(buffHeight, buffWidth) : Size(buffWidth, buffHeight);
      return ScreenLayout(
        mode: isLandscape ? ScreenLayoutMode.expandedLandscape : ScreenLayoutMode.expandedPortrait,
        screenSize: size,
        frameSize: size,
        bodySize: body,
        scaleOverride: null,
        isMobile: isMobile,
        isFullBleed: true,
      );
    }
    return ScreenLayout(
      mode: ScreenLayoutMode.phone,
      screenSize: size,
      frameSize: size,
      bodySize: size,
      scaleOverride: null,
      isMobile: isMobile,
      isFullBleed: false,
    );
  }

  final mode = resolveLayoutMode(size, isFoldable: isFoldable);
  switch (mode) {
    case ScreenLayoutMode.phone:
      // Điện thoại NGANG (các trang ngang chuyên dụng): giữ logic cũ (designSize 812x375, scale theo size thật).
      if (size.width > size.height) {
        return ScreenLayout(
          mode: mode,
          screenSize: size,
          frameSize: size,
          bodySize: size,
          scaleOverride: null,
          isMobile: isMobile,
          isFullBleed: false,
        );
      }
      // Điện thoại DỌC: như 1 màn, ưu tiên chiều cao theo rate 375x812 (scale đều).
      return ScreenLayout(
        mode: mode,
        screenSize: size,
        frameSize: size,
        bodySize: resolveRateSize(size),
        scaleOverride: resolveScale(size),
        isMobile: isMobile,
        isFullBleed: false,
      );
    case ScreenLayoutMode.foldedCompact:
    case ScreenLayoutMode.expandedPortrait:
      return ScreenLayout(
        mode: mode,
        screenSize: size,
        frameSize: size,
        bodySize: resolveRateSize(size),
        scaleOverride: resolveScale(size),
        isMobile: isMobile,
        isFullBleed: false,
      );
    case ScreenLayoutMode.expandedLandscape:
      if (wideLayout) {
        return ScreenLayout(
          mode: mode,
          screenSize: size,
          frameSize: size,
          bodySize: size,
          scaleOverride: resolveWideScale(size),
          isMobile: isMobile,
          isFullBleed: true,
        );
      }
      final frame = Size(resolveFrameWidth(size), size.height);
      return ScreenLayout(
        mode: mode,
        screenSize: size,
        frameSize: frame,
        bodySize: resolveRateSize(frame, withFloor: true),
        scaleOverride: resolveScale(frame, withFloor: true),
        isMobile: isMobile,
        isFullBleed: false,
      );
  }
}

class DeviceSizeApp {
  final bool isMobile;
  final Size sizeApp;
  final double? scaleOverride;
  final ScreenLayout layout;
  DeviceSizeApp({required this.isMobile, required this.sizeApp, this.scaleOverride, required this.layout});
}

/// Tính bố cục hiện tại từ [MediaQuery]; luôn tính lại, không cache.
DeviceSizeApp getSizeApp(BuildContext context) {
  var size = MediaQuery.sizeOf(context);
  // App tự xoay nội dung 90° trong khi màn đang dọc → tính như màn ngang (đảo W/H).
  if (ScreenUtil.rotatedLayout.value && size.height > size.width) {
    size = Size(size.height, size.width);
  }
  final layout = resolveScreenLayout(
    size,
    isFoldable: ScreenUtil.isFoldableDevice,
    wideLayout: ScreenUtil.wideLayoutRequested,
  );
  _debugLogLayout(layout);
  return DeviceSizeApp(
    isMobile: layout.isMobile,
    sizeApp: layout.bodySize,
    scaleOverride: layout.scaleOverride,
    layout: layout,
  );
}

String? _lastLayoutLog;

/// Debug: in ra thiết bị đang được xác định là gì, ngang hay dọc.
/// Chỉ in ở debug mode và chỉ khi kết quả thay đổi (getSizeApp được gọi mỗi lần build).
void _debugLogLayout(ScreenLayout l) {
  if (!kDebugMode) return;
  String f(Size s) => '${s.width.toStringAsFixed(0)}x${s.height.toStringAsFixed(0)}';
  String device;
  switch (l.mode) {
    case ScreenLayoutMode.phone:
      device = 'Điện thoại thường';
      break;
    case ScreenLayoutMode.foldedCompact:
      device = 'Máy gập - đang GẬP (1 màn)';
      break;
    case ScreenLayoutMode.expandedPortrait:
      device = 'Màn lớn (fold mở / tablet)';
      break;
    case ScreenLayoutMode.expandedLandscape:
      device = 'Màn lớn (fold mở / tablet / split-screen ngang)';
      break;
  }
  final orientation = l.screenSize.width > l.screenSize.height ? 'NGANG' : 'DỌC';
  final msg = '[ScreenLayout] $device | $orientation | mode=${l.mode.name}'
      ' | platform=${Platform.operatingSystem} | foldable=${ScreenUtil.isFoldableDevice}'
      ' | screen=${f(l.screenSize)} | frame=${f(l.frameSize)} | view=${f(l.bodySize)}'
      ' | s=${l.scaleOverride?.toStringAsFixed(3) ?? 'logic cũ'}'
      ' | khung=${l.isFramed} | wide=${l.isFullBleed} | appXoay90=${ScreenUtil.rotatedLayout.value}';
  if (msg == _lastLayoutLog) return;
  _lastLayoutLog = msg;
  debugPrint(msg);
}
