sealed class Question {
  final Duration timeStamp;
  const Question({required this.timeStamp});
}

final class McQuestion extends Question {
  final String description;
  final List<String> options;
  
  const McQuestion({
    required super.timeStamp,
    required this.description,
    required this.options,
  });
}

final class TextQuestion extends Question {
  final String description;

  const TextQuestion({
    required super.timeStamp,
    required this.description,
  });
}
