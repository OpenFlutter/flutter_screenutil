<!--
 * @Author: zhuoyuan93@gmail.com
 * @Date: 2018-10-16 19:43:03
 * @LastEditors: zhuoyuan93@gmail.com
 * @LastEditTime: 2020年6月20日 11:20:02
 * @Description: Update log
 -->

#2.0.0
- Use `MediaQueryData.fromWindow(window)` instead of `MediaQuery.of(context)`, no context parameter required
- API changes, please note

#1.1.0
- support ExtensionMethod Dart-SDK-2.6.0
- you can use 'width: 50.w' instead of 'width: ScreenUtil().setWidth(50)'
  '50.h' instead of 'ScreenUtil().setHeight(50)'
  '24.sp' instead of 'ScreenUtil().setSp(24)'
  '24.ssp' instead of 'ScreenUtil().setSp(24, allowFontScalingSelf: true)'

# 1.0.2
- fix #89 
- 优化屏幕旋转效果
- 字体适配统一使用宽度

# 1.0.1
- Rebuild code, change API
  Delete "getInstance()", please use "ScreenUtil ()" instead of "ScreenUtil.getInstance()"
  use "ScreenUtil().setSp(24, allowFontScalingSelf: true)" instead of "ScreenUtil.getInstance().setSp(14, true)"
- Modify the initialization method
- Fix #68
- Change example code
  Example CompileSdkVersion change to 28

**If there is significant impact, please return to 0.7.0**

# 0.7.0

- Replace textScaleFactory with textScaleFactor , It's a typo.

# 0.6.1

- Add return types to all methods.

# 0.6.0

- Completing comments , adding English commentsWelcome to add, correct
- 参数同时支持传入 int / double 或者是var size = 100 , var size = 100.0.
- The argument also supports passing in in / double / var size = 100 /var size = 100.0

# 0.5.3

- Change the units of statusBarHeight and bottomBarHeight to dp

# 0.5.2

- Change the parameter type from int to double

- setWidth,setHeight,setSp. for example: you can use setWidth(100) or setWidth(100.0)

# 0.5.1

- Fix the wrong way of using

- It is recommended to use `ScreenUtil.getInstance()` instead of `ScreenUtil()` , for example: `ScreenUtil.getInstance().setHeight(25)` instead of `ScreenUtil().setHeight(25)`

# 0.4.4

- Fix bugs that default fonts change with the system

# 0.4.3

- Modify the font to change with the system zoom mode. The default value is false.

- setSp(int fontSize, [allowFontScaling = false]) => allowFontScaling
? setWidth(fontSize) \* \_textScaleFactor
: setWidth(fontSize);

# 0.4.2

- add two Properties
- ///Current device width dp
- ///当前设备宽度 dp
- ScreenUtil.screenWidthDp

- ///Current device height dp
- ///当前设备高度 dp
- ScreenUtil.screenHeightDp

# 0.4.1

- Fix font adaptation issues

# 0.4.0

- Optimize font adaptation method

# 0.3.1

- Perfect documentation
- Width is enlarged relative to the design draft => The ratio of font and width to the size of the design
- Height is enlarged relative to the design draft => The ratio of height width to the size of the design


# 0.3.0

- Add font size adaptation

# 0.2.2

- Optimize documentation

# 0.0.2

- Fixed bug when releasing

# 0.0.1

- first version




