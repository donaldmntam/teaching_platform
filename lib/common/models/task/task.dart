import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:teaching_platform/common/models/task/input.dart';
import 'package:teaching_platform/common/models/task/question.dart';

typedef Task = ({
  String title,
  Duration timeAllowed,
  IList<Question> questions,
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
    }
  ) {
    final questions = List<Question>.empty(growable: true);
    for (final encodedQuestion in encodedQuestions) {
      final question = jsonToQuestion(encodedQuestion);
      if (question == null) return null;
      questions.add(question);
    }
    return (
      title: title,
      timeAllowed: Duration(minutes: minutes, seconds: seconds),
      questions: questions.lock,
    );
  }
  return null;
}

IList<Task>? jsonToTasks(Object? json) {
  if (json is! List<Object?>) return null;
  final tasks = List<Task>.empty(growable: true);
  for (final encoded in json) {
    final task = jsonToTask(encoded);
    if (task == null) return null;
    tasks.add(task);
  }
  return tasks.lock;
}
