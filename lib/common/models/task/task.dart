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
