# flutter_screenutil

[![Flutter Package](https://img.shields.io/pub/v/flutter_screenutil.svg)](https://pub.dev/packages/flutter_screenutil)
[![Pub Points](https://img.shields.io/pub/points/flutter_screenutil)](https://pub.dev/packages/flutter_screenutil/score)
[![Popularity](https://img.shields.io/pub/popularity/flutter_screenutil)](https://pub.dev/packages/flutter_screenutil/score)
[![CodeFactor](https://www.codefactor.io/repository/github/openflutter/flutter_screenutil/badge)](https://www.codefactor.io/repository/github/openflutter/flutter_screenutil)

**A flutter plugin for adapting screen and font size.Let your UI display a reasonable layout on different screen sizes!**

**Note**: *Starting from version 6, support for singleton usage will be experimental and might be removed. We recommend use context way*

**Note**: *This plugin is still under development, and some APIs might not be available yet.*

[中文文档](https://github.com/OpenFlutter/flutter_screenutil/blob/master/README_CN.md)  

[README em Português](https://github.com/OpenFlutter/flutter_screenutil/blob/master/README_PT.md)

[github](https://github.com/OpenFlutter/flutter_screenutil)

[Update log](https://github.com/OpenFlutter/flutter_screenutil/blob/master/CHANGELOG.md)

## Compatibility
This package is compatible with flutter 3.13+

## Usage

### 1) Add dependency

Please check the latest version before installation.
If there is any problem with the new version, please use the previous version

```yaml
dependencies:
  flutter:
    sdk: flutter
  # add flutter_screenutil
  flutter_screenutil: ^{latest version}
```

### 2) Add the following imports to your Dart code

```dart
import 'package:flutter_screenutil/flutter_screenutil.dart';
```

*Note: if you want to use version 5, add:*
```dart
import 'package:flutter_screenutil/v5/flutter_screenutil.dart';
```

### 3) Declare ScreenUtil on top of widget hierarchy

#### Use ScreenUtil directly (recommended)
```dart
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return ScreenUtil(
            options: const ScreenUtilOptions(
                designSize: Size(360, 690),
                fontFactorByWidth: 2.0,
                fontFactorByHeight: 1.0,
                flipSizeWhenLandscape: true,
            ),
            child: MaterialApp(
                ...,
                child: const MyAwesomeWidget(),
            ),
        );
    }
}

class MyAwesomeWidget extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return SafeArea(
            child: Padding(
                padding: EdgeInsets.all(context.i(20)),
                child: Text(
                    'This is awesome',
                    style: TextStyle(fontSize: context.sp(18)),
                ),
            ),
        );
    }
}
```

#### Usage of ScreenUtilSingleton (You must add `ScreenUtilSingleton.addDependent(context)` or `context.su()` for each widget that use this package)
```dart
class MyAppWithSingleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilSingleton(
      options: const ScreenUtilOptions(
        enable: true,
        designSize: Size(360, 690),
        fontFactorByWidth: 2.0,
        fontFactorByHeight: 1.0,
        flipSizeWhenLandscape: true,
      ),
      child: MaterialApp(
        ...,
        home: const MyHomeWithSingletonPage(),
      ),
    );
  }
}

class MyHomeWithSingletonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // THIS IS REQUIRED FOR EVERY WIDGET THAT USES ScreenUtilSingleton
    ScreenUtilSingleton.addDependent(context); // or context.su();

    return SafeArea(
        child: Padding(
            padding: EdgeInsets.all(context.i(20)),
            child: Text(
              'This is Awesome !',
              style: TextStyle(fontSize: 20.sp),
            ),
        ),
    );
  }
}
```

### Options

#### enable (boolean, default: true)
Either to enable or disable scaling

#### designSize (Size)
The size of the device screen in the design draft, in dp. This property is **required**.

#### minTextScale (double, default: 0.2)
Minimum text scale factor

#### maxTextScale (double, default: 4.0)
Maximum text scale factor

#### fontFactorByWidth (double, default 1.0)
The weighting factor for scaling fonts by the width of the screen

#### fontFactorByHeight (double, default: 1.0)
The weighting factor for scaling fonts by the height of the screen.

#### flipSizeWhenLandscape (boolean, default: false)
Whether to flip the size dimensions when the device is in landscape orientation.

#### fontScaleStrategy (ScreenUtilScaleStrategy, default: ScreenUtilScaleStrategy.both)
The strategy used for scaling fonts, which can be based on width, height, or both.

#### paddingScaleStrategy (ScreenUtilScaleStrategy, default: ScreenUtilScaleStrategy.both)
The strategy used for scaling padding, which can be based on width, height, or both.

#### widthScaleStrategy (ScreenUtilScaleStrategy, default: ScreenUtilScaleStrategy.width)
The strategy used for scaling widths, which can be based on width or height.

#### heightScaleStrategy (ScreenUtilScaleStrategy, default: ScreenUtilScaleStrategy.height)
The strategy used for scaling heights, which can be based on width or height.

### Why switch to InheritedModel instead of Singleton pattern ?
Well, the main reason, scaling factors keeps changing and we need to notify widgets for that change. Singleton method will trigger a rebuild for all of your widgets as it don't know which one to rebuild. That's why we recommend using the new way: InheritedModel. It keeps track of widgets you really need to rebuild and not the whole widget hierarchy.

#### &gt; Benifits:
- Minimize rebuilds
- You can use diffrent design size for each case, if you have widgets from other designs
- Very high performance, skipping all checks and loops through hierarchy

### API
Here some examples:
#### with ScreenUtil (recommended)
```dart
// Without extensions
ScreenUtil.sp(context, 18)  // Font Size
ScreenUtil.w(context, 18)   // Width
ScreenUtil.h(context, 18)   // Height
ScreenUtil.r(context, 18)   // radiusScaleOf <=> min(widthScaleOf, heightScaleOf)
ScreenUtil.i(context, 18)   // Insets

// With extensions
context.sp(18) // Font Size
context.w(18)  // Width
context.h(18)  // Height
context.r(18)  // radiusScaleOf <=> min(widthScaleOf, heightScaleOf)
context.i(18)  // Insets
```

#### with ScreenUtilSingleton (Experimental and can be removed in the future)
- **FOR EACH WIDGET THAT USE THIS PACKAGE, YOU MUST EITHER:**
    - use one of `ScreenUtil` methods/extensions above at least once
    - add `ScreenUtilSingleton.addDependent(context)`
    - add `context.su()` (extension)
```dart
// Without extensions
ScreenUtilSingleton.sp(18)
ScreenUtilSingleton.w(18)
ScreenUtilSingleton.h(18)
ScreenUtilSingleton.r(18)
ScreenUtilSingleton.i(18)

// With extensions
18.sp
18.w
18.h
18.r
18.i
```
