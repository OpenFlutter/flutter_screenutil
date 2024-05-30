import 'package:flutter/widgets.dart';

import '../models/data.dart';
import '../models/options.dart';
import '../utils/scaler.dart';
import '../widgets/screen_util_provider.dart';

class ScreenUtil extends StatefulWidget {
  const ScreenUtil({
    super.key,
    this.scaler = const DefaultScreenUtilScaler(),
    required this.options,
    required this.child,
  });

  final ScreenUtilScaler scaler;
  final ScreenUtilOptions options;
  final Widget child;

  static double sp(BuildContext context, num fontSize) {
    return ScreenUtilProvider.fontSizeScaleOf(context) * fontSize;
  }

  static double w(BuildContext context, num width) {
    return ScreenUtilProvider.widthScaleOf(context) * width;
  }

  static double h(BuildContext context, num height) {
    return ScreenUtilProvider.heightScaleOf(context) * height;
  }

  static double r(BuildContext context, num radius) {
    return ScreenUtilProvider.radiusScaleOf(context) * radius;
  }

  static double i(BuildContext context, num inset) {
    return ScreenUtilProvider.insetScaleOf(context) * inset;
  }

  @override
  State<ScreenUtil> createState() => _ScreenUtilState();
}

class _ScreenUtilState extends State<ScreenUtil> {
  @override
  Widget build(BuildContext context) {
    if (!widget.options.enable) {
      return ScreenUtilProvider(
        data: const EmptyScreenUtilData(),
        child: widget.child,
      );
    }

    final screenUtilData = ScreenUtilData.fromContext(
      context: context,
      options: widget.options,
      scaler: widget.scaler,
    );

    return ScreenUtilProvider(
      data: screenUtilData,
      child: widget.child,
    );
  }
}
