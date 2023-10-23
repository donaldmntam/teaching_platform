import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:teaching_platform/common/models/course/input.dart';

// TODO: remove
typedef CourseGroupInputs = IList<IList<IList<IList<Input>>>>;

extension ExtendedCourseInputs on CourseGroupInputs {
  Input input({
    required int groupIndex,
    required int courseIndex,
    required int lessonIndex,
    required int questionIndex
  }) {
    return this[groupIndex][courseIndex][lessonIndex][questionIndex];
  }

  CourseGroupInputs copy({
    required int groupIndex,
    required int courseIndex,
    required int lessonIndex,
    required int questionIndex,
    required Input input,
  }) => replaceBy(
    groupIndex,
    (groupInputs) => groupInputs.replaceBy(
      courseIndex,
      (courseInputs) => courseInputs.replaceBy(
        lessonIndex,
        (lessonInputs) => lessonInputs.replace(
          questionIndex,
          input,
        )
      )
    )
  );
}
