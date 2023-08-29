import 'package:flutter_test/flutter_test.dart';
import 'package:teaching_platform/common/monads/optional.dart';
import 'package:teaching_platform/courses/widgets/content/functions.dart';
import 'package:teaching_platform/courses/widgets/content/state.dart';

void main() => test("slider_value_test", () {
  const state = Playing(
    duration: Duration(seconds: 10),
    position: Duration(seconds: 1),
  );
  final value = sliderValue(state);
  print("value $value");
});