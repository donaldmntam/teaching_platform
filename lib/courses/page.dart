import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide TextButton, State, Theme;
import 'package:flutter/widgets.dart' as widgets show State;
import 'package:teaching_platform/common/functions/iterable_functions.dart';
import 'package:teaching_platform/common/functions/list_functions.dart';
import 'package:teaching_platform/common/models/course/course_group.dart';
import 'package:teaching_platform/common/models/course/course_group_inputs.dart';
import 'package:teaching_platform/common/models/course/input.dart';
import 'package:teaching_platform/common/models/course/question.dart';
import 'package:teaching_platform/courses/widgets/content/content.dart';
import 'package:teaching_platform/courses/widgets/course_column/course_column.dart';
import 'package:teaching_platform/courses/widgets/question_column/question_column.dart';

const _courseColumnRelativeWidth = 0.2;
const _contentRelativeWidth = 0.6;
const _questionColumnRelativeWidth = 0.2;

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  widgets.State<Page> createState() => _State();
}

class _State extends widgets.State<Page> {
  // List<Course> courses;
  final IList<CourseGroup> testCoursesGroups = repeat(["Design Thinking", "Leadership", "Marketing"], 10).mapIndexed((i, title) => (
      title: title,
      courses: List.generate(5, (i) => 
        (title: "course $i", lessons: List.generate(8, 
          (i) => (
            title: "lesson $i",
            videoUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
            lastCompletedQuestionIndex: -1,
            questions: <Question>[
              const TextQuestion(timeStamp: const Duration(seconds: 1), description: "What is love?"),
              const TextQuestion(timeStamp: const Duration(seconds: 2), description: "Do you have a big dong?"),
              const TextQuestion(timeStamp: const Duration(seconds: 3), description: "Knock knock, who's there?"),
              const TextQuestion(timeStamp: const Duration(seconds: 4), description: "Joe who?"),
            ].lock
          )
        ).lock)
      ).lock
    )).toIList();
  final CourseGroupInputs initialInputs = List.generate(5, (i) =>
    List.generate(8, (i) =>
      <Input>[
        const TextInput(""),
        const TextInput(""),
        const TextInput(""),
        const TextInput(""),
      ].lock
    ).lock
  ).lock;
  final CourseGroupInputs correctInputs = List.generate(5, (i) =>
    List.generate(8, (i) =>
      <Input>[
        const TextInput("baby don't hurt me"),
        const TextInput("yes"),
        const TextInput("joe"),
        const TextInput("joe mama"),
      ].lock
    ).lock
  ).lock;
  int groupIndex = 0;
  int courseIndex = 0;
  int lessonIndex = 0;

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
              SizedBox(
                width: constraints.maxWidth * _contentRelativeWidth,
                height: constraints.maxHeight,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Content(
                      lessonIndex: lessonIndex,
                      course: testCoursesGroups[groupIndex].courses[courseIndex],
                      initialInputs: initialInputs[groupIndex],
                      didSelectLesson: (index) => setState(() => 
                        lessonIndex = index
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: constraints.maxWidth * _questionColumnRelativeWidth,
                height: constraints.maxHeight,
                child: QuestionColumn(
                  testCoursesGroups[groupIndex]
                    .courses[courseIndex]
                    .lessons[lessonIndex]
                    .questions
                )
              )
            ]
          ),
        );
      }
    );
  }
}

