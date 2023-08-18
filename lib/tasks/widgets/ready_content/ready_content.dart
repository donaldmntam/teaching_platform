import 'package:flutter/material.dart' hide TextButton;
import 'package:teaching_platform/common/models/task/input.dart';
import 'package:teaching_platform/common/widgets/button/text_button.dart';
import 'package:teaching_platform/common/widgets/line_shadow/line_shadow.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/tasks/models/state.dart';
import 'package:teaching_platform/tasks/widgets/question_column/question_column.dart';
import 'package:teaching_platform/tasks/widgets/task_column/task_column.dart';
import 'package:teaching_platform/tasks/widgets/timer/timer.dart';

const _overlayVerticalPadding = 6.0;

class ReadyContent extends StatelessWidget {
  final int taskIndex;
  final Ready state;
  final void Function({
    required int taskIndex,
    required int questionIndex,
    required Input input,
  }) onInputChange;
  final void Function(int taskIndex) onFinish;

  const ReadyContent({
    super.key,
    required this.taskIndex,
    required this.state,
    required this.onInputChange,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            right: listSpacing,
            top: _overlayVerticalPadding,
            bottom: _overlayVerticalPadding,
          ),
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            color: theme.colors.surface,
          ),
          child: Timer(state.timeRemaining),
        ),
        Flexible(
          flex: 1,
          child: Stack(
            children: [
              QuestionColumn(
                taskIndex: taskIndex,
                questions: state.tasks[taskIndex].questions,
                inputs: state.tasks[taskIndex].inputs,
                onInputChange: onInputChange,
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: double.infinity, 
                  height: 2,
                  child: LineShadow(),
                ),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity, 
                  height: 2,
                  child: LineShadow(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          color: theme.colors.surface,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(
            top: _overlayVerticalPadding,
            bottom: _overlayVerticalPadding,
          ),
          child: TextButton(
            "Finish",
            onPressed: () => onFinish(taskIndex),
          )
        )
      ],
    );
  }
}