import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:teaching_platform/common/functions/error_functions.dart';
import 'package:teaching_platform/common/models/task/input.dart';
import 'package:teaching_platform/common/models/task/question.dart';
import 'package:teaching_platform/common/models/task/task.dart';
import 'package:teaching_platform/common/widgets/line_shadow/line_shadow.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/tasks/widgets/question_column/question_column.dart';
import 'package:teaching_platform/tasks/widgets/task_column/task_column.dart';
import 'package:teaching_platform/tasks/widgets/timer/timer.dart';
import './models/state.dart' as page;

import 'widgets/awaiting_start_content/awaiting_start_content.dart';
import 'widgets/finished_content/finished_content.dart';
import 'widgets/ready_content/ready_content.dart';

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

  IList<Task> tasks = _initialTestTasks;
  late IList<page.State> states;

  late int selectedTaskIndex;

  @override
  void initState() {
    final ticker = createTicker(onTick);
    ticker.start();
    this.ticker = ticker;

    states = List<page.State>.generate(tasks.length, (_) =>
      const page.AwaitingStart(),
    ).lock;

    selectedTaskIndex = 0;

    super.initState();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  void onTick(Duration duration) {
    for (var i = 0; i < states.length; i++) {
      final state = states[i];
      if (state is! page.Ready) continue;
      setState(() {
        final newRemaining = state.timeAllowed - (
          duration - (state.startTime ?? duration)
        );
        final page.State newState;
        if (newRemaining < Duration.zero) {
          newState = const page.Finished();
        } else {
          newState = state.copyBy(
            startTime: (startTime) => startTime ?? duration,
            timeRemaining: (_) => newRemaining,
          );
        }
        states = states.replace(i, newState);
      });
    }
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

  void onTaskStart(int taskIndex) {
    final state = states[taskIndex];
    if (state is! page.AwaitingStart) illegalState(state, "onTaskStart");
    setState(() => 
      states = states.replace(
        taskIndex, 
        page.Ready(
          tasks: tasks, 
          timeAllowed: const Duration(seconds: 60),
          timeRemaining: const Duration(seconds: 60),
        ),
      ),
    );  
  }

  void onTaskFinish(int taskIndex) {
    final state = states[taskIndex];
    if (state is! page.Ready) illegalState(state, "onTaskFinish");
    setState(() =>
      states = states.replace(
        taskIndex,
        const page.Finished(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = states[selectedTaskIndex];
    return LayoutBuilder(
      builder: (_, constraints) {
        return Row(
          children: [
            SizedBox(
              width: _taskColumnWidth(constraints),
              child: TaskColumn(
                tasks: tasks,
                selectedTaskIndex: selectedTaskIndex,
                onTaskSelected: (index) => setState(() =>
                  selectedTaskIndex = index,
                ),
              )
            ),
            SizedBox(
              width: _mainBodyWidth(constraints),
              height: double.infinity,
              child: switch (state) {
                page.AwaitingStart() => AwaitingStartContent(
                  taskIndex: selectedTaskIndex,
                  onStart: onTaskStart,
                ),
                page.Ready() => ReadyContent(
                  taskIndex: selectedTaskIndex,
                  state: state,
                  onInputChange: onInputChange,
                  onFinish: onTaskFinish,
                ),
                page.Finished() => const FinishedContent(),
              },
            )
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
