
# flutter_screenutil
[![pub package](https://img.shields.io/pub/v/flutter_screenutil.svg)](https://pub.dartlang.org/packages/flutter_screenutil)

**A flutter plugin for adapting screen and font size.Let your UI display a reasonable layout on different screen sizes!**

*Note*: This plugin is still under development, and some APIs might not be available yet.

[中文文档](https://github.com/OpenFlutter/flutter_screenutil/blob/master/README_CN.md)  

[README em Português](https://github.com/OpenFlutter/flutter_screenutil/blob/master/README_PT.md)

github: https://github.com/OpenFlutter/flutter_screenutil

[Update log](/CHANGELOG.md)

## Usage:

### Add dependency：
Please check the latest version before installation.
If there is any problem with the new version, please use the previous version
```
dependencies:
  flutter:
    sdk: flutter
  # add flutter_screenutil
  flutter_screenutil: ^2.1.0
```

### Add the following imports to your Dart code:
```
import 'package:flutter_screenutil/flutter_screenutil.dart';
```

### Property
   
|Property|Type|Default Value|Description|
|:---|:---|:---|:---| 
|width|double|1080px|The width of the device in the design draft, in px|
|height|double|1920px|The height of the device in the design draft, in px|
|allowFontScaling|bool|false|Sets whether the font size is scaled according to the system's "font size" assist option|

### Initialize and set the fit size and font size to scale according to the system's "font size" accessibility option
Please set the width and height of the design draft before use, the width and height of the design draft (unit px).
Be sure to set the page in the MaterialApp's home(ie the entry file, just set it once) to ensure that the fit size is set before each use:

```dart

//fill in the screen size of the device in the design

//default value : width : 1080px , height:1920px , allowFontScaling:false
ScreenUtil.init(context);        //flutter_screenuitl < 1.2
ScreenUtil.init();               //flutter_screenuitl >= 1.2

//If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
ScreenUtil.init(context, width: 750, height: 1334); //flutter_screenuitl < 1.2
ScreenUtil.init(width: 750, height: 1334);          //flutter_screenuitl >= 1.2

//If you want to set the font size is scaled according to the system's "font size" assist option
ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);    //flutter_screenuitl < 1.2
ScreenUtil.init(width: 750, height: 1334, allowFontScaling: true);             //flutter_screenuitl >= 1.2

```

### Use：

### API

```dart
    ScreenUtil().setWidth(540)  (sdk>=2.6 : 540.w) //Adapted to screen width
    ScreenUtil().setHeight(200) (sdk>=2.6 : 200.h) //Adapted to screen height
    ScreenUtil().setSp(24)      (sdk>=2.6 : 24.sp)  //Adapter font
    ScreenUtil().setSp(24, allowFontScalingSelf: true)  (sdk>=2.6 : 24.ssp) //Adapter font(fonts will scale to respect Text Size accessibility settings)
    ScreenUtil().setSp(24, allowFontScalingSelf: false)  (sdk>=2.6 : 24.nsp) //Adapter font(fonts will not scale to respect Text Size accessibility settings)

    ScreenUtil.pixelRatio       //Device pixel density
    ScreenUtil.screenWidth      //Device width
    ScreenUtil.screenHeight     //Device height
    ScreenUtil.bottomBarHeight  //Bottom safe zone distance, suitable for buttons with full screen
    ScreenUtil.statusBarHeight  //Status bar height , Notch will be higher Unit px
    ScreenUtil.textScaleFactor  //System font scaling factor

    ScreenUtil().scaleWidth //Ratio of actual width dp to design draft px
    ScreenUtil().scaleHeight //Ratio of actual height dp to design draft px
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

Height is also adapted according to setWidth to ensure no deformation (when you want a square) 

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
           height: ScreenUtil().setWidth(300),
            ),
            
```

#### Adapter font:
``` dart
//Incoming font size，the unit is pixel, fonts will not scale to respect Text Size accessibility settings
//(AllowallowFontScaling when initializing ScreenUtil)
ScreenUtil().setSp(28)    
     
//Incoming font size，the unit is pixel，fonts will scale to respect Text Size accessibility settings
//(If somewhere does not follow the global allowFontScaling setting)
ScreenUtil().setSp(24, allowFontScalingSelf: true)

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

```dart
//import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter_ScreenUtil',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //Set the fit size (fill in the screen size of the device in the design) If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(width: 750, height: 1334, allowFontScaling: false);

    return ExampleWidget(title: 'FlutterScreenUtil Demo');
  }
}

class ExampleWidget extends StatefulWidget {
  const ExampleWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ExampleWidgetState createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  @override
  Widget build(BuildContext context) {
    printScreenInformation();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                  width: ScreenUtil().setWidth(375),
                  height: ScreenUtil().setHeight(200),
                  color: Colors.red,
                  child: Text(
                    'My width:${ScreenUtil().setWidth(375)}dp \n'
                    'My height:${ScreenUtil().setHeight(200)}dp',
                    style: TextStyle(
                        color: Colors.white, fontSize: ScreenUtil().setSp(24)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                  width: ScreenUtil().setWidth(375),
                  height: ScreenUtil().setHeight(200),
                  color: Colors.blue,
                  child: Text(
                      'My width:${ScreenUtil().setWidth(375)}dp \n'
                      'My height:${ScreenUtil().setHeight(200)}dp',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(24))),
                ),
              ],
            ),
            Text('Device width:${ScreenUtil.screenWidth}dp'),
            Text('Device height:${ScreenUtil.screenHeight}dp'),
            Text('Device width:${ScreenUtil.screenWidthPx}px'),
            Text('Device height:${ScreenUtil.screenHeightPx}px'),
            Text('Device pixel density:${ScreenUtil.pixelRatio}'),
            Text('Bottom safe zone distance:${ScreenUtil.bottomBarHeight}dp'),
            Text('Status bar height:${ScreenUtil.statusBarHeight}dp'),
            Text(
              'Ratio of actual width dp to design draft px:${ScreenUtil().scaleWidth}',
              textAlign: TextAlign.center,
            ),
            Text(
              'Ratio of actual height dp to design draft px:${ScreenUtil().scaleHeight}',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: ScreenUtil().setHeight(100),
            ),
            Text('System font scaling factor:${ScreenUtil.textScaleFactor}'),
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.title),
        onPressed: () {
          ScreenUtil.init(width: 1500, height: 1334, allowFontScaling: false);
          setState(() {});
        },
      ),
    );
  }

  void printScreenInformation() {
    print('Device width dp:${ScreenUtil.screenWidth}'); //Device width
    print('Device height dp:${ScreenUtil.screenHeight}'); //Device height
    print(
        'Device pixel density:${ScreenUtil.pixelRatio}'); //Device pixel density
    print(
        'Bottom safe zone distance dp:${ScreenUtil.bottomBarHeight}'); //Bottom safe zone distance，suitable for buttons with full screen
    print(
        'Status bar height dp:${ScreenUtil.statusBarHeight}dp'); //Status bar height , Notch will be higher Unit dp
    print(
        'Ratio of actual width dp to design draft px:${ScreenUtil().scaleWidth}');
    print(
        'Ratio of actual height dp to design draft px:${ScreenUtil().scaleHeight}');
    print(
        'The ratio of font and width to the size of the design:${ScreenUtil().scaleWidth * ScreenUtil.pixelRatio}');
    print(
        'The ratio of  height width to the size of the design:${ScreenUtil().scaleHeight * ScreenUtil.pixelRatio}');
  }
}

```

### example:

[example demo](/example/lib/main.dart)
 
effect:

![effect](demo_en.png)
![tablet effect](demo_tablet_en.png)
