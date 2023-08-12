import 'package:flutter/material.dart' hide State;
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart' as widgets show State;
import 'package:teaching_platform/common/functions/error_functions.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/common/widgets/tappable/tappable.dart';
import 'package:teaching_platform/courses/widgets/video_bar/controller.dart';

const _barHeight = 24.0;
const _thumbSize = (_playButtonSize / 2) * 0.5;
const _thumbOverlaySize = (_playButtonSize / 2) * 0.7;
const _playButtonSize = 36.0;

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
        badTransition(state, "shouldPlay");
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
        badTransition(state, "shouldPause");
    }
  }

  @override
  void shouldSeek(Duration position) {
    final state = this.state;
    switch (state) {
      case Playing(data: final data):
      case Paused(data: final data):
        this.state = Paused(
          data: (
            duration: data.duration,
            position: position,
          )
        );
      case Uninitialized():
        badTransition(state, "shouldSeek");
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
  void shouldInitialize(Data data) {
    state = Paused(data: data);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;

    return Container(
      color: theme.colors.background,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(width: 12),
          Tappable( 
            onTap: widget.onToggle,
            child: Icon(
              size: _playButtonSize,
              switch (state) {
                Uninitialized() => Icons.play_arrow,
                Paused() => Icons.play_arrow,
                Playing() => Icons.pause,
              },
            )
          ),
          Flexible(
            flex: 1,
            child: Material(
              color: Colors.transparent,
              child: SizedBox(
                height: _barHeight,
                child: SliderTheme(
                  data: SliderThemeData(
                    thumbColor: theme.colors.primary,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: _thumbSize,
                    ),
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: _thumbOverlaySize,
                    ),
                  ),
                  child: Slider(
                    activeColor: theme.colors.primary,
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
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
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