import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import './extensions.dart';
import '../widgets/screen_util_provider.dart';

class RStatelessElement extends ComponentElement {
  RStatelessElement(RStatelessWidget super.widget);

  @override
  Widget build() {
    final data = ScreenUtilProvider.of(this);
    return (widget as RStatelessWidget)
        .build(this, data.sp, data.w, data.h, data.r, data.i);
  }
}

abstract class RStatelessWidget extends Widget {
  const RStatelessWidget({super.key});

  @override
  Element createElement() {
    return RStatelessElement(this);
  }

  Widget build(
    BuildContext context,
    double Function(num) sp,
    double Function(num) w,
    double Function(num) h,
    double Function(num) r,
    double Function(num) i,
  );
}

class MyStatelessWidget extends RStatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(
    BuildContext context,
    double Function(num) sp,
    double Function(num) w,
    double Function(num) h,
    double Function(num) r,
    double Function(num) i,
  ) {
    return Container(
      width: w(100),
      height: h(100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(r(10)),
      ),
      margin: EdgeInsets.all(i(10)),
      child: Center(
        child: Text(
          'Hello World',
          style: TextStyle(fontSize: sp(16)),
        ),
      ),
    );
  }

  // double sp(num fontSize) =>
  //     ScreenUtilProvider.of((key as GlobalKey).currentContext).sp(fontSize);
  // double w(num width) => ScreenUtilProvider.of(context).w(width);
  // double h(num height) => ScreenUtilProvider.of(context).h(height);
  // double r(num radius) => ScreenUtilProvider.of(context).r(radius);
  // double i(num padding) => ScreenUtilProvider.of(context).i(padding);
}

class RSizedBox extends SizedBox {
  const RSizedBox({
    super.key,
    super.width,
    super.height,
    super.child,
  });

  @override
  RenderConstrainedBox createRenderObject(BuildContext context) {
    return RenderConstrainedBox(
      additionalConstraints: _additionalConstraints(context),
    );
  }

  BoxConstraints _additionalConstraints(BuildContext context) {
    return BoxConstraints.tightFor(
      width: width != null ? context.w(width!) : width,
      height: height != null ? context.h(height!) : height,
    );
  }
}

class RPadding extends Padding {
  const RPadding({
    super.key,
    required super.padding,
    super.child,
  });

  @override
  RenderPadding createRenderObject(BuildContext context) {
    return RenderPadding(
      padding: padding * context.i(1),
      textDirection: Directionality.maybeOf(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderPadding renderObject) {
    renderObject
      ..padding = padding * context.i(1)
      ..textDirection = Directionality.maybeOf(context);
  }
}
