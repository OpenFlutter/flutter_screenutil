import 'package:flutter/widgets.dart';

import '../widgets/screen_util_provider.dart';
import '../widgets/screen_util_singleton.dart';

extension ScreenUtilContextExtension on BuildContext {
  double sp(num fontSize) =>
      ScreenUtilProvider.fontSizeScaleOf(this) * fontSize;
  double w(num width) => ScreenUtilProvider.widthScaleOf(this) * width;
  double h(num height) => ScreenUtilProvider.heightScaleOf(this) * height;
  double r(num radius) => ScreenUtilProvider.radiusScaleOf(this) * radius;
  double i(num inset) => ScreenUtilProvider.insetScaleOf(this) * inset;
}

extension ScreenUtilWidgetExtension<T extends StatefulWidget> on State<T> {
  double sp(num fontSize) =>
      ScreenUtilProvider.fontSizeScaleOf(context) * fontSize;
  double w(num width) => ScreenUtilProvider.widthScaleOf(context) * width;
  double h(num height) => ScreenUtilProvider.heightScaleOf(context) * height;
  double r(num radius) => ScreenUtilProvider.radiusScaleOf(context) * radius;
  double i(num inset) => ScreenUtilProvider.insetScaleOf(context) * inset;
}

extension ScreenUtilSingletonExtension on num {
  double get sp => ScreenUtilSingleton.sp(this);
  double get w => ScreenUtilSingleton.w(this);
  double get h => ScreenUtilSingleton.h(this);
  double get r => ScreenUtilSingleton.r(this);
  double get i => ScreenUtilSingleton.i(this);
}

extension ScreenUtilSingletonContextExtension on BuildContext {
  void su() {
    ScreenUtilSingleton.addDependent(this);
  }
}
