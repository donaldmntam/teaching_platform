sealed class Question {
  final Duration location;
  const Question({required this.location});
}

final class McQuestion extends Question {
  final String description;
  final List<String> options;
  
  const McQuestion({
    required super.location,
    required this.description,
    required this.options,
  });
}

final class TextQuestion extends Question {
  final String description;

  const TextQuestion({
    required super.location,
    required this.description,
  });
}
