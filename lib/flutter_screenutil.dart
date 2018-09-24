/*
 * Created by 李卓原 on 2018/9/20.
 * email: zhuoyuan93@gmail.com
 * 设计稿设备尺寸默认为 1080 * 1920 px
 */

import 'dart:ui';

class ScreenUtil {
  //请修改成你的设计稿的尺寸
  static ScreenUtil instance = new ScreenUtil(width: 1080, height: 1920);

  //设计稿的设备尺寸修改
  int designWidth;
  int designHeight;

  ScreenUtil({int width, int height}) {
    designWidth = width;
    designHeight = height;
  }

  static ScreenUtil getInstance() {
    return instance;
  }

  //设备的像素密度
  static double pixelRatio = window.devicePixelRatio;

  //当前设备宽度 px
  static double screenWidth = window.physicalSize.width;

  //当前设备高度 px
  static double screenHeight = window.physicalSize.height;

  //状态栏高度 刘海屏会更高
  static double statusBarHeight = window.padding.top;

  //底部安全区距离
  static double bottomBarHeight = window.padding.bottom;

  //相对于设计稿放大的倍数
  double get scaleWidth => screenWidth / instance.designWidth / pixelRatio;

  double get scaleHeight => screenHeight / instance.designHeight / pixelRatio;

  /**
   * 根据设计稿的设备宽度适配
   * 高度也根据这个来做适配可以保证不变形
   */
  setWidth(int width) => width * scaleWidth;

  /**
   * 根据设计稿的设备高度适配
   * 当发现设计稿中的一屏显示的与当前样式效果不符合时,
   * 或者形状有差异时,高度适配建议使用此方法
   * 高度适配主要针对想根据设计稿的一屏展示一样的效果
   */
  setHeight(int height) => height * scaleHeight;
}
