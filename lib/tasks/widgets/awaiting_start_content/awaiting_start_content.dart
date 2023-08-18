import 'package:flutter/widgets.dart';
import 'package:teaching_platform/common/widgets/button/text_button.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';

class AwaitingStartContent extends StatelessWidget {
  final int taskIndex;
  final void Function(int taskIndex) onStart;

  const AwaitingStartContent({
    super.key,
    required this.taskIndex,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Container(
      alignment: Alignment.center,
      color: theme.colors.surface,
      child: TextButton(
        "Start",
        onPressed: () => onStart(taskIndex),
      )
    );
  }
}