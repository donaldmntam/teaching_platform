import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';
import 'package:teaching_platform/common/functions/iterable_functions.dart';
import 'package:teaching_platform/common/models/course/lesson.dart';
import 'package:teaching_platform/common/widgets/button/selectable_text_button.dart';

class LessonSelection extends StatelessWidget {
  final IList<Lesson> lessons;
  final int selectedIndex;
  final void Function(int) onSelect;

  const LessonSelection(
    this.lessons,
    {super.key,
    required this.selectedIndex,
    required this.onSelect}
  );

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: lessons.mapIndexed<Widget>((i, lesson) =>
        SelectableTextButton(
          lesson.title,
          selected: selectedIndex == i,
          onPressed: () => onSelect(i), 
        )
      ).toList()
    );
  }
}
