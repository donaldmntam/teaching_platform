import 'package:flutter/material.dart' hide Theme;
import 'package:flutter/scheduler.dart';
import 'package:teaching_platform/common/functions/iterable_functions.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/proportion_box/proportion_box.dart';
import 'package:teaching_platform/common/widgets/services.dart/services.dart';
import 'package:teaching_platform/courses/models/course_group.dart';

const _height = 40.0;
const _curve = Curves.easeInOutQuad;

class CourseColumn extends StatefulWidget {
  final List<CourseGroup> courseGroups;

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
      child: Container(
        color: Colors.grey[200], // todo: theming?
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
      ),
    );
  }
}

class _Group extends StatelessWidget {
  final CourseGroup group;
  final bool expanded;
  final void Function() onToggleExpand;

  const _Group(
    this.group,
    this.expanded,
    this.onToggleExpand,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Column(
      children: [
        GestureDetector(
          onTap: onToggleExpand,
          child: Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: _Text(group.title)
              ),
              Flexible(
                flex: 0,
                child: Icon(
                  expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: theme.colors.primary,
                  size: _height,
                ),
              )
            ]
          ),
        ),
        _CourseList(group: group, expanded: expanded),
      ]
    );
  }
}

class _Text extends StatelessWidget {
  final String text;

  const _Text(this.text);

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      width: double.infinity,
      height: _height,
      child: FittedBox(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: theme.textStyle(
            size: 18,
            weight: FontWeight.bold,
            color: theme.colors.primary,
          )
        )
      )
    );
  }
}

class _CourseList extends StatefulWidget {
  final CourseGroup group;
  final bool expanded;

  const _CourseList({
    required this.group,
    required this.expanded,
  });

  @override
  State<_CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<_CourseList> 
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
  void didUpdateWidget(_CourseList oldWidget) {
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
    print("animationValue $animationValue");
    return ProportionBox(
      proportion: animationValue,
      child: Column(
        children: widget.group.courses.map(
          (course) => _Text(course.title),
        ).toList()
      ),
    );
  }
}
