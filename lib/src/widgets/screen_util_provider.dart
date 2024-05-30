import 'package:flutter/widgets.dart';

import '../models/data.dart';

enum _ScreenUtilProviderAspect {
  font,
  width,
  height,
  radius,
  inset,
}

class ScreenUtilProvider extends InheritedModel<_ScreenUtilProviderAspect> {
  ScreenUtilProvider({
    super.key,
    required this.data,
    required super.child,
  });

  final ScreenUtilData data;

  @override
  bool updateShouldNotify(covariant ScreenUtilProvider oldWidget) {
    return data != oldWidget.data;
  }

  static ScreenUtilData? _maybeOf(
    BuildContext context, [
    _ScreenUtilProviderAspect? aspect,
  ]) {
    return InheritedModel.inheritFrom<ScreenUtilProvider>(
      context,
      aspect: aspect,
    )?.data;
  }

  static ScreenUtilData? maybeOf(BuildContext context) {
    return _maybeOf(context);
  }

  static ScreenUtilData _of(
    BuildContext context, [
    _ScreenUtilProviderAspect? aspect,
  ]) {
    return _maybeOf(context, aspect)!;
  }

  static ScreenUtilData of(BuildContext context) {
    return _of(context);
  }

  static double fontSizeScaleOf(BuildContext context) {
    return _of(context, _ScreenUtilProviderAspect.font).fontSizeScale;
  }

  static double widthScaleOf(BuildContext context) {
    final widthScale = _of(context, _ScreenUtilProviderAspect.width).widthScale;
    print('widthScaleOf: $widthScale');
    return widthScale;
  }

  static double heightScaleOf(BuildContext context) {
    return _of(context, _ScreenUtilProviderAspect.height).heightScale;
  }

  static double radiusScaleOf(BuildContext context) {
    return _of(context, _ScreenUtilProviderAspect.radius).radiusScale;
  }

  static double insetScaleOf(BuildContext context) {
    return _of(context, _ScreenUtilProviderAspect.inset).insetScale;
  }

  @override
  bool updateShouldNotifyDependent(
    covariant ScreenUtilProvider oldWidget,
    Set<_ScreenUtilProviderAspect> dependencies,
  ) {
    for (final Object dependency in dependencies) {
      if (dependency is _ScreenUtilProviderAspect) {
        switch (dependency) {
          case _ScreenUtilProviderAspect.font:
            return data.fontSizeScale != oldWidget.data.fontSizeScale;
          case _ScreenUtilProviderAspect.width:
            return data.widthScale != oldWidget.data.widthScale;
          case _ScreenUtilProviderAspect.height:
            return data.heightScale != oldWidget.data.heightScale;
          case _ScreenUtilProviderAspect.radius:
            return data.radiusScale != oldWidget.data.radiusScale;
          case _ScreenUtilProviderAspect.inset:
            return data.insetScale != oldWidget.data.insetScale;
        }
      }
    }

    return false;
  }
}
