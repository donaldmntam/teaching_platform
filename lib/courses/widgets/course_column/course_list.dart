import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:teaching_platform/common/functions/iterable_functions.dart';
import 'package:teaching_platform/common/widgets/proportion_box/proportion_box.dart';
import 'package:teaching_platform/common/widgets/tappable/tappable.dart';
import 'package:teaching_platform/common/models/course/course.dart';
import 'package:teaching_platform/courses/widgets/course_column/course_text.dart';
import 'package:teaching_platform/courses/widgets/course_column/typedefs.dart';

const _curve = Curves.easeInOutQuad;

class CourseListWidget extends StatefulWidget {
  final int groupIndex;
  final IList<Course> courses;
  final bool expanded;
  final OnCoursePressed onCoursePressed;

  const CourseListWidget({
    super.key,
    required this.groupIndex,
    required this.courses,
    required this.expanded,
    required this.onCoursePressed,
  });

  @override
  State<CourseListWidget> createState() => _CourseListWidgetState();
}

class _CourseListWidgetState extends State<CourseListWidget> 
  with SingleTickerProviderStateMixin
{
  late double animationValue;
  late final AnimationController controller;

  @override
  void initState() {
    final animationValue = widget.expanded ? 1.0 : 0.0;
    this.animationValue = animationValue;

    controller = AnimationController(
      value: animationValue,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 200),
      vsync: this
    );
    controller.addListener(() {
      setState(() => this.animationValue = _curve.transform(controller.value));
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CourseListWidget oldWidget) {
    if (widget.expanded == oldWidget.expanded) return;
    if (widget.expanded) {
      controller.forward();
    } else {
      controller.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ProportionBox(
      proportion: animationValue,
      child: Column(
        children: widget.courses.mapIndexed(
          (i, course) => Tappable(
            onTap: () => widget.onCoursePressed(widget.groupIndex, i),
            child: SizedBox(
              width: double.infinity,
              child: CourseText(course.title)
            )
          ),
        ).toList()
      ),
    );
  }
}
