/*
 * Created by 李卓原 on 2018/9/29.
 * email: zhuoyuan93@gmail.com
 */
part of flutter_screenutil;

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
  late BuildContext? context;

  ScreenUtil._();

  factory ScreenUtil() {
    return _instance;
  }

  static void setContext(BuildContext context) {
    _instance.context = context;
  }

  static void init(
    BoxConstraints constraints, {
    BuildContext? context,
    Orientation orientation = Orientation.portrait,
    Size designSize = defaultSize,
    bool splitScreenMode = false,
    bool minTextAdapt = false,
  }) {
    _instance = ScreenUtil._()
      ..uiSize = designSize
      .._minTextAdapt = minTextAdapt
      .._orientation = orientation
      .._screenWidth = constraints.maxWidth
      .._screenHeight = splitScreenMode
          ? max(constraints.maxHeight, 700)
          : constraints.maxHeight;
    if (context != null) setContext(context);
  }

  ///获取屏幕方向
  ///Get screen orientation
  Orientation get orientation => _orientation;

  /// 每个逻辑像素的字体像素数，字体的缩放比例
  /// The number of font pixels for each logical pixel.
  double get textScaleFactor => MediaQuery.of(context!).textScaleFactor;

  /// 设备的像素密度
  /// The size of the media in logical pixels (e.g, the size of the screen).
  double? get pixelRatio => MediaQuery.of(context!).devicePixelRatio;

  /// 当前设备宽度 dp
  /// The horizontal extent of this size.
  double get screenWidth =>
      context == null ? _screenWidth : MediaQuery.of(context!).size.width;

  ///当前设备高度 dp
  ///The vertical extent of this size. dp
  double get screenHeight =>
      context == null ? _screenHeight : MediaQuery.of(context!).size.height;

  /// 状态栏高度 dp 刘海屏会更高
  /// The offset from the top, in dp
  double get statusBarHeight => MediaQuery.of(context!).padding.top;

  /// 底部安全区距离 dp
  /// The offset from the bottom, in dp
  double get bottomBarHeight => MediaQuery.of(context!).padding.bottom;

  /// 实际尺寸与UI设计的比例
  /// The ratio of actual width to UI design
  double get scaleWidth => _screenWidth / uiSize.width;

  ///  /// The ratio of actual height to UI design
  double get scaleHeight => _screenHeight / uiSize.height;

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
}
