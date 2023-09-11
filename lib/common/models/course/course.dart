import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'lesson.dart';

typedef Course = ({ 
  String title,
  IList<Lesson> lessons,
});

Course? jsonToCourse(Object? json) {
  if (
    json case {
      "title": String title,
      "lessons": List<Object?> encodedLessons,
    }
  ) {
    final lessons = List<Lesson>.empty(growable: true);
    for (final encodedLesson in encodedLessons) {
      final lesson = jsonToLesson(encodedLesson);
      if (lesson == null) return null;
      lessons.add(lesson);
    }
    return (
      title: title,
      lessons: lessons.lock,
    );
  }
  return null;
}
