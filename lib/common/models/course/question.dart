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
      "timeStamp": {
        "minutes": int minutes,
        "seconds": int seconds,
      },
      "options": List<String> options,
    }
  ) {
    return McQuestion(
      description: description,
      timeStamp: Duration(minutes: minutes, seconds: seconds),
      options: options,
    );
  }
  return null;
}

TextQuestion? jsonToTextQuestion(Object? json) {
  if (
    json case {
      "description": String description,
      "timeStamp": {
        "minutes": int minutes,
        "seconds": int seconds,
      },
    }
  ) {
    return TextQuestion(
      description: description,
      timeStamp: Duration(minutes: minutes, seconds: seconds),
    );
  }
  return null;
}
