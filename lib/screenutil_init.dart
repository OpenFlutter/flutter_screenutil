part of flutter_screenutil;

class ScreenUtilInit extends StatelessWidget {
  /// A helper widget that initializes [ScreenUtil]
  ScreenUtilInit({
    required this.builder,
    this.designSize = ScreenUtil.defaultSize,
    Key? key,
  }) : super(key: key);

  final Widget Function() builder;

  /// The [Size] of the device in the design draft, in dp
  final Size designSize;
  BoxConstraints constraints1 = BoxConstraints(maxHeight: 0.0);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      if (constraints.maxHeight > constraints1.maxHeight) {
        constraints1 = constraints;
      }
      if (constraints1.maxWidth != 0) {
        final Orientation orientation =
            constraints1.maxWidth > constraints1.maxHeight
                ? Orientation.landscape
                : Orientation.portrait;
        ScreenUtil.init(
          constraints1,
          orientation: orientation,
          designSize: designSize,
        );
        return builder();
      }
      return Container();
    });
  }
}
