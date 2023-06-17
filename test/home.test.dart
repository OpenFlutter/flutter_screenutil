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
    return LayoutBuilder(
      builder: (_, c) {
        final w = width(), h = height();

        if (c.biggest >= Size(w, h)) {
          return const Text('Test');
        }

        throw Error();
      },
    );
  }

  static double _zero() => 0;
}
