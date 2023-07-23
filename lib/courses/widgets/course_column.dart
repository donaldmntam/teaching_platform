import 'package:flutter/material.dart';
import 'package:teaching_platform/common/functions/iterable_functions.dart';

class CourseColumn extends StatefulWidget {
  final List<List<String>> courseGroups;

  const CourseColumn(
    this.courseGroups,
    {super.key}
  );

  @override
  State<CourseColumn> createState() => _CourseColumnState();
}

class _CourseColumnState extends State<CourseColumn> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: widget.courseGroups.mapIndexed((i, group) =>
          _Group(
            group,
            i == expandedIndex,
            () => setState(() {
              if (i == expandedIndex) {
                expandedIndex = null;
              } else {
                expandedIndex = i;
              }
            }),
          )
        ).toList()
      ),
    );
  }
}

class _Group extends StatelessWidget {
  final List<String> courses;
  final bool expanded;
  final void Function() onToggleExpand;

  const _Group(
    this.courses,
    this.expanded,
    this.onToggleExpand,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onToggleExpand,
          child: const Text("Expand")
        ),
        SizedBox(
          height: expanded ? null : 0,
          child: Column(
            children: courses.map(
              (course) => Text(course),
            ).toList()
          ),
        ),
      ]
    );
  }
}
