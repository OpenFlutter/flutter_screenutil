
# flutter_ScreenUtil

[![pub package](https://img.shields.io/pub/v/flutter_screenutil.svg)](https://pub.dartlang.org/packages/flutter_screenutil)


**flutter 屏幕适配方案，让你的UI在不同尺寸的屏幕上都能显示合理的布局!**

[README of English](https://github.com/OpenFlutter/flutter_ScreenUtil/blob/master/README.md)

github: https://github.com/OpenFlutter/flutter_ScreenUtil

csdn博客工具介绍:https://blog.csdn.net/u011272795/article/details/82795477

[Update log](/CHANGELOG.md)

## 使用方法:

### 安装依赖：

安装之前请查看最新版本
```
dependencies:
  flutter:
    sdk: flutter
  # 添加依赖
  flutter_screenutil: ^0.4.2
```

### 在每个使用的地方导入包：
```
import 'package:flutter_screenutil/flutter_screenutil.dart';
```

### 初始化设置尺寸
在使用之前请设置好设计稿的宽度和高度，传入设计稿的宽度和高度(单位px)

一定在MaterialApp的home中的页面设置(即入口文件，只需设置一次),以保证在每次使用之前设置好了适配尺寸:

```
//设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
```

### 使用：

#### 适配尺寸： 

传入设计稿的px尺寸：

根据屏幕宽度适配 width: ScreenUtil().setWidth(540),

根据屏幕高度适配 height: ScreenUtil().setHeight(200),

**注意**

高度也根据setWidth来做适配可以保证不变形(当你想要一个正方形的时候)

setHeight方法主要是在高度上进行适配, 在你想控制UI上一屏的高度与实际中显示一样时使用.

例如:

```
//长方形:
Container(
           width: ScreenUtil().setWidth(375),
           height: ScreenUtil().setHeight(200),
            ),
            
//如果你想显示一个正方形:
Container(
           width: ScreenUtil().setWidth(300),
           height: ScreenUtil().setWidth(300),
            ),
```

#### 适配字体:
传入设计稿的px尺寸：

``` 
      ScreenUtil().setSp(28)         //传入字体大小，根据系统的“字体大小”辅助选项来进行缩放
      ScreenUtil().setSp(28，false)  //传入字体大小，不会根据系统的“字体大小”辅助选项来进行缩放

for example:
        Text(
             'My font size is 28px and will not change with the system.',
                 style: TextStyle(
                   color: Colors.black,
                   fontSize: ScreenUtil().setSp(28, false) 
                 )
             ),

```

#### 其他相关api：
```
    ScreenUtil.pixelRatio       //设备的像素密度
    ScreenUtil.screenWidth      //设备宽度
    ScreenUtil.screenHeight     //设备高度
    ScreenUtil.bottomBarHeight  //底部安全区距离，适用于全面屏下面有按键的
    ScreenUtil.statusBarHeight  //状态栏高度 刘海屏会更高  单位px
    ScreenUtil.textScaleFactory //系统字体缩放比例
    
    ScreenUtil().scaleWidth  // 实际宽度的dp与设计稿px的比例
    ScreenUtil().scaleHeight // 实际高度的dp与设计稿px的比例
    
```

```
//导入
import 'package:flutter_screenutil/flutter_screenutil.dart';

...

  @override
  Widget build(BuildContext context) {
    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    print('设备宽度:${ScreenUtil.screenWidth}'); //Device width
    print('设备高度:${ScreenUtil.screenHeight}'); //Device height
    print('设备的像素密度:${ScreenUtil.pixelRatio}'); //Device pixel density
    print(
        '底部安全区距离:${ScreenUtil.bottomBarHeight}'); //Bottom safe zone distance，suitable for buttons with full screen
    print(
        '状态栏高度:${ScreenUtil.statusBarHeight}px'); //Status bar height , Notch will be higher Unit px

    print('实际宽度的dp与设计稿px的比例:${ScreenUtil().scaleWidth}');
    print('实际高度的dp与设计稿px的比例:${ScreenUtil().scaleHeight}');

    print(
        '宽度和字体相对于设计稿放大的比例:${ScreenUtil().scaleWidth * ScreenUtil.pixelRatio}'); 
    print(
        '高度相对于设计稿放大的比例:${ScreenUtil().scaleHeight * ScreenUtil.pixelRatio}'); 
    print('系统的字体缩放比例:${ScreenUtil.textScaleFactory}');

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(375),
                  height: ScreenUtil().setHeight(200),
                  color: Colors.red,
                  child: Text(
                    '我的宽度:${ScreenUtil().setWidth(375)}dp',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(12, false),
                    ),
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(375),
                  height: ScreenUtil().setHeight(200),
                  color: Colors.blue,
                  child: Text('我的宽度:${ScreenUtil().setWidth(375)}dp',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(12, false),
                      )),
                ),
              ],
            ),
            Text('设备宽度:${ScreenUtil.screenWidth}px'),
            Text('设备高度:${ScreenUtil.screenHeight}px'),
            Text('设备的像素密度:${ScreenUtil.pixelRatio}'),
            Text('底部安全区距离:${ScreenUtil.bottomBarHeight}px'),
            Text('状态栏高度:${ScreenUtil.statusBarHeight}px'),
            Text(
              '实际高度的dp与设计稿px的比例:${ScreenUtil().scaleHeight}',
              textAlign: TextAlign.center,
            ),
            Text(
              '实际高度的dp与设计稿px的比例:${ScreenUtil().scaleHeight}',
              textAlign: TextAlign.center,
            ),
            Text(
              '宽度和字体相对于设计稿放大的比例:${ScreenUtil().scaleWidth * ScreenUtil.pixelRatio}',
              textAlign: TextAlign.center,
            ),
            Text(
              '高度相对于设计稿放大的比例:${ScreenUtil().scaleHeight * ScreenUtil.pixelRatio}',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: ScreenUtil().setHeight(100),
            ),
            Text('系统的字体缩放比例:${ScreenUtil.textScaleFactory}'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('我的文字大小在设计稿上是14px，不会随着系统的文字缩放比例变化',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(14, false))),
                Text('我的文字大小在设计稿上是14px，会随着系统的文字缩放比例变化',
                    style: TextStyle(
                        color: Colors.black, fontSize: ScreenUtil().setSp(14))),
              ],
            )
          ],
        ),
      ),
    );
  }
```

### 使用示例:

[example demo](https://github.com/OpenFlutter/flutter_ScreenUtil/blob/master/example/lib/main_zh.dart)
 
效果:

![效果](demo_zh.png)

