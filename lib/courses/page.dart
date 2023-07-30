import 'package:flutter/material.dart' hide TextButton, State, Theme;
import 'package:flutter/widgets.dart' as widgets show State;
import 'package:teaching_platform/common/functions/iterable_functions.dart';
import 'package:teaching_platform/common/functions/list_functions.dart';
import 'package:teaching_platform/courses/widgets/content.dart';
import 'package:teaching_platform/courses/widgets/course_column/course_column.dart';

import 'models/course.dart';

const _courseColumnRelativeWidth = 0.2;
const _contentRelativeWidth = 0.6;

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  widgets.State<Page> createState() => _State();
}

class _State extends widgets.State<Page> {
  // List<Course> courses;
  final testCoursesGroups = repeat(["Design Thinking", "Leadership", "Marketing"], 10).mapIndexed((i, title) => (
      title: title,
      courses: List.generate(5, (i) => 
        (title: "course $i", lessons: List.generate(5, 
          (i) => (title: "lesson $i", videoUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"))
        )
      )
    ))
    .toList();
  int groupIndex = 0;
  int courseIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      

    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Row(
            children: [
              SizedBox(
                width: constraints.maxWidth * _courseColumnRelativeWidth,
                height: constraints.maxHeight,
                child: CourseColumn(
                  testCoursesGroups,
                  onCoursePressed: (groupIndex, courseIndex) => setState(() {
                    this.groupIndex = groupIndex;
                    this.courseIndex = courseIndex;
                  }),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(32),
                width: constraints.maxWidth * _contentRelativeWidth,
                height: constraints.maxHeight,
                child: Content(
                  course: testCoursesGroups[groupIndex].courses[courseIndex],
                ),
              ),
            ]
          ),
        );
      }
    );
  }
}

