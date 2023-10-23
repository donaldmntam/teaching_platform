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

Question? jsonToQuestion(Object? json) {
  if (
    json case {
      "type": String type,
    }
  ) {
    return switch (type) {
      "mc" => jsonToMcQuestion(json),
      "text" => jsonToTextQuestion(json),
      _ => null,
    };
  }
  return null;
}

McQuestion? jsonToMcQuestion(Object? json) {
  if (
    json case {
      "description": String description,
      "options": List<Object?> encodedOptions,
    }
  ) {
    final options = List<String>.empty(growable: true);
    for (final encodedOption in encodedOptions) {
      if (encodedOption is! String) {
        print("encodedOption is not string");
        return null;
      }
      print("encodedOption is string");
      options.add(encodedOption);
    }
    return McQuestion(
      description: description,
      options: options.lock,
    );
  }
  return null;
}

TextQuestion? jsonToTextQuestion(Object? json) {
  if (
    json case {
      "description": String description,
    }
  ) {
    return TextQuestion(
      description: description,
    );
  }
  return null;
}
