import 'package:flutter/widgets.dart';

class WidgetTest extends StatelessWidget {
  const WidgetTest({
    super.key,
    this.width = _zero,
    this.height = _zero,
  });

  final double Function() width;
  final double Function() height;

  @override
  Widget build(BuildContext context) {
    final w = width(), h = height();
    final screenSize = MediaQuery.sizeOf(context);

    if (w == 0) {
      if (h <= screenSize.height) {
        return const Text('Test');
      }
    } else if (h == 0) {
      if (w <= screenSize.width) {
        return const Text('Test');
      }
    }

    throw AssertionError('Overflow detected! ($w, $h) <= $screenSize');
  }

  static double _zero() => 0;
}
