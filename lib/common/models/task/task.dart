import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:teaching_platform/common/models/task/input.dart';
import 'package:teaching_platform/common/models/task/question.dart';

typedef Task = ({
  String title,
  Duration timeAllowed,
  IList<Question> questions,
  IList<Input> inputs,
});

extension ExtendedTask on Task {
  Task copyBy({
    String Function(String)? title,
    Duration Function(Duration)? timeAllowed,
    IList<Question> Function(IList<Question>)? questions,
    IList<Input> Function(IList<Input>)? inputs,
  }) => (
    title: title?.call(this.title) ?? this.title,
    timeAllowed: timeAllowed?.call(this.timeAllowed) ?? this.timeAllowed,
    questions: questions?.call(this.questions) ?? this.questions,
    inputs: inputs?.call(this.inputs) ?? this.inputs,
  );
}

Task? jsonToTask(Object? json) {
  if (
    json case {
      "title": String title,
      "timeAllowed": {
        "minutes": int minutes,
        "seconds": int seconds,
      },
      "questions": List<Object?> encodedQuestions,
      "inputs": List<Object?> encodedInputs,
    }
  ) {
    final questions = List<Question>.empty(growable: true);
    for (final encodedQuestion in encodedQuestions) {
      final question = jsonToQuestion(encodedQuestion);
      if (question == null) return null;
      questions.add(question);
    }
    final inputs = List<Input>.empty(growable: true);
    for (final encodedInput in encodedInputs) {
      final input = jsonToInput(encodedInput);
      if (input == null) return null;
      inputs.add(input);
    }
    return (
      title: title,
      timeAllowed: Duration(minutes: minutes, seconds: seconds),
      questions: questions.lock,
      inputs: inputs.lock,
    );
  }
  return null;
}
