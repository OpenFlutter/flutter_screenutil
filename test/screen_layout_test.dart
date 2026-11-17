import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const phone = Size(393, 873);
  const foldCover = Size(344, 882);
  const foldOpenPortrait = Size(770, 930);
  const foldOpenLandscape = Size(930, 770);
  const tabletLandscape = Size(1280, 800);
  const splitScreen = Size(1280, 400);

  group('resolveLayoutMode', () {
    test('phone khong ban le', () {
      expect(resolveLayoutMode(phone, isFoldable: false), ScreenLayoutMode.phone);
    });
    test('fold gap lai (shortestSide < 600)', () {
      expect(resolveLayoutMode(foldCover, isFoldable: true), ScreenLayoutMode.foldedCompact);
    });
    test('fold mo doc / ngang', () {
      expect(resolveLayoutMode(foldOpenPortrait, isFoldable: true), ScreenLayoutMode.expandedPortrait);
      expect(resolveLayoutMode(foldOpenLandscape, isFoldable: true), ScreenLayoutMode.expandedLandscape);
    });
    test('tablet ngang va split-screen ngang', () {
      expect(resolveLayoutMode(tabletLandscape, isFoldable: false), ScreenLayoutMode.expandedLandscape);
      expect(resolveLayoutMode(splitScreen, isFoldable: false), ScreenLayoutMode.expandedLandscape);
    });
    test('dien thoai xoay ngang giu logic cu', () {
      expect(resolveLayoutMode(const Size(873, 393), isFoldable: false), ScreenLayoutMode.phone);
      expect(resolveLayoutMode(const Size(873, 393), isFoldable: true), ScreenLayoutMode.phone);
    });
  });

  group('scale s va bodyW', () {
    test('s = max(0.85, min(W/375, H/812))', () {
      expect(resolveScale(phone), closeTo(393 / 375, 1e-9));
      expect(resolveScale(foldCover), closeTo(344 / 375, 1e-9));
      expect(resolveScale(foldOpenPortrait), closeTo(930 / 812, 1e-9));
      expect(resolveScale(foldOpenLandscape), closeTo(770 / 812, 1e-9));
      expect(resolveScale(tabletLandscape), closeTo(800 / 812, 1e-9));
      expect(resolveScale(splitScreen, withFloor: true), 0.85);
      expect(resolveScale(splitScreen), closeTo(400 / 812, 1e-9));
    });

    test('vi du trong plan: fold ngang ~0.95, tablet ~0.98', () {
      expect(resolveScale(foldOpenLandscape), closeTo(0.95, 0.005));
      expect(resolveScale(tabletLandscape), closeTo(0.98, 0.01));
    });

    test('khung 4:3: frameW = min(W - 32, H * 3/4)', () {
      expect(resolveFrameWidth(foldOpenLandscape), closeTo(577.5, 1e-9));
      expect(resolveFrameWidth(tabletLandscape), 600);
      expect(resolveFrameWidth(splitScreen), 300);
      expect(resolveFrameWidth(const Size(500, 800)), 468); // bi gioi han boi W - 32
    });

    test('wide scale = min(W/812, H/667)', () {
      expect(resolveWideScale(tabletLandscape), closeTo(800 / 667, 1e-9));
      expect(resolveWideScale(foldOpenLandscape), closeTo(930 / 812, 1e-9));
    });
  });

  group('resolveScreenLayout (Android)', () {
    ScreenLayout android(Size s, {bool fold = false, bool wide = false}) =>
        resolveScreenLayout(s, isFoldable: fold, wideLayout: wide, isIOS: false);

    test('phone doc: scale deu theo rate 375x812', () {
      final l = android(phone);
      expect(l.mode, ScreenLayoutMode.phone);
      expect(l.scaleOverride, closeTo(393 / 375, 1e-9));
      expect(l.bodySize.width, closeTo(393, 1e-9));
      expect(l.isMobile, isTrue);
    });

    test('phone doc thap/rong (Fold8 man ngoai 416x633): uu tien chieu cao, khong tran', () {
      final l = android(const Size(416, 633));
      final s = 633 / 812;
      expect(l.scaleOverride, closeTo(s, 1e-9));
      expect(l.bodySize.height, closeTo(633, 1e-9));
      expect(l.bodySize.width, closeTo(375 * s, 1e-9));
    });

    test('phone ngang: giu logic cu', () {
      final l = android(const Size(873, 393));
      expect(l.mode, ScreenLayoutMode.phone);
      expect(l.scaleOverride, isNull);
      expect(l.bodySize, const Size(873, 393));
    });

    test('foldedCompact: full man, s dong deu', () {
      final l = android(foldCover, fold: true);
      expect(l.mode, ScreenLayoutMode.foldedCompact);
      expect(l.frameSize, foldCover);
      // view theo rate 375x812 fit trong man: s = 344/375
      expect(l.bodySize.width, closeTo(344, 1e-9));
      expect(l.bodySize.height, closeTo(812 * 344 / 375, 1e-9));
      expect(l.scaleOverride, closeTo(344 / 375, 1e-9));
    });

    test('expandedPortrait: full man', () {
      final l = android(foldOpenPortrait, fold: true);
      expect(l.mode, ScreenLayoutMode.expandedPortrait);
      expect(l.frameSize, foldOpenPortrait);
      expect(l.bodySize.height, closeTo(930, 1e-9));
      expect(l.bodySize.width, closeTo(375 * 930 / 812, 1e-9));
      expect(l.isFramed, isFalse);
      expect(l.isMobile, isFalse);
    });

    test('expandedLandscape: khung 4:3', () {
      final l = android(foldOpenLandscape, fold: true);
      expect(l.mode, ScreenLayoutMode.expandedLandscape);
      // khung 4:3 chi de dong khung
      expect(l.frameSize.width, closeTo(577.5, 1e-9));
      expect(l.frameSize.height, 770);
      expect(l.isFramed, isTrue);
      // view tinh theo rate 375x812 fit trong khung, KHONG lay kich thuoc khung
      final s = 770 / 812;
      expect(l.scaleOverride, closeTo(s, 1e-9));
      expect(l.bodySize.width, closeTo(375 * s, 1e-9));
      expect(l.bodySize.height, closeTo(770, 1e-9));
      expect(l.bodySize.width / l.bodySize.height, closeTo(375 / 812, 1e-9));

      final t = android(tabletLandscape);
      expect(t.frameSize, const Size(600, 800));
      expect(t.bodySize.height, closeTo(800, 1e-9));
      expect(t.bodySize.width, closeTo(375 * 800 / 812, 1e-9));

      final sp = android(splitScreen);
      expect(sp.frameSize, const Size(300, 400));
      expect(sp.scaleOverride, 0.85);
      expect(sp.bodySize, const Size(375 * 0.85, 812 * 0.85));
    });

    test('route wide: bo khung, full man', () {
      final l = android(tabletLandscape, wide: true);
      expect(l.isFullBleed, isTrue);
      expect(l.isFramed, isFalse);
      expect(l.frameSize, tabletLandscape);
      expect(l.bodySize, tabletLandscape);
      expect(l.scaleOverride, closeTo(800 / 667, 1e-9));
    });

    test('route wide khi doc: bi bo qua', () {
      final l = android(foldOpenPortrait, wide: true, fold: true);
      expect(l.mode, ScreenLayoutMode.expandedPortrait);
      expect(l.scaleOverride, closeTo(930 / 812, 1e-9));
    });

    test('Pixel Tablet emulator 816x584 (density cao): la man lon, khong phai phone', () {
      final l = android(const Size(816, 584));
      expect(l.mode, ScreenLayoutMode.expandedLandscape);
      expect(l.isFramed, isTrue);
      final p = android(const Size(584, 816));
      expect(p.mode, ScreenLayoutMode.expandedPortrait);
    });

    test('phone ngang 873x393 van la phone', () {
      expect(android(const Size(873, 393)).mode, ScreenLayoutMode.phone);
    });

    test('khong cache: goi lai voi kich thuoc khac cho ket qua khac', () {
      expect(android(foldOpenPortrait, fold: true).mode, ScreenLayoutMode.expandedPortrait);
      expect(android(foldCover, fold: true).mode, ScreenLayoutMode.foldedCompact);
      expect(android(foldOpenLandscape, fold: true).mode, ScreenLayoutMode.expandedLandscape);
    });
  });

  group('resolveScreenLayout (iOS giu nguyen)', () {
    test('iPhone thuong: size nguyen ban', () {
      final l = resolveScreenLayout(phone, isIOS: true);
      expect(l.bodySize, phone);
      expect(l.scaleOverride, isNull);
    });

    test('iPhone 8 (16:9): size theo rate 812/375', () {
      final l = resolveScreenLayout(const Size(375, 667), isIOS: true);
      expect(l.bodySize.height, 667);
      expect(l.bodySize.width, closeTo(667 / (812 / 375), 1e-9));
    });

    test('iPad doc: giu logic cu', () {
      final p = resolveScreenLayout(const Size(820, 1180), isIOS: true);
      expect(p.mode, ScreenLayoutMode.expandedPortrait);
      expect(p.scaleOverride, isNull);
      expect(p.isFramed, isFalse);
    });

    test('iPad ngang: khung 4:3 nhu Android, view theo rate 375x812', () {
      final ls = resolveScreenLayout(const Size(1180, 820), isIOS: true);
      expect(ls.mode, ScreenLayoutMode.expandedLandscape);
      expect(ls.isFramed, isTrue);
      expect(ls.frameSize, const Size(615, 820)); // min(1180-32, 820*3/4)
      final s = 820 / 812;
      expect(ls.scaleOverride, closeTo(s, 1e-9));
      expect(ls.bodySize.width, closeTo(375 * s, 1e-9));
      expect(ls.bodySize.height, closeTo(820, 1e-9));
    });

    test('iPad ngang + route wide: giu logic cu, khong khung', () {
      final ls = resolveScreenLayout(const Size(1180, 820), isIOS: true, wideLayout: true);
      expect(ls.isFramed, isFalse);
      expect(ls.scaleOverride, isNull);
      final p = resolveScreenLayout(const Size(820, 1180), isIOS: true);
      expect(p.bodySize.width / 375, closeTo(ls.bodySize.width / 812, 1e-9));
    });

    test('iPhone ngang (trang ngang) khong bi dong khung', () {
      final l = resolveScreenLayout(const Size(844, 390), isIOS: true);
      expect(l.isFramed, isFalse);
    });
  });

  group('ScreenUtil.configure voi scaleOverride', () {
    test('w = h = sp = s, screenWidth = bodyW', () {
      ScreenUtil.configure(
        data: const MediaQueryData(size: Size(600, 800)),
        designSize: const Size(375, 812),
        minTextAdapt: false,
        splitScreenMode: false,
        scaleOverride: 0.9,
      );
      expect(10.w, closeTo(9, 1e-9));
      expect(10.h, closeTo(9, 1e-9));
      expect(10.sp, closeTo(9, 1e-9));
      expect(10.r, closeTo(9, 1e-9));
      expect(ScreenUtil().screenWidth, 600);
    });

    test('scale listener chay khi scale doi, khong chay khi giu nguyen', () {
      var calls = 0;
      void l() => calls++;
      ScreenUtil.configure(
        data: const MediaQueryData(size: Size(600, 800)),
        designSize: const Size(375, 812),
        minTextAdapt: false,
        splitScreenMode: false,
        scaleOverride: 0.9,
      );
      ScreenUtil.addScaleListener(l); // da configure -> goi ngay 1 lan
      expect(calls, 1);
      ScreenUtil.configure(scaleOverride: 0.9);
      expect(calls, 1);
      ScreenUtil.configure(scaleOverride: 1.1);
      expect(calls, 2);
      ScreenUtil.removeScaleListener(l);
      ScreenUtil.configure(scaleOverride: 1.2);
      expect(calls, 2);
    });
  });
}
