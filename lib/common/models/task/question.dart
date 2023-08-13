import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:teaching_platform/common/models/task/input.dart';

sealed class Question {
  final String title;

  const Question({required this.title});
}

final class TextQuestion extends Question {
  final TextInput input;

  const TextQuestion({
    required super.title,
    required this.input,
  });
  
  @override
  bool operator ==(Object? other) {
    if (other is! TextQuestion) return false;
    return input == other.input;
  }

  @override
  int get hashCode => input.hashCode;
}

final class McQuestion extends Question {
  final IList<String> options;
  final McInput input;

  const McQuestion({
    required super.title,
    required this.options,
    required this.input
  });

  @override
  bool operator ==(Object? other) {
    if (other is! McQuestion) return false;
    return options == other.options &&
      input == other.input;
  }
}
