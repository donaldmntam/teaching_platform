import 'package:flutter/material.dart' hide State;
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart' as widgets show State;
import 'package:teaching_platform/common/widgets/services.dart/services.dart';

class VideoBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final State state;
  final void Function() onToggle;
  final void Function(Duration) onChange;

  const VideoBar({
    super.key,
    required this.duration,
    required this.position,
    required this.state,
    required this.onToggle,
    required this.onChange,
  });

  @override
  widgets.State<VideoBar> createState() => _VideoBarState();
}

class _VideoBarState extends widgets.State<VideoBar> 
  with SingleTickerProviderStateMixin {
  late Duration currentPosition;
  late final Ticker ticker;

  @override
  void initState() {
    currentPosition = widget.position;

    ticker = createTicker(onTick);
    switch (widget.state) {
      case Paused():
        break;
      case Playing():
        ticker.start(); 
    }

    super.initState();
  }

  @override
  void dispose() {
    ticker.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(VideoBar oldWidget) {
    currentPosition = widget.position;

    switch (widget.state) {
      case Paused():
        ticker.stop();
      case Playing():
        ticker.start(); 
    }

    super.didUpdateWidget(oldWidget);
  }

  void onTick(Duration duration) {
    print("tick!");
    final clock = Services.of(context).clock;
    final state = widget.state;
    switch (state) {
      case Paused():
        break;
      case Playing(reference: final reference):
        setState(() {
          currentPosition = widget.position + clock.now().difference(reference);
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          child: Text("toggle"),
          onPressed: widget.onToggle,
        ),
        Material(
          child: Slider(
            min: 0,
            max: widget.duration.inMilliseconds.toDouble(),
            value: currentPosition.inMilliseconds.toDouble(),
            onChanged: (value) => widget.onChange(
              Duration(milliseconds: value.toInt())
            ),
          ),
        ),
      ],
    );
  }
}

sealed class State {}

final class Paused implements State {
  const Paused();
}

final class Playing implements State {
  final DateTime reference;

  const Playing({required this.reference});
}