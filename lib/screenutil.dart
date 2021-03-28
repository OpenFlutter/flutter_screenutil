/*
 * Created by 李卓原 on 2018/9/29.
 * email: zhuoyuan93@gmail.com
 */

import 'package:flutter/material.dart';

class ScreenUtil {
  static late ScreenUtil _instance;
  static const int defaultWidth = 1080;
  static const int defaultHeight = 1920;

  /// Size of the phone in UI Design in px.
  /// UI设计中手机尺寸，单位 px
  late final num uiWidthPx;
  late final num uiHeightPx;

  /// Whether fonts should scale to respect text size accessibility settings.
  /// Defaults to false.
  /// 控制字体是否要根据系统的“字体大小”辅助选项来进行缩放。
  /// 默认值为 false。
  late final bool allowFontScaling;

  static late final double _screenWidth;
  static late final double _screenHeight;
  static late final double _pixelRatio;
  static late final double _statusBarHeight;
  static late final double _bottomBarHeight;
  static late final double _textScaleFactor;

  ScreenUtil._();

  factory ScreenUtil() => _instance;

  static void init(
    BuildContext context, {
    num width = defaultWidth,
    num height = defaultHeight,
    bool allowFontScaling = false,
  }) {
    _instance = ScreenUtil._();
    _instance
      ..uiWidthPx = width
      ..uiHeightPx = height
      ..allowFontScaling = allowFontScaling;

    final MediaQueryData mediaQuery = MediaQuery.of(context);
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = mediaQuery.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
  }

  /// The number of font pixels for each logical pixel.
  /// 每个逻辑像素的字体像素数，字体的缩放比例
  static double get textScaleFactor => _textScaleFactor;

  /// The size of the media in logical pixels (e.g, the size of the screen).
  /// 设备的像素密度
  static double get pixelRatio => _pixelRatio;

  /// The horizontal extent of this size.
  /// 当前设备宽度 dp
  static double get screenWidth => _screenWidth;

  /// The vertical extent of this size in dp.
  /// 当前设备高度 dp
  static double get screenHeight => _screenHeight;

  /// The vertical extent of this size in px.
  /// 当前设备宽度 px
  static double get screenWidthPx => _screenWidth * _pixelRatio;

  /// The vertical extent of this size in px.
  /// 当前设备高度 px
  static double get screenHeightPx => _screenHeight * _pixelRatio;

  /// The offset from the top.
  /// 状态栏高度 dp 刘海屏会更高
  static double get statusBarHeight => _statusBarHeight;

  /// The offset from the bottom.
  /// 底部安全区距离 dp
  static double get bottomBarHeight => _bottomBarHeight;

  /// The ratio of the actual dp to the design draft px.
  /// 实际的 dp 与 UI 设计 px 的比例
  double get scaleWidth => _screenWidth / uiWidthPx;

  double get scaleHeight => _screenHeight / uiHeightPx;

  double get scaleText => scaleWidth;

  /// Adapted to the device width of the UI Design.
  /// Height can also be adapted according to this to ensure no deformation,
  /// if you want a square。
  /// 根据 UI 设计的设备宽度适配
  /// 高度也可以根据这个来做适配可以保证不变形，比如需要一个正方形的时候。
  num setWidth(num width) => width * scaleWidth;

  /// Highly adaptable to the device according to UI Design
  /// It is recommended to use this method to achieve a high degree of adaptation
  /// when it is found that one screen in the UI design
  /// does not match the current style effect, or if there is a difference in shape.
  /// 根据 UI 设计的设备高度适配
  /// 当发现 UI 设计中的一屏显示的与当前样式效果不符合时，
  /// 或者形状有差异时，建议使用此方法实现高度适配。
  /// 高度适配主要针对想根据 UI 设计的一屏展示一样的效果。
  num setHeight(num height) => height * scaleHeight;

  /// Font size adaptation method.
  /// 字体大小适配方法
  ///
  /// [fontSize] The size of the font on the UI design, in px.
  /// [fontSize] UI 设计上字体的大小，单位 px。
  num setSp(
    num fontSize, {
    bool? allowFontScalingSelf,
  }) =>
      allowFontScalingSelf == null
          ? (allowFontScaling
              ? (fontSize * scaleText)
              : ((fontSize * scaleText) / _textScaleFactor))
          : (allowFontScalingSelf
              ? (fontSize * scaleText)
              : ((fontSize * scaleText) / _textScaleFactor));
}
