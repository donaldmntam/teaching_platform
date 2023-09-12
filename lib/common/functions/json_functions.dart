import 'dart:convert';
import 'package:teaching_platform/common/monads/try.dart';

Try<Object?> tryJsonDecode(String string) {
  try {
    return Ok(jsonDecode(string));
  } catch(e) {
    return Err(e);
  }
}
