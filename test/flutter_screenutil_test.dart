import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

import 'home.test.dart';

void main() {
  const smallerDeviceSize = Size(300, 600);
  const biggerDeviceSize = Size(500, 900);
  const uiSize = Size(470, 740);

  group('[Test calculations]', () {
    test('Test smaller size', () {
      final data = ScreenUtilData.from(
        options: ScreenUtilOptions(designSize: uiSize),
        screenSize: smallerDeviceSize,
      );

      final w = data.w(1), h = data.h(1);

      expect(w, smallerDeviceSize.width / uiSize.width);
      expect(w < 1, true);
      expect(h, smallerDeviceSize.height / uiSize.height);
      expect(h < 1, true);
    });

    test('Test bigger size', () {
      final data = ScreenUtilData.from(
        options: ScreenUtilOptions(designSize: uiSize),
        screenSize: biggerDeviceSize,
      );

      final w = data.w(1), h = data.h(1);

      expect(w, biggerDeviceSize.width / uiSize.width);
      expect(w > 1, true);
      expect(h, biggerDeviceSize.height / uiSize.height);
      expect(h > 1, true);
    });
  });

  group('[Test overflow]', () {
    testWidgets('Test overflow width', (tester) async {
      await tester.pumpWidget(ScreenUtil(
        options: ScreenUtilOptions(designSize: uiSize),
        child: Builder(builder: (context) {
          return MaterialApp(
            home: WidgetTest(width: () => context.w(uiSize.width)),
          );
        }),
      ));

      // Wait until all widget rendered
      // await tester.pumpAndSettle();

      // a Text widget must be present
      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('Test overflow height', (tester) async {
      await tester.pumpWidget(ScreenUtil(
        options: ScreenUtilOptions(designSize: uiSize),
        child: Builder(builder: (context) {
          return MaterialApp(
            home: WidgetTest(height: () => context.h(uiSize.height)),
          );
        }),
      ));

      // Wait until all widget rendered
      // await tester.pumpAndSettle();

      // a Text widget must be present
      expect(find.text('Test'), findsOneWidget);
    });
  });

  testWidgets('[Rebuilding]', (tester) async {
    final textFieldKey = UniqueKey();
    final buildCountNotifier = ValueNotifier(0);
    final focusNode = FocusNode();

    Finder textField() => find.byKey(textFieldKey);

    await tester.pumpWidget(ScreenUtil(
      options: ScreenUtilOptions(designSize: uiSize),
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              buildCountNotifier.value += 1;

              assert(
                context.w(uiSize.width) == MediaQuery.of(context).size.width,
                'ScreenUtil width must be equal to MediaQuery width',
              );

              return SizedBox(
                width: context.w(uiSize.width),
                height: context.h(uiSize.height),
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

    // await tester.pumpAndSettle();
    expect(buildCountNotifier.value, 1);

    expect(textField(), findsOneWidget);
    expect(focusNode.hasFocus, false);

    await tester.tap(textField()).then((_) => tester.pumpAndSettle());
    expect(textField(), findsOneWidget);
    expect(focusNode.hasFocus, true);
    expect(buildCountNotifier.value, 1);

    // Simulate keyboard
    tester.view.viewInsets = FakeViewPadding(bottom: 20);

    // await tester.pumpAndSettle();
    expect(focusNode.hasFocus, true);
    expect(buildCountNotifier.value, 1);
  });
}
