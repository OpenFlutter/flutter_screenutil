# flutter_screenutil
[![pub package](https://img.shields.io/pub/v/flutter_screenutil.svg)](https://pub.dartlang.org/packages/flutter_screenutil)

**Um plugin Flutter para adaptação de tamanho de tela e fontes. Deixe sua UI exibir um layout aceitável em diferentes tamanhos de tela!**

*Nota*: Este plugin ainda está em desenvolvimento e algumas APIs podem ainda não estar disponíveis.

[中文文档](https://github.com/OpenFlutter/flutter_screenutil/blob/master/README_CN.md)  

[README of English](https://github.com/OpenFlutter/flutter_ScreenUtil/blob/master/README.md)

[github](https://github.com/OpenFlutter/flutter_screenutil)

[Histórico de atualizações](https://github.com/OpenFlutter/flutter_screenutil/blob/master/CHANGELOG.md)

## Como usar:

### Adicionando a dependência：
Por favor, verifique a última versão antes da instalação.
Se houver algum problema com a nova versão, use a versão anterior
```
dependencies:
  flutter:
    sdk: flutter
  # add flutter_screenutil
  flutter_screenutil: ^3.1.0
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
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //Set the fit size (fill in the screen size of the device in the design) If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
  ScreenUtil.init(designSize: Size(750, 1334), allowFontScaling: false);
  runApp(MyApp());
}

//Valor padrão: width : 1080px , height:1920px , allowFontScaling:false
ScreenUtil.init(context);

//Se o design é baseado no iPhone6 ​​(iPhone6 ​​750*1334)
ScreenUtil.init(context, designSize: Size(750, 1334));

//Se você quer definir que o tamanho da fonte seja ajustado de acordo com a opção "tamanho da fonte" na acessibilidade do sistema
ScreenUtil.init(context, designSize: Size(750, 1334), allowFontScaling: true);

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
    0.5.hp  //50% altura da tela
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
//(Se em algum lugar não seguir a configuração global da propriedade allowFontScaling)
ScreenUtil().setSp(24, allowFontScalingSelf: true)

//Exemplo:

Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    'Minha fonte tem 24px no protótipo de design e não irá mudar com o sistema.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(24),
                    )),
                Text(
                    'Minha fonte tem 24px no protótipo de design e poderá mudar com o sistema.',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil()
                            .setSp(24, allowFontScalingSelf: true))),
              ],
            )
```

#### Outras APIs relacionadas：
```dart
    ScreenUtil.pixelRatio       //Densidade de pixels do dispositivo
    ScreenUtil.screenWidth      //Largura da tela do dispositivo
    ScreenUtil.screenHeight     //Altura da tela do dispositivo
    ScreenUtil.bottomBarHeight  //Distância segura do rodapé, adequada para botões em tela cheia
    ScreenUtil.statusBarHeight  //Altura da status bar em pixels, Notch será maior
    ScreenUtil.textScaleFactor //Fator de escala da fonte do sistema

    ScreenUtil().scaleWidth //Razão entre a largura atual e a largura do protótipo de design em pixels
    ScreenUtil().scaleHeight //Razão entre a altura atual e a altura do protótipo de design em pixels

```

```dart
//import
import 'package:flutter_screenutil/flutter_screenutil.dart';

...

  @override
  Widget build(BuildContext context) {
    ///Define o tamanho de ajuste (preenche o tamanho da tela do dispositivo no design). Se o design é baseado no tamanho do iPhone6 (iPhone6 ​​750*1334)
    ScreenUtil.init(designSize: Size(750, 1334), allowFontScaling: false);
    
    print('Largura do dispositivo:${ScreenUtil().screenWidth}'); //Largura do dispositivo
    print('Altura do dispositivo:${ScreenUtil().screenHeight}'); //Altura do dispositivo
    print(
        'Densidade de pixels do dispositivo:${ScreenUtil().pixelRatio}'); //Densidade de pixels do dispositivo
    print(
        'Distância segura do rodapé:${ScreenUtil().bottomBarHeight}'); //Distância segura do rodapé, adequada para botões em tela cheia
    print(
        'Altura da status bar:${ScreenUtil().statusBarHeight}px'); //Altura da status bar em pixels, Notch será maior
    print(
        'Razão entre a largura atual e a largura do protótipo de design em pixels:${ScreenUtil().scaleWidth}'); 
    print(
        'Razão entre a altura atual e a altura do protótipo de design em pixels:${ScreenUtil().scaleHeight}'); 
    print(
        'Razão da fonte e largura para o tamanho do design:${ScreenUtil().scaleWidth * ScreenUtil.pixelRatio}');
    print(
        'Razão da fonte e altura para o tamanho do design:${ScreenUtil().scaleHeight * ScreenUtil.pixelRatio}');
        
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
                    'Minha largura:${ScreenUtil().setWidth(375)}dp',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(12)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                  width: ScreenUtil().setWidth(375),
                  height: ScreenUtil().setHeight(200),
                  color: Colors.blue,
                  child: Text('Minha largura:${ScreenUtil().setWidth(375)}dp',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(12))),
                ),
              ],
            ),
            Text('Largura do dispositivo:${ScreenUtil().screenWidth}dp'),
            Text('Altura do dispositivo:${ScreenUtil().screenHeight}dp'),
            Text('Densidade de pixels do dispositivo:${ScreenUtil().pixelRatio}'),
            Text('Distância segura do rodapé:${ScreenUtil().bottomBarHeight}dp'),
            Text('Altura da status bar:${ScreenUtil().statusBarHeight}dp'),
            Text(
              'Razão entre a largura atual e a largura do protótipo de design em pixels:${ScreenUtil().scaleWidth}',
              textAlign: TextAlign.center,
            ),
            Text(
              'Razão entre a altura atual e a altura do protótipo de design em pixels:${ScreenUtil().scaleHeight}',
              textAlign: TextAlign.center,
            ),
            Text(
              'Razão da fonte e largura para o tamanho do design:${ScreenUtil().scaleWidth * ScreenUtil.pixelRatio}',
              textAlign: TextAlign.center,
            ),
            Text(
              'Razão da fonte e altura para o tamanho do design:${ScreenUtil().scaleHeight * ScreenUtil.pixelRatio}',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: ScreenUtil().setHeight(100),
            ),
            Text('Fator de escala da fonte do sistema:${ScreenUtil.textScaleFactor}'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    'Minha fonte tem 24px no protótipo de design e não irá mudar com o sistema.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(24),
                    )),
                Text(
                    'Minha fonte tem 24px no protótipo de design e poderá mudar com o sistema.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(24, allowFontScalingSelf: true),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
```
[widget test](https://github.com/OpenFlutter/flutter_screenutil/issues/115)

### Exemplo:

[Demonstração](/example/lib/main_zh.dart)
 
Efeito:

![效果](demo_en.png)
![tablet effect](demo_tablet_en.png)
