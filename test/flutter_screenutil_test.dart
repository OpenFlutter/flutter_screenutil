import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

import 'home.test.dart';

void main() {
  const smallerDeviceSize = Size(300, 600);
  const smallerDeviceData = MediaQueryData(size: smallerDeviceSize);

  const biggerDeviceSize = Size(500, 900);
  const biggerDeviceData = MediaQueryData(size: biggerDeviceSize);

  const uiSize = Size(470, 740);

  group('[Test calculations]', () {
    test('Test smaller size', () {
      ScreenUtil.configure(
        data: smallerDeviceData,
        designSize: uiSize,
        minTextAdapt: true,
        splitScreenMode: false,
      );

      expect(1.w, smallerDeviceSize.width / uiSize.width);
      expect(1.w < 1, true);
      expect(1.h, smallerDeviceSize.height / uiSize.height);
      expect(1.h < 1, true);
    });

    test('Test bigger size', () {
      ScreenUtil.configure(
        data: biggerDeviceData,
        designSize: uiSize,
        minTextAdapt: true,
        splitScreenMode: false,
      );

      expect(1.w, biggerDeviceSize.width / uiSize.width);
      expect(1.w > 1, true);
      expect(1.h, biggerDeviceSize.height / uiSize.height);
      expect(1.h > 1, true);
    });
  });

  group('[Test overflow]', () {
    testWidgets('Test overflow width', (tester) async {
      await tester.pumpWidget(ScreenUtilInit(
        designSize: uiSize,
        child: MaterialApp(home: WidgetTest(width: () => uiSize.width.w)),
      ));

      // Wait until all widget rendered
      await tester.pumpAndSettle();

      // a Text widget must be present
      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('Test overflow height', (tester) async {
      await tester.pumpWidget(ScreenUtilInit(
        designSize: uiSize,
        child: MaterialApp(home: WidgetTest(height: () => uiSize.height.h)),
      ));

      // Wait until all widget rendered
      await tester.pumpAndSettle();

      // a Text widget must be present
      expect(find.text('Test'), findsOneWidget);
    });
  });

  testWidgets('[Rebuilding]', (tester) async {
    final textFieldKey = UniqueKey();
    final buildCountNotifier = ValueNotifier(0);
    final focusNode = FocusNode();

    Finder textField() => find.byKey(textFieldKey);

    await tester.pumpWidget(ScreenUtilInit(
      designSize: uiSize,
      rebuildFactor: RebuildFactors.always,
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              buildCountNotifier.value += 1;

              assert(uiSize.width.w == MediaQuery.of(context).size.width);

              return SizedBox(
                width: 1.sw,
                child: Column(
                  children: [
                    ValueListenableBuilder<int>(
                      valueListenable: buildCountNotifier,
                      builder: (_, count, __) => Text('Built count: $count'),
                    ),
                    TextField(
                      key: textFieldKey,
                      focusNode: focusNode,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    ));

    await tester.pumpAndSettle();
    expect(buildCountNotifier.value, 1);

    expect(textField(), findsOneWidget);
    expect(focusNode.hasFocus, false);

    await tester.tap(textField()).then((_) => tester.pumpAndSettle());
    expect(textField(), findsOneWidget);
    expect(focusNode.hasFocus, true);
    expect(buildCountNotifier.value, 1);

    // Simulate keyboard
    tester.view.viewInsets = FakeViewPadding(bottom: 20);

    await tester.pumpAndSettle();
    expect(focusNode.hasFocus, true);
    expect(buildCountNotifier.value, 1);
  });
}
