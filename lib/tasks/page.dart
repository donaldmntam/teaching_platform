import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';
import 'package:teaching_platform/common/functions/error_functions.dart';
import 'package:teaching_platform/common/functions/iterable_functions.dart';
import 'package:teaching_platform/common/models/task/input.dart';
import 'package:teaching_platform/common/models/task/question.dart';
import 'package:teaching_platform/common/models/task/task.dart';
import 'package:teaching_platform/common/util_classes/channel.dart';
import 'package:teaching_platform/tasks/widgets/task_column/task_column.dart';
import 'package:teaching_platform/tasks/widgets/timer/event.dart';
import 'models/task_state.dart' as task_state;
import 'package:teaching_platform/common/models/task/functions.dart';

import 'widgets/awaiting_start_content/awaiting_start_content.dart';
import 'widgets/finished_content/finished_content.dart';
import 'widgets/ready_content/ready_content.dart';

double _mainBodyWidth(BoxConstraints constraints) => 
  constraints.maxWidth * 0.7;
double _taskColumnWidth(BoxConstraints constraints) =>
  constraints.maxWidth * 0.3;

class Page extends StatefulWidget {
  final IList<Task> tasks;
  
  const Page({
    super.key,
    required this.tasks,
  });

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  late IList<IList<Input>> inputs;
  late IList<task_state.State> states;
  late IList<Channel<TimerControllerEvent>> timerChannels;

  late int selectedTaskIndex;

  @override
  void initState() {
    inputs = widget.tasks.map((task) =>
      task.questions.map((question) =>
        switch (question) {
          TextQuestion() => TextInput.empty,
          McQuestion() => McInput.empty,
        }
      ).toIList(),
    ).toIList();

    states = List<task_state.State>.filled(
      widget.tasks.length, 
      const task_state.AwaitingStart(),
    ).lock;

    timerChannels = List.generate(
      widget.tasks.length,
      (_) => Channel<TimerControllerEvent>(),
    ).lock;

    selectedTaskIndex = 0;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onInputChange({
    required int taskIndex,
    required int questionIndex,
    required Input input,
  }) {
    setState(() => 
      inputs = inputs.copy(
        taskIndex: taskIndex,
        questionIndex: questionIndex,
        input: input,
      )
    );
  }

  void onTaskStart(int taskIndex) {
    final state = states[taskIndex];
    if (state is! task_state.AwaitingStart) illegalState(state, "onTaskStart");
    final task = widget.tasks[taskIndex];
    timerChannels[taskIndex].add(const Start());
    setState(() => 
      states = states.replace(
        taskIndex, 
        task_state.Ready(
          task: task, 
          inputs: inputs[taskIndex],
          initialTimeRemaining: task.timeAllowed,
        ),
      ),
    );  
  }

  void onTaskFinish(int taskIndex) {
    final state = states[taskIndex];
    if (state is! task_state.Ready) illegalState(state, "onTaskFinish");
    setState(() =>
      states = states.replace(
        taskIndex,
        const task_state.Finished(),
      ),
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
                tasks: widget.tasks,
                selectedTaskIndex: selectedTaskIndex,
                onTaskSelected: (index) => setState(() =>
                  selectedTaskIndex = index,
                ),
              )
            ),
            SizedBox(
              width: _mainBodyWidth(constraints),
              height: double.infinity,
              child: IndexedStack(
                index: selectedTaskIndex,
                children: states.mapIndexed((i, state) => switch (state) {
                  task_state.AwaitingStart() => AwaitingStartContent(
                    taskIndex: i,
                    onStart: onTaskStart,
                  ),
                  task_state.Ready() => ReadyContent(
                    taskIndex: i,
                    state: state,
                    timerChannel: timerChannels[i],
                    onInputChange: onInputChange,
                    onFinish: onTaskFinish,
                  ),
                  task_state.Finished() => const FinishedContent(),
                }).toList(),
              )
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
        description: "What is design thinking?",
      ),
      const TextQuestion(
        description: "What is design thinking?",
      ),
      const TextQuestion(
        description: "What is design thinking?",
      ),
      const TextQuestion(
        description: "What is design thinking?",
      ),
      const TextQuestion(
        description: "What is design thinking?",
      ),
      const TextQuestion(
        description: "What is design thinking?",
      ),
      const TextQuestion(
        description: "What is design thinking?",
      ),
    ].lock,
  ),
  (
    title: "Task 2",
    timeAllowed: const Duration(seconds: 62),
    questions: <Question>[
      McQuestion(
        description: "Which one is an example of design thinking?",
        options: <String>[
          "inventing a new chair",
          "inventing a new chair based on the design of an old chair",
          "inventing a new chair based on the design of an old chair, at the same time aiming to solve elderly people's sitting problem",
        ].lock,
      ),
      McQuestion(
        description: "Which one is an example of design thinking?",
        options: <String>[
          "inventing a new chair",
          "inventing a new chair based on the design of an old chair",
          "inventing a new chair based on the design of an old chair, at the same time aiming to solve elderly people's sitting problem",
        ].lock,
      ),
      McQuestion(
        description: "Which one is an example of design thinking?",
        options: <String>[
          "inventing a new chair",
          "inventing a new chair based on the design of an old chair",
          "inventing a new chair based on the design of an old chair, at the same time aiming to solve elderly people's sitting problem",
        ].lock,
      ),
      McQuestion(
        description: "Which one is an example of design thinking?",
        options: <String>[
          "inventing a new chair",
          "inventing a new chair based on the design of an old chair",
          "inventing a new chair based on the design of an old chair, at the same time aiming to solve elderly people's sitting problem",
        ].lock,
      ),
      McQuestion(
        description: "Which one is an example of design thinking?",
        options: <String>[
          "inventing a new chair",
          "inventing a new chair based on the design of an old chair",
          "inventing a new chair based on the design of an old chair, at the same time aiming to solve elderly people's sitting problem",
        ].lock,
      ),
    ].lock,
  ),
].lock;
