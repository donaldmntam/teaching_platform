import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:teaching_platform/common/models/task/input.dart';

sealed class Question {
  final String description;

  const Question({required this.description});
}

final class TextQuestion extends Question {
  const TextQuestion({
    required super.description,
  });
  
  @override
  bool operator ==(Object? other) {
    if (other is! TextQuestion) return false;
    return description == other.description;
  }

  @override
  int get hashCode => description.hashCode;
}

final class McQuestion extends Question {
  final IList<String> options;

  const McQuestion({
    required super.description,
    required this.options,
  });

  @override
  bool operator ==(Object? other) {
    if (other is! McQuestion) return false;
    return description == other.description &&
      options == other.options;
  }

  @override
  int get hashCode => description.hashCode ^
    options.hashCode;
}
