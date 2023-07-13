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
  final VideoBarController controller;
  final void Function() onToggle;
  final void Function(Duration) onChange;

  const VideoBar({
    super.key,
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

  State state = const Uninitialized();

  @override
  void initState() {
    widget.controller.listener = this;

    ticker = createTicker(onTick);

    super.initState();
  }

  @override
  void dispose() {
    ticker.dispose();

    super.dispose();
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
        final newPosition = now.difference(lastTick) + data.position;
        if (newPosition > data.duration) {
          this.state = Paused(
            data: (
              duration: data.duration,
              position: data.duration,
            )
          );
          setState(() {});
          ticker.stop();
        } else {
          this.state = Playing(
            lastTick: now,
            data: (
              duration: data.duration,
              position: newPosition
            ),
          );
          setState(() {});
        }
    }
  }

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

  void onChanged(double value) {
    final state = this.state;
    switch (state) {
      case Playing(data: final data):
        this.state = Paused(
          data: (
            duration: data.duration,
            position: Duration(milliseconds: value.toInt()),
          )
        );
        ticker.stop();
        setState(() {});
        widget.onChange(
          Duration(milliseconds: value.toInt())
        );
      case Paused(data: final data):
        this.state = Paused(
          data: (
            duration: data.duration,
            position: Duration(milliseconds: value.toInt()),
          )
        );
        ticker.stop();
        setState(() {});
        widget.onChange(
          Duration(milliseconds: value.toInt())
        );
      case Uninitialized():
        badTransition(state, "onChange");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        ElevatedButton(
          onPressed: widget.onToggle,
          child: const Text("toggle"),
        ),
        Flexible(
          flex: 1,
          child: Material(
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
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
  
  @override
  void shouldInitialize(Data data) {
    state = Paused(data: data);
    setState(() {});
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