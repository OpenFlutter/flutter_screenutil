import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.instance = new ScreenUtil(width: 750, height: 1334);

    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
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
  void initState() {
    // TODO: implement initState
    super.initState();
    print('设备的像素密度:${ScreenUtil.pixelRatio}'); //设备的像素密度
    print('设备宽度:${ScreenUtil.screenWidth}'); //设备宽度
    print('设备高度:${ScreenUtil.screenHeight}'); //设备高度
    print('底部安全区距离:${ScreenUtil.bottomBarHeight}'); //底部安全区距离，适用于全面屏下面有按键的
    print('状态栏高度:${ScreenUtil.statusBarHeight}px'); //状态栏高度 刘海屏会更高

    print('宽度相对于设计稿放大的倍数:${ScreenUtil().scaleWidth}'); //宽度相对于设计稿放大的倍数
    print('高度相对于设计稿放大的倍数:${ScreenUtil().scaleHeight}'); //高度相对于设计稿放大的倍数
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(375),
                  height: ScreenUtil().setHeight(200),
                  color: Colors.red,
                  child: Text(ScreenUtil().setWidth(375).toString()),
                ),
                Container(
                  width: ScreenUtil().setWidth(375),
                  height: ScreenUtil().setHeight(200),
                  color: Colors.blue,
                  child: Text(ScreenUtil().setWidth(375).toString()),
                ),
              ],
            ),
            Text(ScreenUtil.screenWidth.toString()),
            Text(ScreenUtil.screenHeight.toString()),
          ],
        ),
      ),
    );
  }
}
