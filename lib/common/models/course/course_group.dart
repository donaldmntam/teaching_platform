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

IList<CourseGroup>? jsonToCourseGroups(Object? json) {
  if (json is! List<Object?>) return null;
  final courseGroups = List<CourseGroup>.empty(growable: true);
  for (final encoded in json) {
    final courseGroup = jsonToCourseGroup(encoded);
    if (courseGroup == null) return null;
    courseGroups.add(courseGroup);
  }
  return courseGroups.lock;
}
