import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:teaching_platform/common/models/task/input.dart';
import 'package:teaching_platform/common/models/task/question.dart';
import 'package:teaching_platform/common/models/task/task.dart';
import 'package:teaching_platform/tasks/widgets/question_column/question_column.dart';
import 'package:teaching_platform/tasks/widgets/task_column/task_column.dart';
import 'package:teaching_platform/tasks/widgets/timer/timer.dart';

double _mainBodyWidth(BoxConstraints constraints) => 
  constraints.maxWidth * 0.8;
double _taskColumnWidth(BoxConstraints constraints) =>
  constraints.maxWidth * 0.2;

class Page extends StatefulWidget {
  final IList<Task> tasks;

  const Page({
    super.key,
    required this.tasks,
  });

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> with SingleTickerProviderStateMixin {
  late final Ticker ticker;

  final Duration timeAllowed = const Duration(minutes: 60);
  late Duration timeRemaining;

  late int selectedTaskIndex;

  @override
  void initState() {
    final ticker = createTicker(onTick);
    ticker.start();
    this.ticker = ticker;

    timeRemaining = timeAllowed;

    selectedTaskIndex = 0;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onTick(Duration duration) {
    if (duration > timeAllowed) {
      setState(() => timeRemaining = const Duration(seconds: 0));
      ticker.stop();
      return;
    }
    setState(() => timeRemaining = timeAllowed - duration);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Row(
          children: [
            SizedBox(
              width: _taskColumnWidth(constraints),
              child: TaskColumn(
                tasks: widget.tasks,
                selectedTaskIndex: selectedTaskIndex,
                onTaskSelected: (index) => 
                  setState(() => selectedTaskIndex = index),
              )
            ),
            SizedBox(
              width: _mainBodyWidth(constraints),
              height: double.infinity,
              child: QuestionColumn(
                questions: widget.tasks[selectedTaskIndex].questions,
                onInputChange: (_, __) => {},
              ),
            ),
          ],
        );
      }
    );
  }
}