import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:teaching_platform/common/models/task/input.dart';
import 'package:teaching_platform/common/models/task/question.dart';
import 'package:teaching_platform/tasks/widgets/question_column/question_column.dart';
import 'package:teaching_platform/tasks/widgets/timer/timer.dart';

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> with SingleTickerProviderStateMixin {
  late final Ticker ticker;

  final Duration timeAllowed = const Duration(minutes: 60);
  late Duration timeRemaining;

  @override
  void initState() {
    final ticker = createTicker(onTick);
    ticker.start();
    this.ticker = ticker;

    timeRemaining = timeAllowed;

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
    return Center(child: Timer(timeRemaining));
    return Center(
      child: QuestionColumn(
        questions: [
          const TextQuestion(
            title: "title",
            input: TextInput("answer"),
          ),
          McQuestion(
            title: "title",
            options: [
              "option 1",
              "option 2",
              "option 3",
            ].lock,
            input: const McInput(1),
          ),
        ].lock,
        onInputChange: (_, __) => {},
      ),
    );
  }
}