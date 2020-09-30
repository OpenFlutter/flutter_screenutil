import 'package:flutter_screenutil/screenutil.dart';

extension SizeExtension on num {
  ///[ScreenUtil.setWidth]
  num get w => ScreenUtil().setWidth(this);

  ///[ScreenUtil.setHeight]
  num get h => ScreenUtil().setHeight(this);

  ///[ScreenUtil.setSp]
  num get sp => ScreenUtil().setSp(this);

  ///[ScreenUtil.setSp]
  num get ssp => ScreenUtil().setSp(this, allowFontScalingSelf: true);

  ///[ScreenUtil.setSp]
  num get nsp => ScreenUtil().setSp(this, allowFontScalingSelf: false);

  ///屏幕宽度的倍数
  ///Multiple of screen width
  num get wp => ScreenUtil().screenWidth * this;

  ///屏幕高度的倍数
  ///Multiple of screen height
  num get hp => ScreenUtil().screenHeight * this;
}
