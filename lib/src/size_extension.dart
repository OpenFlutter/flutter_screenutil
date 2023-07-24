import 'dart:math';

import 'package:flutter/material.dart';

import 'screen_util.dart';

extension SizeExtension on num {
  ///[ScreenUtil.setWidth]
  @Deprecated('not used anymore')
  double get w => ScreenUtil().setWidth(this);

  @Deprecated('not used anymore')

  ///[ScreenUtil.setHeight]
  double get h => ScreenUtil().setHeight(this);
  @Deprecated('not used anymore')

  ///[ScreenUtil.radius]
  double get r => ScreenUtil().radius(this);
  @Deprecated('not used anymore')

  ///[ScreenUtil.diagonal]
  double get dg => ScreenUtil().diagonal(this);
  @Deprecated('not used anymore')

  ///[ScreenUtil.diameter]
  double get dm => ScreenUtil().diameter(this);
  @Deprecated('not used anymore')

  ///[ScreenUtil.setSp]
  double get sp => ScreenUtil().setSp(this);
  @Deprecated('not used anymore')

  ///smart size :  it check your value - if it is bigger than your value it will set your value
  ///for example, you have set 16.sm() , if for your screen 16.sp() is bigger than 16 , then it will set 16 not 16.sp()
  ///I think that it is good for save size balance on big sizes of screen
  double get spMin => min(toDouble(), sp);

  @Deprecated('use spMin instead')
  double get sm => min(toDouble(), sp);
  @Deprecated('not used anymore')
  double get spMax => max(toDouble(), sp);
  @Deprecated('not used anymore')

  ///屏幕宽度的倍数
  ///Multiple of screen width
  double get sw => ScreenUtil().screenWidth * this;
  @Deprecated('not used anymore')

  ///屏幕高度的倍数
  ///Multiple of screen height
  double get sh => ScreenUtil().screenHeight * this;
  @Deprecated('not used anymore')

  ///[ScreenUtil.setHeight]
  SizedBox get verticalSpace => ScreenUtil().setVerticalSpacing(this);
  @Deprecated('not used anymore')

  ///[ScreenUtil.setVerticalSpacingFromWidth]
  SizedBox get verticalSpaceFromWidth =>
      ScreenUtil().setVerticalSpacingFromWidth(this);
  @Deprecated('not used anymore')

  ///[ScreenUtil.setWidth]
  SizedBox get horizontalSpace => ScreenUtil().setHorizontalSpacing(this);
  @Deprecated('not used anymore')

  ///[ScreenUtil.radius]
  SizedBox get horizontalSpaceRadius =>
      ScreenUtil().setHorizontalSpacingRadius(this);
  @Deprecated('not used anymore')

  ///[ScreenUtil.radius]
  SizedBox get verticalSpacingRadius =>
      ScreenUtil().setVerticalSpacingRadius(this);
  @Deprecated('not used anymore')

  ///[ScreenUtil.diameter]
  SizedBox get horizontalSpaceDiameter =>
      ScreenUtil().setHorizontalSpacingDiameter(this);
  @Deprecated('not used anymore')

  ///[ScreenUtil.diameter]
  SizedBox get verticalSpacingDiameter =>
      ScreenUtil().setVerticalSpacingDiameter(this);
  @Deprecated('not used anymore')

  ///[ScreenUtil.diagonal]
  SizedBox get horizontalSpaceDiagonal =>
      ScreenUtil().setHorizontalSpacingDiagonal(this);
  @Deprecated('not used anymore')

  ///[ScreenUtil.diagonal]
  SizedBox get verticalSpacingDiagonal =>
      ScreenUtil().setVerticalSpacingDiagonal(this);
}

extension EdgeInsetsExtension on EdgeInsets {
  @Deprecated('not used anymore')

  /// Creates adapt insets using r [SizeExtension].
  EdgeInsets get r => copyWith(
        top: top.r,
        bottom: bottom.r,
        right: right.r,
        left: left.r,
      );
  @Deprecated('not used anymore')
  EdgeInsets get dm => copyWith(
        top: top.dm,
        bottom: bottom.dm,
        right: right.dm,
        left: left.dm,
      );
  @Deprecated('not used anymore')
  EdgeInsets get dg => copyWith(
        top: top.dg,
        bottom: bottom.dg,
        right: right.dg,
        left: left.dg,
      );
  @Deprecated('not used anymore')
  EdgeInsets get w => copyWith(
        top: top.w,
        bottom: bottom.w,
        right: right.w,
        left: left.w,
      );
  @Deprecated('not used anymore')
  EdgeInsets get h => copyWith(
        top: top.h,
        bottom: bottom.h,
        right: right.h,
        left: left.h,
      );
}

extension BorderRaduisExtension on BorderRadius {
  @Deprecated('not used anymore')

  /// Creates adapt BorderRadius using r [SizeExtension].
  BorderRadius get r => copyWith(
        bottomLeft: bottomLeft.r,
        bottomRight: bottomRight.r,
        topLeft: topLeft.r,
        topRight: topRight.r,
      );
  @Deprecated('not used anymore')
  BorderRadius get w => copyWith(
        bottomLeft: bottomLeft.w,
        bottomRight: bottomRight.w,
        topLeft: topLeft.w,
        topRight: topRight.w,
      );
  @Deprecated('not used anymore')
  BorderRadius get h => copyWith(
        bottomLeft: bottomLeft.h,
        bottomRight: bottomRight.h,
        topLeft: topLeft.h,
        topRight: topRight.h,
      );
}

extension RaduisExtension on Radius {
  @Deprecated('not used anymore')

  /// Creates adapt Radius using r [SizeExtension].
  Radius get r => Radius.elliptical(x.r, y.r);
  @Deprecated('not used anymore')
  Radius get dm => Radius.elliptical(x.dm, y.dm);
  @Deprecated('not used anymore')
  Radius get dg => Radius.elliptical(x.dg, y.dg);
  @Deprecated('not used anymore')
  Radius get w => Radius.elliptical(x.w, y.w);
  @Deprecated('not used anymore')
  Radius get h => Radius.elliptical(x.h, y.h);
}

extension BoxConstraintsExtension on BoxConstraints {
  @Deprecated('not used anymore')

  /// Creates adapt BoxConstraints using r [SizeExtension].
  BoxConstraints get r => this.copyWith(
        maxHeight: maxHeight.r,
        maxWidth: maxWidth.r,
        minHeight: minHeight.r,
        minWidth: minWidth.r,
      );
  @Deprecated('not used anymore')

  /// Creates adapt BoxConstraints using h-w [SizeExtension].
  BoxConstraints get hw => this.copyWith(
        maxHeight: maxHeight.h,
        maxWidth: maxWidth.w,
        minHeight: minHeight.h,
        minWidth: minWidth.w,
      );
  @Deprecated('not used anymore')
  BoxConstraints get w => this.copyWith(
        maxHeight: maxHeight.w,
        maxWidth: maxWidth.w,
        minHeight: minHeight.w,
        minWidth: minWidth.w,
      );
  @Deprecated('not used anymore')
  BoxConstraints get h => this.copyWith(
        maxHeight: maxHeight.h,
        maxWidth: maxWidth.h,
        minHeight: minHeight.h,
        minWidth: minWidth.h,
      );
}
