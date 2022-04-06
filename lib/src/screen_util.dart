/*
 * Created by 李卓原 on 2018/9/29.
 * email: zhuoyuan93@gmail.com
 */

import 'dart:math' show min, max;
import 'dart:ui' show FlutterWindow;

import 'package:flutter/widgets.dart';

class ScreenUtil {
  static const Size defaultSize = Size(360, 690);
  static late ScreenUtil _instance;

  /// UI设计中手机尺寸 , dp
  /// Size of the phone in UI Design , dp
  late Size uiSize;

  ///屏幕方向
  late Orientation _orientation;

  late double _screenWidth;
  late double _screenHeight;
  late bool _minTextAdapt;
  BuildContext? context;
  late bool _splitScreenMode;

  ScreenUtil._();

  factory ScreenUtil() {
    return _instance;
  }

  /// Manually wait for window size to be initialized
  ///
  /// `Recommended` to use before you need access window size
  /// or in custom splash/bootstrap screen [FutureBuilder]
  ///
  /// example:
  /// ```dart
  /// ...
  /// ScreenUtil.init(context, ...);
  /// ...
  ///   FutureBuilder(
  ///     future: Future.wait([..., ensureScreenSize(), ...]),
  ///     builder: (context, snapshot) {
  ///       if (snapshot.hasData) return const HomeScreen();
  ///       return Material(
  ///         child: LayoutBuilder(
  ///           ...
  ///         ),
  ///       );
  ///     },
  ///   )
  /// ```
  static Future<void> ensureScreenSize([
    FlutterWindow? window,
    Duration duration = const Duration(milliseconds: 10),
  ]) async {
    final binding = WidgetsFlutterBinding.ensureInitialized();
    window ??= binding.window;

    if (window.viewConfiguration.geometry.isEmpty) {
      return Future.delayed(duration, () async {
        binding.deferFirstFrame();
        await ensureScreenSize(window, duration);
        return binding.allowFirstFrame();
      });
    }
  }

  static void setContext(BuildContext context) {
    _instance.context = context;
  }

  /// Initializing the library.
  static void init(
    BuildContext context, {
    Orientation? orientation,
    Size? deviceSize,
    Size designSize = defaultSize,
    bool splitScreenMode = false,
    bool minTextAdapt = false,
  }) {
    print('init called');
    final deviceData = MediaQuery.maybeOf(context).nonEmptySizeOrNull();

    deviceSize ??= deviceData?.size ?? designSize;
    orientation ??= deviceData?.orientation ??
        (deviceSize.width > deviceSize.height
            ? Orientation.landscape
            : Orientation.portrait);

    _instance = ScreenUtil._()
      ..uiSize = designSize
      .._splitScreenMode = splitScreenMode
      .._minTextAdapt = minTextAdapt
      .._orientation = orientation
      .._screenWidth = deviceSize.width
      .._screenHeight = deviceSize.height
      ..context = deviceData != null ? context : null;
  }

  ///获取屏幕方向
  ///Get screen orientation
  Orientation get orientation => _orientation;

  /// 每个逻辑像素的字体像素数，字体的缩放比例
  /// The number of font pixels for each logical pixel.
  double get textScaleFactor =>
      context != null ? MediaQuery.of(context!).textScaleFactor : 1;

  /// 设备的像素密度
  /// The size of the media in logical pixels (e.g, the size of the screen).
  double? get pixelRatio =>
      context != null ? MediaQuery.of(context!).devicePixelRatio : 1;

  /// 当前设备宽度 dp
  /// The horizontal extent of this size.
  double get screenWidth =>
      context != null ? MediaQuery.of(context!).size.width : _screenWidth;

  ///当前设备高度 dp
  ///The vertical extent of this size. dp
  double get screenHeight =>
      context != null ? MediaQuery.of(context!).size.height : _screenHeight;

  /// 状态栏高度 dp 刘海屏会更高
  /// The offset from the top, in dp
  double get statusBarHeight =>
      context == null ? 0 : MediaQuery.of(context!).padding.top;

  /// 底部安全区距离 dp
  /// The offset from the bottom, in dp
  double get bottomBarHeight =>
      context == null ? 0 : MediaQuery.of(context!).padding.bottom;

  /// 实际尺寸与UI设计的比例
  /// The ratio of actual width to UI design
  double get scaleWidth => screenWidth / uiSize.width;

  ///  /// The ratio of actual height to UI design
  double get scaleHeight =>
      (_splitScreenMode ? max(screenHeight, 700) : screenHeight) /
      uiSize.height;

  double get scaleText =>
      _minTextAdapt ? min(scaleWidth, scaleHeight) : scaleWidth;

  /// 根据UI设计的设备宽度适配
  /// 高度也可以根据这个来做适配可以保证不变形,比如你想要一个正方形的时候.
  /// Adapted to the device width of the UI Design.
  /// Height can also be adapted according to this to ensure no deformation ,
  /// if you want a square
  double setWidth(num width) => width * scaleWidth;

  /// 根据UI设计的设备高度适配
  /// 当发现UI设计中的一屏显示的与当前样式效果不符合时,
  /// 或者形状有差异时,建议使用此方法实现高度适配.
  /// 高度适配主要针对想根据UI设计的一屏展示一样的效果
  /// Highly adaptable to the device according to UI Design
  /// It is recommended to use this method to achieve a high degree of adaptation
  /// when it is found that one screen in the UI design
  /// does not match the current style effect, or if there is a difference in shape.
  double setHeight(num height) => height * scaleHeight;

  ///根据宽度或高度中的较小值进行适配
  ///Adapt according to the smaller of width or height
  double radius(num r) => r * min(scaleWidth, scaleHeight);

  ///字体大小适配方法
  ///- [fontSize] UI设计上字体的大小,单位dp.
  ///Font size adaptation method
  ///- [fontSize] The size of the font on the UI design, in dp.
  double setSp(num fontSize) => fontSize * scaleText;

  Widget setVerticalSpacing(num height) => SizedBox(height: setHeight(height));

  Widget setVerticalSpacingFromWidth(num height) =>
      SizedBox(height: setWidth(height));

  Widget setHorizontalSpacing(num width) => SizedBox(width: setWidth(width));

  Widget setHorizontalSpacingRadius(num width) =>
      SizedBox(width: radius(width));

  Widget setVerticalSpacingRadius(num height) =>
      SizedBox(height: radius(height));
}

extension on MediaQueryData? {
  MediaQueryData? nonEmptySizeOrNull() {
    if (this?.size.isEmpty ?? true)
      return null;
    else
      return this;
  }
}
