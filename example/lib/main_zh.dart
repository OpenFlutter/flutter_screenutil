import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter_ScreenUtil',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'FlutterScreenUtil Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    print('设备宽度:${ScreenUtil.screenWidth}'); //Device width
    print('设备高度:${ScreenUtil.screenHeight}'); //Device height
    print('设备的像素密度:${ScreenUtil.pixelRatio}'); //Device pixel density
    print(
        '底部安全区距离:${ScreenUtil.bottomBarHeight}dp'); //Bottom safe zone distance，suitable for buttons with full screen
    print(
        '状态栏高度:${ScreenUtil.statusBarHeight}dp'); //Status bar height , Notch will be higher Unit px

    print('实际宽度的dp与设计稿px的比例:${ScreenUtil.getInstance().scaleWidth}');
    print('实际高度的dp与设计稿px的比例:${ScreenUtil.getInstance().scaleHeight}');

    print(
        '宽度和字体相对于设计稿放大的比例:${ScreenUtil.getInstance().scaleWidth * ScreenUtil.pixelRatio}');
    print(
        '高度相对于设计稿放大的比例:${ScreenUtil.getInstance().scaleHeight * ScreenUtil.pixelRatio}');
    print('系统的字体缩放比例:${ScreenUtil.textScaleFactory}');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(
              'ScreenUtil.getInstance().width：${ScreenUtil.getInstance().width}');
          print('ScreenUtil().width：${ScreenUtil().width}');
        },
        child: Icon(Icons.accessible_forward),
      ),
      body: new Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: ScreenUtil.getInstance().setWidth(375),
                  height: ScreenUtil.getInstance().setHeight(200),
                  color: Colors.red,
                  child: Text(
                    '我的宽度:${ScreenUtil.getInstance().setWidth(375)}dp',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil.getInstance().setSp(24),
                    ),
                  ),
                ),
                Container(
                  width: ScreenUtil.getInstance().setWidth(375),
                  height: ScreenUtil.getInstance().setHeight(200),
                  color: Colors.blue,
                  child:
                      Text('我的宽度:${ScreenUtil.getInstance().setWidth(375)}dp',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil.getInstance().setSp(24),
                          )),
                ),
              ],
            ),
            Text('设备宽度:${ScreenUtil.screenWidth}px'),
            Text('设备高度:${ScreenUtil.screenHeight}px'),
            Text('设备宽度:${ScreenUtil.screenWidthDp}dp'),
            Text('设备高度:${ScreenUtil.screenHeightDp}dp'),
            Text('设计稿宽度:${ScreenUtil.getInstance().width}'),
            Text('设备的像素密度:${ScreenUtil.pixelRatio}'),
            Text('底部安全区距离:${ScreenUtil.bottomBarHeight}dp'),
            Text('状态栏高度:${ScreenUtil.statusBarHeight}dp'),
            Text(
              '实际宽度的dp与设计稿px的比例:${ScreenUtil.getInstance().scaleWidth}',
              textAlign: TextAlign.center,
            ),
            Text(
              '实际高度的dp与设计稿px的比例:${ScreenUtil.getInstance().scaleHeight}',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(100),
            ),
            Text('系统的字体缩放比例:${ScreenUtil.textScaleFactory}'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('我的文字大小在设计稿上是24px，不会随着系统的文字缩放比例变化',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil.getInstance().setSp(24))),
                Text('我的文字大小在设计稿上是24px，会随着系统的文字缩放比例变化',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize:
                            ScreenUtil(allowFontScaling: true).setSp(24))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
