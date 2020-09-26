# flutter_screenutil
[![pub package](https://img.shields.io/pub/v/flutter_screenutil.svg)](https://pub.dev/packages/flutter_screenutil)

**A flutter plugin for adapting screen and font size.Let your UI display a reasonable layout on different screen sizes!**

*Note*: This plugin is still under development, and some APIs might not be available yet.

[中文文档](https://github.com/OpenFlutter/flutter_screenutil/blob/master/README_CN.md)  

[README em Português](https://github.com/OpenFlutter/flutter_screenutil/blob/master/README_PT.md)

[github](https://github.com/OpenFlutter/flutter_screenutil)

[Update log](https://github.com/OpenFlutter/flutter_screenutil/blob/master/CHANGELOG.md)

## Usage:

### Add dependency：
Please check the latest version before installation.
If there is any problem with the new version, please use the previous version
```
dependencies:
  flutter:
    sdk: flutter
  # add flutter_screenutil
  flutter_screenutil: ^3.1.0
```
### Add the following imports to your Dart code:
```
import 'package:flutter_screenutil/flutter_screenutil.dart';
```

### Property
   
|Property|Type|Default Value|Description|
|:---|:---|:---|:---| 
|designSize|Size|Size(1080, 1920)|The size of the device in the design draft, in px|
|allowFontScaling|bool|false|Sets whether the font size is scaled according to the system's "font size" assist option|

### Initialize and set the fit size and font size to scale according to the system's "font size" accessibility option
Please set the size of the design draft before use, the width and height of the design draft (unit px).

```

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //Set the fit size (fill in the screen size of the device in the design) If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
  ScreenUtil.init(designSize: Size(750, 1334), allowFontScaling: false);
  runApp(MyApp());
}

//fill in the screen size of the device in the design

//default value : width : 1080px , height:1920px , allowFontScaling:false
ScreenUtil.init(context);

//If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
ScreenUtil.init(context, designSize: Size(750, 1334));

//If you want to set the font size is scaled according to the system's "font size" assist option
ScreenUtil.init(context, designSize: Size(750, 1334), allowFontScaling: true);

```

### Use：

### API

#### Pass the px size of the design draft

```dart
    ScreenUtil().setWidth(540)  (sdk>=2.6 : 540.w) //Adapted to screen width
    ScreenUtil().setHeight(200) (sdk>=2.6 : 200.h) //Adapted to screen height
    ScreenUtil().setSp(24)      (sdk>=2.6 : 24.sp)  //Adapter font
    ScreenUtil().setSp(24, allowFontScalingSelf: true)  (sdk>=2.6 : 24.ssp) //Adapter font(fonts will scale to respect Text Size accessibility settings)
    ScreenUtil().setSp(24, allowFontScalingSelf: false)  (sdk>=2.6 : 24.nsp) //Adapter font(fonts will not scale to respect Text Size accessibility settings)

    ScreenUtil().pixelRatio       //Device pixel density
    ScreenUtil().screenWidth   (sdk>=2.6 : 1.wp)    //Device width
    ScreenUtil().screenHeight  (sdk>=2.6 : 1.hp)    //Device height
    ScreenUtil().bottomBarHeight  //Bottom safe zone distance, suitable for buttons with full screen
    ScreenUtil().statusBarHeight  //Status bar height , Notch will be higher Unit px
    ScreenUtil().textScaleFactor  //System font scaling factor

    ScreenUtil().scaleWidth //Ratio of actual width dp to design draft px
    ScreenUtil().scaleHeight //Ratio of actual height dp to design draft px

    0.2.wp  //0.2 times the screen width
    0.5.hp  //50% of screen height
```

#### Adapt screen size：

Pass the px size of the design draft：

Adapted to screen width: `ScreenUtil().setWidth(540)`,

Adapted to screen height: `ScreenUtil().setHeight(200)`,

If your dart sdk>=2.6, you can use extension functions:

example:

instead of :
```
Container(
width: ScreenUtil().setWidth(50),
height:ScreenUtil().setHeight(200),
)
```
you can use it like this:
```
Container(
width: 50.w,
height:200.h
)
```
**Note** 

The height can also use setWidth to ensure that it is not deformed(when you want a square)

setHeight method is mainly adapted in height, you want to control the height and actuality of a screen on the UIUsed when the same is displayed.

```dart
//for example:
//rectangle
Container(
           width: ScreenUtil().setWidth(375),
           height: ScreenUtil().setHeight(200),
           ...
            ),
            
////If you want to display a square:
Container(
           width: ScreenUtil().setWidth(300),
           height: 300.w,
            ),

```

#### Adapter font:
``` dart
//Incoming font size，the unit is pixel, fonts will not scale to respect Text Size accessibility settings
//(AllowallowFontScaling when initializing ScreenUtil)
ScreenUtil().setSp(28) 
28.sp   
     
//Incoming font size，the unit is pixel，fonts will scale to respect Text Size accessibility settings
//(If somewhere follow the global allowFontScaling setting)
ScreenUtil().setSp(24, allowFontScalingSelf: true)
28.ssp

//(If somewhere does not follow the global allowFontScaling setting)
ScreenUtil().setSp(24, allowFontScalingSelf: false)
28.nsp

//for example:
Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    'My font size is 24px on the design draft and will not change with the system.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(24),
                    )),
                Text(
                    'My font size is 24px on the design draft and will change with the system.',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil()
                            .setSp(24, allowFontScalingSelf: true))),
              ],
            )
```

[widget test](https://github.com/OpenFlutter/flutter_screenutil/issues/115)

### Example:

[example demo](/example/lib/main.dart)
 
### Effect:

![effect](demo_en.png)
![tablet effect](demo_tablet_en.png)
