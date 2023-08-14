import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:teaching_platform/common/models/task/input.dart';

sealed class Question {
  final String title;

  const Question({required this.title});
}

final class TextQuestion extends Question {
  const TextQuestion({
    required super.title,
  });
  
  @override
  bool operator ==(Object? other) {
    if (other is! TextQuestion) return false;
    return title == other.title;
  }

  @override
  int get hashCode => title.hashCode;
}

final class McQuestion extends Question {
  final IList<String> options;

  const McQuestion({
    required super.title,
    required this.options,
  });

  @override
  bool operator ==(Object? other) {
    if (other is! McQuestion) return false;
    return title == other.title &&
      options == other.options;
  }
}
