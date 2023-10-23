import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:teaching_platform/common/models/course/question.dart';


typedef Lesson = ({
  String title,
  String video,
  int lastCompletedQuestionIndex,
  IList<Question> questions,
});

Lesson? jsonToLesson(Object? json) {
  if (
    json case {
      "title": String title,
      "video": String video,
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
      video: video,
      lastCompletedQuestionIndex: 0,
      questions: questions.lock,
    );
  }
  return null;
}
