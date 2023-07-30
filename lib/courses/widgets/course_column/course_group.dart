import 'package:flutter/material.dart';
import 'package:teaching_platform/common/widgets/services.dart/services.dart';
import 'package:teaching_platform/courses/models/course_group.dart';
import 'package:teaching_platform/courses/widgets/course_column/typedefs.dart';

import 'course_list.dart';
import 'course_text.dart';
import 'values.dart';

class CourseGroupWidget extends StatelessWidget {
  final int groupIndex;
  final CourseGroup group;
  final bool expanded;
  final void Function() onToggleExpand;
  final OnCoursePressed onCoursePressed;

  const CourseGroupWidget({
    super.key,
    required this.groupIndex,
    required this.group,
    required this.expanded,
    required this.onToggleExpand,
    required this.onCoursePressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onToggleExpand,
          child: Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: CourseText(group.title)
              ),
              Flexible(
                flex: 0,
                child: Icon(
                  expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: theme.colors.primary,
                  size: height,
                ),
              )
            ]
          ),
        ),
        CourseListWidget(
          groupIndex: groupIndex,
          courses: group.courses,
          expanded: expanded,
          onCoursePressed: onCoursePressed,
        ),
      ]
    );
  }
}
