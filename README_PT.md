
# flutter_screenutil
[![pub package](https://img.shields.io/pub/v/flutter_screenutil.svg)](https://pub.dartlang.org/packages/flutter_screenutil)

**Um plugin Flutter para adaptação de tamanho de tela e fontes. Deixe sua UI exibir um layout aceitável em diferentes tamanhos de tela!**

*Nota*: Este plugin ainda está em desenvolvimento e algumas APIs podem ainda não estar disponíveis.

[中文文档](https://github.com/OpenFlutter/flutter_screenutil/blob/master/README_CN.md)  

[README of English](https://github.com/OpenFlutter/flutter_ScreenUtil/blob/master/README.md)

[github](https://github.com/OpenFlutter/flutter_screenutil)

[Histórico de atualizações](https://github.com/OpenFlutter/flutter_screenutil/blob/master/CHANGELOG.md)

## Note
[v3](https://github.com/OpenFlutter/flutter_screenutil/tree/beta) requer `flutter >= 1.19.0`.
[v2](https://github.com/OpenFlutter/flutter_screenutil) requer `flutter < 1.19.0`.

## Como usar:

### Adicionando a dependência：
Por favor, verifique a última versão antes da instalação.
Se houver algum problema com a nova versão, use a versão anterior
```
dependencies:
  flutter:
    sdk: flutter
  # add flutter_screenutil
  flutter_screenutil: ^2.3.0
```

### Adicione o seguinte import em seu código Dart:
```
import 'package:flutter_screenutil/flutter_screenutil.dart';
```

### Propriedades
   
|Propriedade|Tipo|Valor Padrão|Descrição|
|:---|:---|:---|:---| 
|width|double|1080px|A largura do dispositivo no protótipo de design, em px|
|height|double|1920px|A altura do dispositivo no protótipo de design, em px|
|allowFontScaling|bool|false|Defina caso o tamanho da fonte seja dimensionado de acordo com a opção "tamanho de fonte" na acessibilidade do sistema|

### Inicialize e defina o tamanho de ajuste e tamanho da fonte para dimensionar de acordo com a opção "tamanho de fonte" na acessibilidade do sistema
Por favor, defina a largura e altura do protótipo de design antes de usar (em pixels).
Certifique-se de definir as dimensões na paginal inicial do MaterialApp (ou seja, no arquivo de entrada, defina apenas uma vez) para garantir que o tamanho de ajuste seja o mesmo antes de cada uso:

```dart

//Preencha o tamanho da tela do dispositivo no protótipo de design

//Valor padrão: width : 1080px , height:1920px , allowFontScaling:false
ScreenUtil.init(context);

//Se o design é baseado no iPhone6 ​​(iPhone6 ​​750*1334)
ScreenUtil.init(context, width: 750, height: 1334);

//Se você quer definir que o tamanho da fonte seja ajustado de acordo com a opção "tamanho da fonte" na acessibilidade do sistema
ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);

```

### Uso：

### API

```dart
    ScreenUtil().setWidth(540)  (sdk>=2.6 : 540.w) //Adapted to screen width
    ScreenUtil().setHeight(200) (sdk>=2.6 : 200.h) //Adapted to screen height
    ScreenUtil().setSp(24)      (sdk>=2.6 : 24.sp)  //Adapter font
    ScreenUtil().setSp(24, allowFontScalingSelf: true)  (sdk>=2.6 : 24.ssp)  //Adapter font(fonts will scale to respect Text Size accessibility settings)
    ScreenUtil().setSp(24, allowFontScalingSelf: false)  (sdk>=2.6 : 24.nsp) //Adapter font(fonts will not scale to respect Text Size accessibility settings)

    ScreenUtil.pixelRatio       //Device pixel density
    ScreenUtil.screenWidth     (sdk>=2.6 : 1.wp)  //Device width
    ScreenUtil.screenHeight    (sdk>=2.6 : 1.hp)  //Device height
    ScreenUtil.bottomBarHeight  //Bottom safe zone distance, suitable for buttons with full screen
    ScreenUtil.statusBarHeight  //Status bar height , Notch will be higher Unit px
    ScreenUtil.textScaleFactor  //System font scaling factor

    ScreenUtil().scaleWidth //Ratio of actual width dp to design draft px
    ScreenUtil().scaleHeight //Ratio of actual height dp to design draft px

    0.2.wp  //0,2 vezes a largura da tela
    0.5.hp  //50% da largura da tela
```

#### Adaptar o tamanho da tela：

Informe o tamanho em pixels do protótipo de design:

Adaptado à largura da tela: `ScreenUtil().setWidth(540)`,

Adaptado à altura da tela: `ScreenUtil().setHeight(200)`,

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

**Nota** 

Altura também é adaptada de acordo com o setWidth para garantir que não tenha deformação (quando quiser um quadrado)

O método setHeight é a principal forma de adaptar a altura, se quiser controlar a altura e a realidade de uma tela na UiUsed quando a mesma for exibida.

```dart
//Exemplo:
//Retângulo
Container(
           width: ScreenUtil().setWidth(375),
           height: ScreenUtil().setHeight(200),
           ...
            ),
            
////Se quiser exibir um quadrado:
Container(
           width: ScreenUtil().setWidth(300),
           height: ScreenUtil().setWidth(300),
            ),
            
```

#### Adaptar fonte:
``` dart
//Tamanho da fonte informado, em pixels, a fonte não irá dimensionar respeitando a opção "Tamanho de Fonte" nas configurações de acessibilidade
//(allowFontScaling quando iniciar o ScreenUtil)
ScreenUtil().setSp(28)    
     
//Tamanho da fonte informado，em pixels，a fonte irá dimensionar respeitando a opção "Tamanho de Fonte" nas configurações de acessibilidade
//(Se em algum lugar não seguir a configuração global da propriedade allowFontScaling
