import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:teaching_platform/common/models/course/question.dart';


typedef Lesson = ({
  String title,
  String videoUrl,
  int lastCompletedQuestionIndex,
  IList<Question> questions,
});