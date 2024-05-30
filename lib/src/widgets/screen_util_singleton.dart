import 'package:flutter/widgets.dart';

import '../models/data.dart';
import '../models/options.dart';
import '../utils/scaler.dart';
import '../widgets/screen_util_provider.dart';

abstract class ScreenUtilKeyProvider {
  const ScreenUtilKeyProvider._();

  static GlobalObjectKey<_ScreenUtilSingletonState>? _key;

  static GlobalObjectKey<_ScreenUtilSingletonState> get key {
    return _key ??= const GlobalObjectKey<_ScreenUtilSingletonState>(
        'flutter_screenutil_key');
  }
}

class ScreenUtilSingleton extends StatelessWidget {
  const ScreenUtilSingleton({
    Key? key,
    this.scaler = const DefaultScreenUtilScaler(),
    required this.options,
    required this.child,
  }) : super(key: key);

  final ScreenUtilScaler scaler;
  final ScreenUtilOptions options;
  final Widget child;

  static void addDependent(BuildContext context) {
    ScreenUtilProvider.of(context);
  }

  static double sp(num fontSize) {
    return ScreenUtilKeyProvider.key.currentState!.data.sp(fontSize);
  }

  static double w(num width) {
    return ScreenUtilKeyProvider.key.currentState!.data.w(width);
  }

  static double h(num height) {
    return ScreenUtilKeyProvider.key.currentState!.data.h(height);
  }

  static double r(num radius) {
    return ScreenUtilKeyProvider.key.currentState!.data.r(radius);
  }

  static double i(num inset) {
    return ScreenUtilKeyProvider.key.currentState!.data.i(inset);
  }

  @override
  Widget build(BuildContext context) {
    return _ScreenUtilSingleton(
      key: ScreenUtilKeyProvider.key,
      scaler: scaler,
      options: options,
      child: child,
    );
  }
}

class _ScreenUtilSingleton extends StatefulWidget {
  const _ScreenUtilSingleton({
    super.key,
    required this.scaler,
    required this.options,
    required this.child,
  });

  final ScreenUtilScaler scaler;
  final ScreenUtilOptions options;
  final Widget child;

  @override
  State<_ScreenUtilSingleton> createState() => _ScreenUtilSingletonState();
}

class _ScreenUtilSingletonState extends State<_ScreenUtilSingleton> {
  ScreenUtilData _data = const EmptyScreenUtilData();
  ScreenUtilData get data => _data;

  ScreenUtilData _calculateData() {
    if (!widget.options.enable) {
      return const EmptyScreenUtilData();
    }

    return ScreenUtilData.fromContext(
      context: context,
      options: widget.options,
      scaler: widget.scaler,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final data = _calculateData();
    if (_data != data) setState(() => _data = data);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilProvider(
      data: _data,
      child: widget.child,
    );
  }
}
