<!--
 * @Author: zhuoyuan93@gmail.com
 * @Date: 2018-10-16 19:43:03
 * @LastEditors: zhuoyuan93@gmail.com
 * @LastEditTime: 2019-11-19 11:41
 * @Description: Update log
 -->
 
#0.7.0

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




