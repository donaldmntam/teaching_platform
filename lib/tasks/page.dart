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
  const Page({
    super.key,
  });

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> with SingleTickerProviderStateMixin {
  late final Ticker ticker;

  final Duration timeAllowed = const Duration(minutes: 60);
  late Duration timeRemaining;

  IList<Task> tasks = _initialTestTasks;

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

  void onInputChange({
    required int taskIndex,
    required int questionIndex,
    required Input input,
  }) {
    setState(() => 
      tasks = tasks.replaceBy(taskIndex, (task) =>
        task.copyBy(inputs: (inputs) => 
          inputs.replace(questionIndex, input)
        )
      )
    );
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
                tasks: tasks,
                selectedTaskIndex: selectedTaskIndex,
                onTaskSelected: (index) => 
                  setState(() => selectedTaskIndex = index),
              )
            ),
            SizedBox(
              width: _mainBodyWidth(constraints),
              height: double.infinity,
              child: QuestionColumn(
                taskIndex: selectedTaskIndex,
                questions: tasks[selectedTaskIndex].questions,
                inputs: tasks[selectedTaskIndex].inputs,
                onInputChange: onInputChange,
              ),
            ),
          ],
        );
      }
    );
  }
}

final _initialTestTasks = <Task>[
  (
    title: "Task 1",
    timeAllowed: const Duration(minutes: 60),
    questions: <Question>[
      const TextQuestion(
        title: "What is design thinking?",
      ),
      const TextQuestion(
        title: "What is design thinking?",
      ),
      const TextQuestion(
        title: "What is design thinking?",
      ),
      const TextQuestion(
        title: "What is design thinking?",
      ),
      const TextQuestion(
        title: "What is design thinking?",
      ),
      const TextQuestion(
        title: "What is design thinking?",
      ),
      const TextQuestion(
        title: "What is design thinking?",
      ),
    ].lock,
    inputs: [
      const TextInput("My answer"),
      const TextInput("My answer"),
      const TextInput("My answer"),
      const TextInput("My answer"),
      const TextInput("My answer"),
      const TextInput("My answer"),
      const TextInput("My answer"),
    ].lock
  ),
  (
    title: "Task 2",
    timeAllowed: const Duration(seconds: 60),
    questions: <Question>[
      McQuestion(
        title: "Which one is an example of design thinking?",
        options: <String>[
          "inventing a new chair",
          "inventing a new chair based on the design of an old chair",
          "inventing a new chair based on the design of an old chair, at the same time aiming to solve elderly people's sitting problem",
        ].lock,
      ),
      McQuestion(
        title: "Which one is an example of design thinking?",
        options: <String>[
          "inventing a new chair",
          "inventing a new chair based on the design of an old chair",
          "inventing a new chair based on the design of an old chair, at the same time aiming to solve elderly people's sitting problem",
        ].lock,
      ),
      McQuestion(
        title: "Which one is an example of design thinking?",
        options: <String>[
          "inventing a new chair",
          "inventing a new chair based on the design of an old chair",
          "inventing a new chair based on the design of an old chair, at the same time aiming to solve elderly people's sitting problem",
        ].lock,
      ),
      McQuestion(
        title: "Which one is an example of design thinking?",
        options: <String>[
          "inventing a new chair",
          "inventing a new chair based on the design of an old chair",
          "inventing a new chair based on the design of an old chair, at the same time aiming to solve elderly people's sitting problem",
        ].lock,
      ),
      McQuestion(
        title: "Which one is an example of design thinking?",
        options: <String>[
          "inventing a new chair",
          "inventing a new chair based on the design of an old chair",
          "inventing a new chair based on the design of an old chair, at the same time aiming to solve elderly people's sitting problem",
        ].lock,
      ),
    ].lock,
    inputs: [
      const McInput(null),
      const McInput(null),
      const McInput(null),
      const McInput(null),
      const McInput(null),
    ].lock
  ),
].lock;
