/*import 'package:flutter/widgets.dart';
import 'src/first_method.dart' as firstMethod;
import 'src/second_method.dart' as secondMethod;

void main() {
  const method = int.fromEnvironment('method', defaultValue: 1);
  runApp(method == 1 ? firstMethod.MyApp() : secondMethod.MyApp());
}
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(ScreenUtilInit(
    builder: (child) => MaterialApp(
      key: GlobalObjectKey('screenutil'),
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText2: TextStyle(fontSize: 32.sp),
        ),
      ),
      home: child,
    ),
    child: ThirdPage(),
  ));
}

class MyStatelessElement<T extends TestPage> extends StatelessElement {
  MyStatelessElement(T widget) : super(widget);

  @override
  T get widget => super.widget as T;

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    print('${widget.text()} is mounted');
  }

  @override
  void unmount() {
    print('${widget.text()} is unmounted');
    super.unmount();
  }
}

abstract class TestPage extends StatelessWidget {
  String text() => runtimeType.toString();

  Widget goto();

  @override
  StatelessElement createElement() => MyStatelessElement(this);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => goto()),
        (route) => false,
      );
    });
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20).r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(),
              Text(
                text(),
                style: TextStyle(fontSize: 32.sp),
              ),
              Text(text()),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Text('$index'),
                  separatorBuilder: (_, __) => Container(
                    height: 50.h,
                    color: Colors.green,
                  ),
                  itemCount: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FirstPage extends TestPage {
  @override
  Widget goto() => SecondPage();
}

class SecondPage extends TestPage {
  @override
  Widget goto() => FirstPage();
}

class ThirdPage extends TestPage {
  @override
  Widget goto() => FirstPage();
}
