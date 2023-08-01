import 'package:flutter/material.dart' hide Theme;
import 'package:teaching_platform/common/functions/iterable_functions.dart';
import 'package:teaching_platform/common/widgets/services.dart/services.dart';
import 'package:teaching_platform/common/models/course/course_group.dart';
import 'package:teaching_platform/courses/widgets/course_column/typedefs.dart';

import 'course_group.dart';

class CourseColumn extends StatefulWidget {
  final List<CourseGroup> courseGroups;
  final OnCoursePressed onCoursePressed;

  const CourseColumn(
    this.courseGroups,
    {super.key,
    required this.onCoursePressed}
  );

  @override
  State<CourseColumn> createState() => _CourseColumnState();
}

class _CourseColumnState extends State<CourseColumn> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return SingleChildScrollView(
      child: Container(
        color: theme.colors.background, // todo: theming?
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: widget.courseGroups.mapIndexed((i, group) =>
            CourseGroupWidget(
              groupIndex: i,
              group: group,
              expanded: i == expandedIndex,
              onToggleExpand: () => setState(() {
                if (i == expandedIndex) {
                  expandedIndex = null;
                } else {
                  expandedIndex = i;
                }
              }),
              onCoursePressed: widget.onCoursePressed,
            )
          ).toList()
        ),
      ),
    );
  }
}
