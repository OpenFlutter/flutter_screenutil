import 'package:flutter/widgets.dart';
import 'src/first_method.dart' as firstMethod;
import 'src/second_method.dart' as secondMethod;

void main() {
  const method = int.fromEnvironment('method', defaultValue: 1);
  runApp(method == 1 ? firstMethod.MyApp() : secondMethod.MyApp());
}
