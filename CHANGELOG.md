## [0.0.1] -  first version

## [0.2.2] - Fixed bug when releasing

## [0.2.2] - Optimize documentation

## [0.3.0] - Add font size adaptation

## [0.3.0] - Perfect documentation
Width is enlarged relative to the design draft => The ratio of font and width to the size of the design
Height is enlarged relative to the design draft => The ratio of  height width to the size of the design

## [0.4.0] - Optimize font adaptation method

## [0.4.1] - Fix font adaptation issues

## [0.4.2] - add two Properties

  ///Current device width dp <br/>
  ///当前设备宽度 dp <br/>
  ScreenUtil.screenWidthDp 

  ///Current device height dp <br/>
  ///当前设备高度 dp <br/>
  ScreenUtil.screenHeightDp   

## [0.4.2] - Modify the font to change with the system zoom mode. The default value is false.

setSp(int fontSize, [allowFontScaling = false]) => allowFontScaling
      ? setWidth(fontSize) * _textScaleFactor
      : setWidth(fontSize);
      
## [0.4.4] - Fix bugs that default fonts change with the system

## [0.5.0] - Fix the wrong way of using 

please use `ScreenUtil.getInstance()` instead of `ScreenUtil()` , for example: ScreenUtil.getInstance().setHeight(25) instead of `ScreenUtil().setHeight(25)`