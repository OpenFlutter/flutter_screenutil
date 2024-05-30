import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtil(
      options: const ScreenUtilOptions(
        enable: true,
        designSize: Size(360, 690),
        fontFactorByWidth: 2.0,
        fontFactorByHeight: 1.0,
        flipSizeWhenLandscape: true,
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'This is Awesome !',
              style: TextStyle(fontSize: context.sp(20)),
            ),
          ],
        ),
      ),
    );
  }
}

class MyAppWithSingleton extends StatelessWidget {
  const MyAppWithSingleton({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilSingleton(
      options: const ScreenUtilOptions(
        enable: true,
        designSize: Size(360, 690),
        fontFactorByWidth: 2.0,
        fontFactorByHeight: 1.0,
        flipSizeWhenLandscape: true,
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomeWithSingletonPage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomeWithSingletonPage extends StatelessWidget {
  const MyHomeWithSingletonPage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    // THIS IS REQUIRED FOR EVERY WIDGET THAT USES SCREEN UTIL SINGLETON
    context.su(); // or ScreenUtilSingleton.addDependent(context)
    // or use one of context.[sp/w/h/r/i](value) at least once in this scope

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'This is Awesome !',
              style: TextStyle(fontSize: 20.sp),
            ),
          ],
        ),
      ),
    );
  }
}
