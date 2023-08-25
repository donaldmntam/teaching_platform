import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:teaching_platform/common/models/course/input.dart';

typedef CourseInputs = IList<IList<Input>>;

extension ExtendedCourseInputs on CourseInputs {
  Input input({
    required int lessonIndex,
    required int questionIndex
  }) {
    return this[lessonIndex][questionIndex];
  }

  CourseInputs copy({
    required int lessonIndex,
    required int questionIndex,
    required Input input,
  }) => replaceBy(
    lessonIndex,
    (lessonInputs) => lessonInputs.replace(
      questionIndex,
      input,
    )
  );
}