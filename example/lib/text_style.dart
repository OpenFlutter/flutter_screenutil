import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles {
  TextStyle t1 = TextStyle(fontSize: 24.ssp, color: Colors.black);
  TextStyle t2 = TextStyle(fontSize: 24.sp, color: Colors.black);
}

var ts = TextStyles();

class TextStyle2 {
  static TextStyle2 ts2;

  factory TextStyle2() {
    if (ts2 == null) {
      ts2 = TextStyle2();
    }
    return ts2;
  }

  TextStyle t1 = TextStyle(fontSize: 24.ssp, color: Colors.black);
  TextStyle t2 = TextStyle(fontSize: 24.sp, color: Colors.black);
}
