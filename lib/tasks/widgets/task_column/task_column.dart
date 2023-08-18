import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:teaching_platform/common/models/task/task.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/button/selectable_text_button.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';

const listSpacing = 16.0;

class TaskColumn extends StatelessWidget {
  final IList<Task> tasks;
  final int selectedTaskIndex;
  final void Function(int index) onTaskSelected;

  const TaskColumn({
    super.key,
    required this.tasks,
    required this.selectedTaskIndex,
    required this.onTaskSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    final widgets = _widgets(
      tasks: tasks,
      selectedTaskIndex: selectedTaskIndex,
      onTaskSelected: onTaskSelected,
    );
    return Container(
      color: theme.colors.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: listSpacing),
        child: ListView.builder(
          itemCount: widgets.length,
          itemBuilder: (_, index) => widgets[index],
        ),
      ),
    );
  }
}

List<Widget> _widgets({
  required IList<Task> tasks,
  required int selectedTaskIndex,
  required void Function(int index) onTaskSelected,
}) {
  final list = List<Widget>.empty(growable: true);

  list.add(const SizedBox(height: listSpacing));

  list.add(const _Text("Tasks"));
  list.add(const SizedBox(height: listSpacing));

  for (var i = 0; i < tasks.length; i++) {
    final task = tasks[i];
    if (i != 0) {
      list.add(const SizedBox(height: listSpacing));
    }
    list.add(
      SelectableTextButton(
        task.title,
        selected: i == selectedTaskIndex,
        onPressed: () => onTaskSelected(i),
      ),
    );
  }

  list.add(const SizedBox(height: listSpacing));

  return list;
}

class _Text extends StatelessWidget {
  final String text;

  const _Text(this.text);

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;

    return Text(
      text,
      style: theme.textStyle(
        size: 24,
        weight: FontWeight.bold,
        color: theme.colors.primary,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
