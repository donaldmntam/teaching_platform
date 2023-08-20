import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:teaching_platform/common/functions/duration_functions.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/util_classes/channel.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/tasks/widgets/timer/event.dart';

class Timer extends StatefulWidget {
  final int taskIndex;
  final Duration timeAllowed;
  final Channel<TimerControllerEvent> channel;
  final void Function(int taskIndex) onFinish;

  const Timer({
    super.key,
    required this.taskIndex,
    required this.timeAllowed,
    required this.channel,
    required this.onFinish,
  });

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> with SingleTickerProviderStateMixin {
  late Duration timeRemaining;

  late Ticker ticker;

  @override
  void initState() {
    timeRemaining = widget.timeAllowed;

    final ticker = createTicker(onTick);
    this.ticker = ticker;

    widget.channel.listen(
      (event) {
        switch(event) {
          case Start():
            ticker.start();
        }
      }
    );

    super.initState();
  }

  @override
  void dispose() {
    ticker.dispose();
    widget.channel.stopListening();
    super.dispose();
  }

  void onTick(Duration duration) {
    final timeRemaining = (widget.timeAllowed - duration).roundedToSeconds();
    if (timeRemaining == this.timeRemaining) return;
    if (timeRemaining <= Duration.zero) {
      widget.onFinish(widget.taskIndex);
    } else {
      setState(() => this.timeRemaining = timeRemaining);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;

    return FittedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Time Remaining: ",
            style: theme.textStyle(
              size: 22,
              color: theme.colors.primary,
              weight: FontWeight.normal,
            )
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            decoration: ShapeDecoration(
              color: theme.colors.primary.withAlpha(80),
              shape: const StadiumBorder(),
            ),
            child: Text(
              timeRemaining.toTimeString(),
              style: theme.textStyle(
                size: 22,
                color: theme.colors.primary,
                weight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}