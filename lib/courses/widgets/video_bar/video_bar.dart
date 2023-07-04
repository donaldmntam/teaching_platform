import 'package:flutter/material.dart' hide State;
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart' as widgets show State;
import 'package:teaching_platform/common/functions/error_functions.dart';
import 'package:teaching_platform/common/widgets/services.dart/services.dart';
import 'package:teaching_platform/courses/widgets/video_bar/controller.dart';

typedef Data = ({
  Duration duration,
  Duration position,
});

class VideoBar extends StatefulWidget {
  final Data? data;
  final VideoBarController controller;
  final void Function() onToggle;
  final void Function(Duration) onChange;

  const VideoBar({
    super.key,
    required this.data,
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
  late final Ticker ticker;

  late State state;

  @override
  void initState() {
    widget.controller.listener = this;
    state = widget.controller.initialState;

    ticker = createTicker(onTick);
    switch (state) {
      case Paused():
      case Uninitialized():
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
    switch (widget.controller.initialState) {
      case Paused():
      case Uninitialized():
        ticker.stop();
      case Playing():
        ticker.start();
    }

    super.didUpdateWidget(oldWidget);
  }

  void onTick(Duration duration) {
    final clock = Services.of(context).clock;
    final state = this.state;
    switch (state) {
      case Paused():
      case Uninitialized():
        break;
      case Playing(lastTick: final lastTick, data: final data):
        final now = clock.now();
        this.state = Playing(
          lastTick: now,
          data: (
            duration: data.duration,
            position: now.difference(lastTick)
          ),
        );
        setState(() {});
    }
  }

  // TODO: initialize from widget or controller??? (probably from controller)

  @override
  void shouldPlay() {
    final now = Services.of(context).clock.now();
    final state = this.state;
    switch (state) {
      case Paused(data: final data):
        this.state = Playing(lastTick: now, data: data);
        ticker.start();
        setState(() {});
      case Uninitialized():
      case Playing():
        badTransition(state, "play");
    }
  }

  @override
  void shouldPause() {
    final now = Services.of(context).clock.now();
    final state = this.state;
    switch (state) {
      case Playing(lastTick: final lastTick, data: final data):
        this.state = Paused(
          data: (
            duration: data.duration,
            position: data.position + now.difference(lastTick)
          )
        );
        ticker.stop();
        setState(() {});
      case Uninitialized():
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
            max: switch (state) {
              Uninitialized() => 0,
              Paused(data: final data) => 
                data.duration.inMilliseconds.toDouble(),
              Playing(data: final data) =>
                data.duration.inMilliseconds.toDouble(),
            },
            value: switch (state) {
              Uninitialized() => 0,
              Paused(data: final data) =>
                data.position.inMilliseconds.toDouble(),
              Playing(data: final data) =>
                data.position.inMilliseconds.toDouble(),
            },
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

final class Uninitialized implements State {
  const Uninitialized();
}

final class Paused implements State {
  final Data data;

  const Paused({required this.data});
}

final class Playing implements State {
  final DateTime lastTick;
  final Data data;

  const Playing({required this.lastTick, required this.data});
}