part of flutter_screenutil;

class ScreenUtilInit extends StatelessWidget {
  /// A helper widget that initializes [ScreenUtil]
  ScreenUtilInit({
    required this.builder,
    this.designSize = ScreenUtil.defaultSize,
    this.splitScreenMode = true,
    Key? key,
  }) : super(key: key);

  final Widget Function() builder;
  final bool splitScreenMode;

  /// The [Size] of the device in the design draft, in dp
  final Size designSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      if (splitScreenMode) {
        constraints = BoxConstraints(
            minHeight: constraints.minHeight,
            maxHeight: max(constraints.maxHeight, 700),
            minWidth: constraints.minWidth,
            maxWidth: constraints.maxWidth);
      }

      if (constraints.maxWidth != 0) {
        final Orientation orientation =
            constraints.maxWidth > constraints.maxHeight
                ? Orientation.landscape
                : Orientation.portrait;
        ScreenUtil.init(
          constraints,
          orientation: orientation,
          designSize: designSize,
        );
        return builder();
      }
      return Container();
    });
  }
}
