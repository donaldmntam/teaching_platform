import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:teaching_platform/common/models/course/input.dart';

typedef CourseGroupInputs = IList<IList<IList<Input>>>;

extension ExtendedCourseInputs on CourseGroupInputs {
  Input input({
    required int courseIndex,
    required int lessonIndex,
    required int questionIndex
  }) {
    return this[courseIndex][lessonIndex][questionIndex];
  }

  CourseGroupInputs copy({
    required int courseIndex,
    required int lessonIndex,
    required int questionIndex,
    required Input input,
  }) => replaceBy(
    courseIndex,
    (courseInputs) => courseInputs.replaceBy(
      lessonIndex,
      (lessonInputs) => lessonInputs.replace(
        questionIndex,
        input,
      )
    )
  );
}