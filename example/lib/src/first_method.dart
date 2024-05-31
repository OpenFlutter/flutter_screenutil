import 'package:example/responsive_widgets.su.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../src_zh/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // In first method you only need to wrap [MaterialApp] with [ScreenUtilInit] and that's it
    return ScreenUtilInit(
      responsiveWidgets: responsiveWidgets,
      ensureScreenSize: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'First Method',
        // You can use the library anywhere in the app even in theme
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: Typography(platform: TargetPlatform.iOS)
              .black
              .apply(fontSizeFactor: 1),
        ),
        home: const HomePage(title: 'First Method'),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => HomePageScaffold(title: widget.title);
}
