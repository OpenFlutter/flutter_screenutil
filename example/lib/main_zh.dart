import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Set the fit size (fill in the screen size of the device in the design) If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      allowFontScaling: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter_ScreenUtil',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(title: 'FlutterScreenUtil Demo'),
      ),
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
                    '我的实际宽度:${0.5.sw}dp \n'
                    '我的实际高度:${ScreenUtil().setHeight(200)}dp',
                    style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(12)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                  width: 180.w,
                  height: 200.h,
                  color: Colors.blue,
                  child: Text(
                      '我的设计稿宽度: 180dp \n'
                      '我的设计稿高度: 200dp',
                      style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(12))),
                ),
              ],
            ),
            Text('设备宽度:${ScreenUtil().screenWidth}dp'),
            Text('设备高度:${ScreenUtil().screenHeight}dp'),
            Text('设备的像素密度:${ScreenUtil().pixelRatio}'),
            Text('底部安全区距离:${ScreenUtil().bottomBarHeight}dp'),
            Text('状态栏高度:${ScreenUtil().statusBarHeight}dp'),
            Text(
              '实际宽度与设计稿的比例:${ScreenUtil().scaleWidth}',
              textAlign: TextAlign.center,
            ),
            Text(
              '实际高度与设计稿的比例:${ScreenUtil().scaleHeight}',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50.h,
            ),
            Text('系统的字体缩放比例:${ScreenUtil().textScaleFactor}'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '我的文字大小在设计稿上是16dp，不会随着系统的文字缩放比例变化',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  '我的文字大小在设计稿上是16dp，会随着系统的文字缩放比例变化',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.ssp,
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
    print('设备宽度:${1.sw}dp');
    print('设备高度:${1.sh}dp');
    print('设备的像素密度:${ScreenUtil().pixelRatio}');
    print('底部安全区距离:${ScreenUtil().bottomBarHeight}dp');
    print('状态栏高度:${ScreenUtil().statusBarHeight}dp');
    print('实际宽度的dp与设计稿px的比例:${ScreenUtil().scaleWidth}');
    print('实际高度的dp与设计稿px的比例:${ScreenUtil().scaleHeight}');
    print('宽度和字体相对于设计稿放大的比例:${ScreenUtil().scaleWidth * ScreenUtil().pixelRatio}');
    print('高度相对于设计稿放大的比例:${ScreenUtil().scaleHeight * ScreenUtil().pixelRatio}');
    print('系统的字体缩放比例:${ScreenUtil().textScaleFactor}');
    print('屏幕宽度的0.5:${0.5.sw}dp');
    print('屏幕高度的0.5:${0.5.sh}dp');
  }
}
