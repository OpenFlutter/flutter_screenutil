
# flutter_ScreenUtil
**flutter 屏幕适配方案，让你的UI不会因为在不同设备上变得难看**

[README of English](https://github.com/OpenFlutter/flutter_ScreenUtil/blob/master/README.md)

github: https://github.com/OpenFlutter/flutter_ScreenUtil

csdn博客工具介绍:https://blog.csdn.net/u011272795/article/details/82795477


## 使用方法:

### 安装依赖：

安装之前请查看最新版本
```
dependencies:
  flutter:
    sdk: flutter
  # 添加依赖
  flutter_screenutil: ^0.3.0
```

### 在每个使用的地方导入包：
```
import 'package:flutter_screenutil/flutter_screenutil.dart';
```

### 初始化设置尺寸
在使用之前请设置好设计稿的宽度和高度，传入设计稿的宽度和高度(单位px)
如果不设置则使用默认尺寸，默认为1080*1920
一定在MaterialApp的home中的页面设置，以保证在每次使用之前设置好了适配尺寸:

```
//设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
```

### 使用：

适配尺寸：
```
//传入设计稿的px尺寸：
适配后的宽度width: ScreenUtil().setWidth(540),
适配后的高度height: ScreenUtil().setHeight(200),
高度也根据setWidth来做适配可以保证不变形

例如:
Container(
           width: ScreenUtil().setWidth(375),
           height: ScreenUtil().setHeight(200),
            ),
```

适配字体:
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

其他相关api：
```
    ScreenUtil.pixelRatio       //设备的像素密度
    ScreenUtil.screenWidth      //设备宽度
    ScreenUtil.screenHeight     //设备高度
    ScreenUtil.bottomBarHeight  //底部安全区距离，适用于全面屏下面有按键的
    ScreenUtil.statusBarHeight  //状态栏高度 刘海屏会更高  单位px
    ScreenUtil.textScaleFactory //系统字体缩放比例
    
    ScreenUtil().scaleWidth  //宽度相对于设计稿放大的倍数
    ScreenUtil().scaleHeight //高度相对于设计稿放大的倍数
    
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
     print(
         '宽度相对于设计稿放大的倍数:${ScreenUtil().scaleWidth}'); //The width is enlarged relative to the design draft
     print(
         '高度相对于设计稿放大的倍数:${ScreenUtil().scaleHeight}'); //The height is enlarged relative to the design draft
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
                     'My width:${ScreenUtil().setWidth(375)}dp',
                     style: TextStyle(
                         color: Colors.white,
                         fontSize: ScreenUtil().setSp(28, false)),
                   ),
                 ),
                 Container(
                   width: ScreenUtil().setWidth(375),
                   height: ScreenUtil().setHeight(200),
                   color: Colors.blue,
                   child: Text('My width:${ScreenUtil().setWidth(375)}dp',
                       style: TextStyle(
                           color: Colors.white,
                           fontSize: ScreenUtil().setSp(28, false))),
                 ),
               ],
             ),
             Text('Device width：${ScreenUtil.screenWidth}px'),
             Text('Device height:${ScreenUtil.screenHeight}px'),
             Text('Device pixel density:${ScreenUtil.pixelRatio}'),
             Text('Bottom safe zone distance:${ScreenUtil.bottomBarHeight}px'),
             Text('Status bar height:${ScreenUtil.statusBarHeight}px'),
             Text(
               'Width is enlarged relative to the design draft:${ScreenUtil().scaleWidth}',
               textAlign: TextAlign.center,
             ),
             Text(
               'Height is enlarged relative to the design draft:${ScreenUtil().scaleHeight}',
               textAlign: TextAlign.center,
             ),
             SizedBox(
               height: ScreenUtil().setHeight(200),
             ),
             Text('System font scaling:${ScreenUtil.textScaleFactory}'),
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Text(
                     '我的文字大小是28px，不会随着系统的文字大小变化',
                     style: TextStyle(
                         color: Colors.black,
                         fontSize: ScreenUtil().setSp(28, false))),
                 Text('我的文字大小是28px，会随着系统的文字大小变化',
                     style: TextStyle(
                         color: Colors.black, fontSize: ScreenUtil().setSp(28))),
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

