import 'package:teaching_platform/common/models/course/question.dart';


typedef Lesson = ({
  String title,
  String videoUrl,
  int lastCompletedQuestionIndex,
  List<Question> questions,
});