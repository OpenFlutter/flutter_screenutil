# flutter_ScreenUtil

[![pub package](https://img.shields.io/pub/v/flutter_screenutil.svg)](https://pub.dartlang.org/packages/flutter_screenutil)

**flutter 屏幕适配方案，让你的UI在不同尺寸的屏幕上都能显示合理的布局!**


*注意*：此插件仍处于开发阶段，某些API可能尚未推出。

[README of English](https://github.com/OpenFlutter/flutter_ScreenUtil/blob/master/README.md)

[README em Português](https://github.com/OpenFlutter/flutter_screenutil/blob/master/README_PT.md)

[github](https://github.com/OpenFlutter/flutter_screenutil)

[csdn博客工具介绍](https://blog.csdn.net/u011272795/article/details/82795477)

[更新日志](https://github.com/OpenFlutter/flutter_screenutil/blob/master/CHANGELOG.md)

## 使用方法:

### 安装依赖：

安装之前请查看最新版本
新版本如有问题请使用上一版
```
dependencies:
  flutter:
    sdk: flutter
  # 添加依赖
  flutter_screenutil: ^4.0.0-beta
```
### 在每个使用的地方导入包：
```
import 'package:flutter_screenutil/flutter_screenutil.dart';
```

### 属性

|属性|类型|默认值|描述|
|:---|:---|:---|:---|
|designSize|Size|Size(1080, 1920)|设计稿中设备的尺寸(单位随意,但在使用过程中必须保持一致)|
|allowFontScaling|bool|false|设置字体大小是否根据系统的“字体大小”辅助选项来进行缩放|

### 初始化并设置适配尺寸及字体大小是否根据系统的“字体大小”辅助选项来进行缩放
在使用之前请设置好设计稿的宽度和高度，传入设计稿的宽度和高度(单位随意,但在使用过程中必须保持一致)
一定要进行初始化(只需设置一次),以保证在每次使用之前设置好了适配尺寸:

```
//填入设计稿中设备的屏幕尺寸

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 此处假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
        ScreenUtil.init(constraints, designSize: Size(750, 1334), allowFontScaling: false);

        return MaterialApp(
            ...
        );
      },
    );
  }
}
//默认 width : 1080px , height:1920px , allowFontScaling:false
ScreenUtil.init(constraints);

//假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334) 
ScreenUtil.init(constraints, designSize: Size(750, 1334));

//设置字体大小根据系统的“字体大小”辅助选项来进行缩放,默认为false
ScreenUtil.init(constraints, designSize: Size(750, 1334), allowFontScaling: true);
    
```

### 使用

### API
#### 传入设计稿的px尺寸 px px px ! 
```dart
    ScreenUtil().setWidth(540)  (sdk>=2.6 : 540.w) //根据屏幕宽度适配尺寸
    ScreenUtil().setHeight(200) (sdk>=2.6 : 200.h) //根据屏幕高度适配尺寸(一般根据宽度适配即可)
    ScreenUtil().setSp(24)      (sdk>=2.6 : 24.sp)  //适配字体
    ScreenUtil().setSp(24, allowFontScalingSelf: true)   (sdk>=2.6 : 24.ssp) //适配字体(根据系统的“字体大小”辅助选项来进行缩放)
    ScreenUtil().setSp(24, allowFontScalingSelf: false)  (sdk>=2.6 : 24.nsp) //适配字体(不会根据系统的“字体大小”辅助选项来进行缩放)

    ScreenUtil.pixelRatio       //设备的像素密度
    ScreenUtil.screenWidth   (sdk>=2.6 : 1.sw)   //设备宽度
    ScreenUtil.screenHeight  (sdk>=2.6 : 1.sh)   //设备高度
    ScreenUtil.bottomBarHeight  //底部安全区距离，适用于全面屏下面有按键的
    ScreenUtil.statusBarHeight  //状态栏高度 刘海屏会更高
    ScreenUtil.textScaleFactor //系统字体缩放比例

    ScreenUtil().scaleWidth  // 实际宽度的dp与设计稿宽度的比例
    ScreenUtil().scaleHeight // 实际高度的dp与设计稿高度度的比例

    0.2.sw  //屏幕宽度的0.2倍
    0.5.sh  //屏幕高度的50%
```


#### 适配尺寸

传入设计稿的尺寸(单位与初始化时的单位相同)：

根据屏幕宽度适配 `width: ScreenUtil().setWidth(540)`,

根据屏幕高度适配 `height: ScreenUtil().setHeight(200)`, 一般来说，控件高度也根据宽度进行适配

**注意**

高度也根据setWidth来做适配可以保证不变形(当你想要一个正方形的时候)

setHeight方法主要是在高度上进行适配, 在你想控制UI上一屏的高度与实际中显示一样时使用.

例如:

```
//UI上是长方形:
Container(
           width: ScreenUtil().setWidth(375),
           height: ScreenUtil().setHeight(375),
            ),
            
//如果你想显示一个正方形:
Container(
           width: ScreenUtil().setWidth(300),
           height: ScreenUtil().setWidth(300),
            ),
```

如果你的dart sdk>=2.6,可以使用扩展函数:
example:
不用这个:
```
Container(
width: ScreenUtil().setWidth(50),
height:ScreenUtil().setHeight(200),
)
```
而是用这个:
```
Container(
width: 50.w,
height:200.h
)
```

#### 适配字体:
传入设计稿的字体大小：

``` 
//传入字体大小(单位和初始化时的单位保持一致)，默认不根据系统的“字体大小”辅助选项来进行缩放(可在初始化ScreenUtil时设置allowFontScaling)
ScreenUtil().setSp(28)
或
28.sp (dart sdk>=2.6)
 
//传入字体大小，根据系统的“字体大小”辅助选项来进行缩放(如果某个地方不遵循全局的allowFontScaling设置)       
ScreenUtil().setSp(24, allowFontScalingSelf: true)
或
24.ssp (dart sdk>=2.6)


//for example:

Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('我的文字大小在设计稿上是24px，不会随着系统的文字缩放比例变化',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(24),
                    )),
                Text('我的文字大小在设计稿上是24px，会随着系统的文字缩放比例变化',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil()
                            .setSp(24, allowFontScalingSelf: true))),
              ],
            )
```

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        //Set the fit size (fill in the screen size of the device in the design) If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
        ScreenUtil.init(constraints, designSize: Size(750, 1334), allowFontScaling: false);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter_ScreenUtil',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomePage(title: 'FlutterScreenUtil Demo'),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                    '我的宽度:${0.5.sw}dp \n'
                    '我的高度:${ScreenUtil().setHeight(200)}dp',
                    style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(24)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                  width: 375.w,
                  height: 200.h,
                  color: Colors.blue,
                  child: Text(
                      '我的宽度:${375.w}dp \n'
                      '我的高度:${200.h}dp',
                      style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(24))),
                ),
              ],
            ),
            Text('设备宽度:${ScreenUtil().screenWidthPx}px'),
            Text('设备高度:${ScreenUtil().screenHeightPx}px'),
            Text('设备宽度:${ScreenUtil().screenWidth}dp'),
            Text('设备高度:${ScreenUtil().screenHeight}dp'),
            Text('设备的像素密度:${ScreenUtil().pixelRatio}'),
            Text('底部安全区距离:${ScreenUtil().bottomBarHeight}dp'),
            Text('状态栏高度:${ScreenUtil().statusBarHeight}dp'),
            Text(
              '实际宽度的dp与设计稿px的比例:${ScreenUtil().scaleWidth}',
              textAlign: TextAlign.center,
            ),
            Text(
              '实际高度的dp与设计稿px的比例:${ScreenUtil().scaleHeight}',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 100.h,
            ),
            Text('系统的字体缩放比例:${ScreenUtil().textScaleFactor}'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '我的文字大小在设计稿上是24px，不会随着系统的文字缩放比例变化',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.sp,
                  ),
                ),
                Text(
                  '我的文字大小在设计稿上是24px，会随着系统的文字缩放比例变化',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.ssp,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void printScreenInformation() {
    print('设备宽度:${1.sw}');
    print('设备高度:${1.sh}');
    print('设备的像素密度:${ScreenUtil().pixelRatio}');
    print('底部安全区距离:${ScreenUtil().bottomBarHeight}dp');
    print('状态栏高度:${ScreenUtil().statusBarHeight}dp');
    print('实际宽度的dp与设计稿px的比例:${ScreenUtil().scaleWidth}');
    print('实际高度的dp与设计稿px的比例:${ScreenUtil().scaleHeight}');
    print('宽度和字体相对于设计稿放大的比例:${ScreenUtil().scaleWidth * ScreenUtil().pixelRatio}');
    print('高度相对于设计稿放大的比例:${ScreenUtil().scaleHeight * ScreenUtil().pixelRatio}');
    print('系统的字体缩放比例:${ScreenUtil().textScaleFactor}');
    print('屏幕宽度的0.5:${0.5.sw}');
    print('屏幕高度的0.5:${0.5.sh}');
  }
}

```
[widget test](https://github.com/OpenFlutter/flutter_screenutil/issues/115)

### 使用示例:

[example demo](https://github.com/OpenFlutter/flutter_ScreenUtil/blob/master/example/lib/main_zh.dart)
 
效果:

![手机效果](demo_zh.png)
![平板效果](demo_tablet_zh.png)
