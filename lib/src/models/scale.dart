class ScreenUtilScale {
  final double fontScale;
  final double widthScale;
  final double heightScale;
  final double paddingScale;

  const ScreenUtilScale({
    double? fontScale,
    double? widthScale,
    double? heightScale,
    double? paddingScale,
  })  : fontScale = fontScale == null || fontScale <= 0 ? 1 : fontScale,
        widthScale = widthScale == null || widthScale <= 0 ? 1 : widthScale,
        heightScale = heightScale == null || heightScale <= 0 ? 1 : heightScale,
        paddingScale =
            paddingScale == null || paddingScale <= 0 ? 1 : paddingScale;
}
