import 'package:flutter/material.dart' hide State;
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart' as widgets show State;
import 'package:teaching_platform/common/functions/error_functions.dart';
import 'package:teaching_platform/common/widgets/services.dart/services.dart';
import 'package:teaching_platform/courses/widgets/video_bar/controller.dart';

class VideoBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final VideoBarController controller;
  final void Function() onToggle;
  final void Function(Duration) onChange;

  const VideoBar({
    super.key,
    required this.duration,
    required this.position,
    required this.controller,
    required this.onToggle,
    required this.onChange,
  });

  @override
  widgets.State<VideoBar> createState() => _VideoBarState();
}

class _VideoBarState extends widgets.State<VideoBar> 
  with SingleTickerProviderStateMixin
  implements VideoBarControllerListener {
  late Duration currentPosition;
  late final Ticker ticker;

  late State state;

  @override
  void initState() {
    widget.controller.listener = this;
    state = widget.controller.initialState;

    currentPosition = widget.position;

    ticker = createTicker(onTick);
    switch (state) {
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

  // @override
  // void didUpdateWidget(VideoBar oldWidget) {
  //   currentPosition = widget.position;

  //   switch (widget.controller.initialState) {
  //     case Paused():
  //       ticker.stop();
  //     case Playing():
  //       ticker.start(); 
  //   }

  //   super.didUpdateWidget(oldWidget);
  // }

  void onTick(Duration duration) {
    final clock = Services.of(context).clock;
    final state = this.state;
    switch (state) {
      case Paused():
        break;
      case Playing(reference: final reference):
        currentPosition = widget.position + clock.now().difference(reference);
        setState(() {});
    }
  }

  @override
  void shouldPlay() {
    final now = Services.of(context).clock.now();
    final state = this.state;
    switch (state) {
      case Paused():
        this.state = Playing(reference: now);
        ticker.start();
        setState(() {});
      case Playing():
        badTransition(state, "play");
    }
  }

  @override
  void shouldPause() {
    final now = Services.of(context).clock.now();
    final state = this.state;
    switch (state) {
      case Playing(reference: final reference):
        currentPosition = currentPosition + now.difference(reference);
        this.state = const Paused();
        ticker.stop();
        setState(() {});
      case Paused():
        badTransition(state, "pause");
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