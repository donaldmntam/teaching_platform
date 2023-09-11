import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'course.dart';

typedef CourseGroup = ({
  String title,
  IList<Course> courses,
});

CourseGroup? jsonToCourseGroup(Object? json) {
  if (
    json case {
      "title": String title,
      "courses": List<Object?> encodedCourses,
    }
  ) {
    final courses = List<Course>.empty(growable: true);
    for (final encodedCourse in encodedCourses) {
      final course = jsonToCourse(encodedCourse);
      if (course == null) return null;
      courses.add(course);
    }
    return (
      title: title,
      courses: courses.lock,
    );
  }
  return null;
}
