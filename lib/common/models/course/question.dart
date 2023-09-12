import 'input.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:teaching_platform/common/monads/try.dart';
import 'package:teaching_platform/common/error/error.dart';

sealed class Question {
  final Duration timeStamp;
  const Question({required this.timeStamp});
}

final class McQuestion extends Question {
  final String description;
  final List<String> options;
  final McInput correctInput;
  
  const McQuestion({
    required super.timeStamp,
    required this.description,
    required this.options,
    required this.correctInput,
  });
}

final class TextQuestion extends Question {
  final String description;
  final IList<TextInput> correctInputs;

  const TextQuestion({
    required super.timeStamp,
    required this.description,
    required this.correctInputs,
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
      "options": List<Object?> encodedOptions,
      "correctInput": int correctOptionNumber,
    }
  ) {
    final options = List<String>.empty(growable: true);
    for (final encodedOption in encodedOptions) {
      if (encodedOption is! String) return null;
      options.add(encodedOption);
    }
    return McQuestion(
      description: description,
      timeStamp: Duration(minutes: minutes.toInt(), seconds: seconds.toInt()),
      options: options,
      correctInput: McInput(correctOptionNumber.toInt() - 1),
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
      "correctInputs": List<Object?> encodedCorrectInputs,
    }
  ) {
    final correctInputs = List<String>.empty(growable: true);
    for (final encodedCorrectInput in encodedCorrectInputs) {
      if (encodedCorrectInput is! String) return null;
      correctInputs.add(encodedCorrectInput);
    }
    return TextQuestion(
      description: description,
      timeStamp: Duration(minutes: minutes, seconds: seconds),
      correctInputs: correctInputs.map((text) => TextInput(text)).toIList(),
    );
  }
  return null;
}

extension ExtendedQuestion on Question {
  Try<bool> inputIsCorrect(Input input) {
    switch (this) {
      case TextQuestion(correctInputs: final correctInputs):
        if (input is! TextInput) {
          return Err(QuestionInputTypeMismatch(this, input));
        }
        return Ok(correctInputs.any((correctInput) => input == correctInput));
      case McQuestion(correctInput: final correctInput):
        if (input is! McInput) {
          return Err(QuestionInputTypeMismatch(this, input));
        }
        return Ok(input == correctInput);
    }
  }
}
