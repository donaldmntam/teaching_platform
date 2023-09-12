import 'input.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

extension ExtendedTaskInputs on IList<IList<Input>> {
  IList<IList<Input>> copy({ 
    required int taskIndex,
    required int questionIndex,
    required Input input,
  }) => replaceBy(
    taskIndex,
    (inputs) => inputs.replace(
      questionIndex,
      input,
    )
  );
}
