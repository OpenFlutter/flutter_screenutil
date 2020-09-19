/*
 * Created by 李卓原 on 2018/9/29.
 * email: zhuoyuan93@gmail.com
 */

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ScreenUtil {
  static ScreenUtil _instance;
  static const Size defaultSize = Size(1080, 1920);

  /// UI设计中手机尺寸 , px
  /// Size of the phone in UI Design , px
  Size uiSize = defaultSize;

  /// 控制字体是否要根据系统的“字体大小”辅助选项来进行缩放。默认值为false。
  /// allowFontScaling Specifies whether fonts should scale to respect Text Size accessibility settings. The default is false.
  bool allowFontScaling = false;

  double _pixelRatio;
  double _screenWidth;
  double _screenHeight;
  double _statusBarHeight;
  double _bottomBarHeight;
  double _textScaleFactor;

  ScreenUtil._() {
    final window = SchedulerBinding.instance?.window;
    assert(
      window != null,
      '\nYou need to explicitly call the `WidgetsFlutterBinding.ensureInitialized()`, before initializing ScreenUtil.',
    );
    _pixelRatio = window.devicePixelRatio;
    _screenWidth = window.physicalSize.width / _pixelRatio;
    _screenHeight = window.physicalSize.height / _pixelRatio;
    _statusBarHeight = window.padding.top;
    _bottomBarHeight = window.padding.bottom;
    _textScaleFactor = window.textScaleFactor;
  }

  factory ScreenUtil() {
    assert(
      _instance != null,
      '\nEnsure to initialize ScreenUtil before accessing it.',
    );
    return _instance;
  }

  static void init({
    Size designSize = defaultSize,
    bool allowFontScaling = false,
  }) {
    _instance ??= ScreenUtil._();
    _instance
      ..uiSize = designSize
      ..allowFontScaling = allowFontScaling;
  }

  /// 每个逻辑像素的字体像素数，字体的缩放比例
  /// The number of font pixels for each logical pixel.
  double get textScaleFactor => _textScaleFactor;

  /// 设备的像素密度
  /// The size of the media in logical pixels (e.g, the size of the screen).
  double get pixelRatio => _pixelRatio;

  /// 当前设备宽度 dp
  /// The horizontal extent of this size.
  double get screenWidth => _screenWidth;

  ///当前设备高度 dp
  ///The vertical extent of this size. dp
  double get screenHeight => _screenHeight;

  /// 当前设备宽度 px
  /// The vertical extent of this size. px
  double get screenWidthPx => _screenWidth * _pixelRatio;

  /// 当前设备高度 px
  /// The vertical extent of this size. px
  double get screenHeightPx => _screenHeight * _pixelRatio;

  /// 状态栏高度 dp 刘海屏会更高
  /// The offset from the top
  double get statusBarHeight => _statusBarHeight;

  /// 底部安全区距离 dp
  /// The offset from the bottom.
  double get bottomBarHeight => _bottomBarHeight;

  /// 实际的dp与UI设计px的比例
  /// The ratio of the actual dp to the design draft px
  double get scaleWidth => _screenWidth / uiSize.width;

  double get scaleHeight => _screenHeight / uiSize.height;

  double get scaleText => scaleWidth;

  /// 根据UI设计的设备宽度适配
  /// 高度也可以根据这个来做适配可以保证不变形,比如你先要一个正方形的时候.
  /// Adapted to the device width of the UI Design.
  /// Height can also be adapted according to this to ensure no deformation ,
  /// if you want a square
  num setWidth(num width) => width * scaleWidth;

  /// 根据UI设计的设备高度适配
  /// 当发现UI设计中的一屏显示的与当前样式效果不符合时,
  /// 或者形状有差异时,建议使用此方法实现高度适配.
  /// 高度适配主要针对想根据UI设计的一屏展示一样的效果
  /// Highly adaptable to the device according to UI Design
  /// It is recommended to use this method to achieve a high degree of adaptation
  /// when it is found that one screen in the UI design
  /// does not match the current style effect, or if there is a difference in shape.
  num setHeight(num height) => height * scaleHeight;

  ///字体大小适配方法
  ///@param [fontSize] UI设计上字体的大小,单位px.
  ///Font size adaptation method
  ///@param [fontSize] The size of the font on the UI design, in px.
  ///@param [allowFontScaling]
  num setSp(num fontSize, {bool allowFontScalingSelf}) =>
      allowFontScalingSelf == null
          ? (allowFontScaling
              ? (fontSize * scaleText)
              : ((fontSize * scaleText) / _textScaleFactor))
          : (allowFontScalingSelf
              ? (fontSize * scaleText)
              : ((fontSize * scaleText) / _textScaleFactor));
}
