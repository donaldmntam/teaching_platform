import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide State;
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart' as widgets show State;
import 'package:teaching_platform/common/functions/block_functions.dart';
import 'package:teaching_platform/common/functions/error_functions.dart';
import 'package:teaching_platform/common/functions/math_functions.dart';
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
  final IList<Duration> breakpoints;
  final VideoBarController controller;
  final void Function() onToggle;
  final void Function() onBreakpointReached;
  final void Function(Duration) onChange;

  const VideoBar({
    super.key,
    required this.breakpoints,
    required this.controller,
    required this.onToggle,
    required this.onBreakpointReached,
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
      case AtBreakpoint():
      case Paused():
      case Uninitialized():
        break;
      case Playing():
        final now = clock.now();
        final newPosition = 
          now.difference(state.lastTick) + state.data.position;
        final nextBreakpointIndex = state.nextBreakpointIndex;
        if (
          nextBreakpointIndex != null &&
          newPosition > widget.breakpoints[nextBreakpointIndex]
        ) {
          this.state = AtBreakpoint(
            currentBreakpointIndex: nextBreakpointIndex,
            data: (
              duration: state.data.duration,
              position: widget.breakpoints[nextBreakpointIndex],
            ),
          );
          setState(() {});
          ticker.stop();
          widget.onBreakpointReached();
        } else if (newPosition > state.data.duration) {
          this.state = Paused(
            nextBreakpointIndex: null,
            data: (
              duration: state.data.duration,
              position: state.data.duration,
            )
          );
          setState(() {});
          ticker.stop();
        } else {
          this.state = Playing(
            nextBreakpointIndex: state.nextBreakpointIndex,
            lastTick: now,
            data: (
              duration: state.data.duration,
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
      case AtBreakpoint():
        final supposedNextBreakpointIndex = state.currentBreakpointIndex + 1;
        final int? nextBreakpointIndex;
        if (supposedNextBreakpointIndex > widget.breakpoints.length - 1) {
          nextBreakpointIndex = null;
        } else {
          nextBreakpointIndex = supposedNextBreakpointIndex;
        }
        this.state = Playing(
          nextBreakpointIndex: nextBreakpointIndex,
          lastTick: now,
          data: state.data,
        );
        ticker.start();
        setState(() {});
      case Paused():
        this.state = Playing(
          nextBreakpointIndex: state.nextBreakpointIndex,
          lastTick: now,
          data: state.data,
        );
        ticker.start();
        setState(() {});
      case Uninitialized():
      case Playing():
        illegalState(state, "shouldPlay");
    }
  }

  @override
  void shouldPause() {
    final now = Services.of(context).clock.now();
    final state = this.state;
    switch (state) {
      case Playing():
        this.state = Paused(
          nextBreakpointIndex: state.nextBreakpointIndex,
          data: (
            duration: state.data.duration,
            position: state.data.position + now.difference(state.lastTick)
          )
        );
        ticker.stop();
        setState(() {});
      case AtBreakpoint():
      case Uninitialized():
      case Paused():
        illegalState(state, "shouldPause");
    }
  }

  @override
  void shouldSeek(Duration position) {
    final state = this.state;
    switch (state) {
      case Playing(
        nextBreakpointIndex: final nextBreakpointIndex,
        data: final data
      ):
      case Paused(
        nextBreakpointIndex: final nextBreakpointIndex,
        data: final data
      ):
        final actualPosition = switch (nextBreakpointIndex) {
          null => position,
          _ => position.coerceAtLeast(widget.breakpoints[nextBreakpointIndex])
        };
        this.state = Paused(
          nextBreakpointIndex: nextBreakpointIndex,
          data: (
            duration: data.duration,
            position: actualPosition,
          )
        );
      case AtBreakpoint():
      case Uninitialized():
        illegalState(state, "shouldSeek");
    }
  }

  void onChanged(double value) {
    final state = this.state;
    switch (state) {
      case Playing():
        final newPosition = Duration(milliseconds: value.toInt());
        final nextBreakpointIndex = state.nextBreakpointIndex;
        final actualPosition = switch (nextBreakpointIndex) {
          null => newPosition,
          _ => newPosition
            .coerceAtLeast(widget.breakpoints[nextBreakpointIndex])
        };
        this.state = Paused(
          nextBreakpointIndex: nextBreakpointIndex,
          data: (
            duration: state.data.duration,
            position: actualPosition,
          )
        );
        ticker.stop();
        setState(() {});
        widget.onChange(
          Duration(milliseconds: value.toInt())
        );
      case Paused():
        final newPosition = Duration(milliseconds: value.toInt());
        final nextBreakpointIndex = state.nextBreakpointIndex;
        final actualPosition = switch (nextBreakpointIndex) {
          null => newPosition,
          _ => newPosition
            .coerceAtLeast(widget.breakpoints[nextBreakpointIndex])
        };
        this.state = Paused(
          nextBreakpointIndex: nextBreakpointIndex,
          data: (
            duration: actualPosition,
            position: Duration(milliseconds: value.toInt()),
          )
        );
        ticker.stop();
        setState(() {});
        widget.onChange(
          Duration(milliseconds: value.toInt())
        );
      case AtBreakpoint():
      case Uninitialized():
        illegalState(state, "onChange");
    }
  }

  @override
  void shouldInitialize(Data data) {
    final nextBreakpointIndex = switch (widget.breakpoints.length) {
      0 => null,
      _ => 0,
    };
    state = Paused(
      nextBreakpointIndex: nextBreakpointIndex,
      data: data
    );
    setState(() {});
  }

  // TODO: make bar untouchable when at breakpoint or uninitialized
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
            onTap: switch (state) {
              Uninitialized() => null,
              AtBreakpoint() => null,
              _ => widget.onToggle
            },
            child: Icon(
              size: _playButtonSize,
              switch (state) {
                Uninitialized() => Icons.play_arrow,
                Paused() => Icons.play_arrow,
                Playing() => Icons.pause,
                AtBreakpoint() => Icons.pause,
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
                      AtBreakpoint(data: final data) =>
                        data.duration.inMilliseconds.toDouble(),
                    },
                    value: switch (state) {
                      Uninitialized() => 0,
                      Paused(data: final data) =>
                        data.position.inMilliseconds.toDouble(),
                      Playing(data: final data) =>
                        data.position.inMilliseconds.toDouble(),
                      AtBreakpoint(data: final data) =>
                        data.position.inMilliseconds.toDouble(),
                    },
                    onChanged: switch (state) {
                      Uninitialized() => null,
                      AtBreakpoint() => null,
                      _ => onChanged
                    },
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
  final int? nextBreakpointIndex;
  final Data data;

  const Paused({
    required this.nextBreakpointIndex,
    required this.data,
  });
}

final class Playing implements State {
  final int? nextBreakpointIndex;
  final DateTime lastTick;
  final Data data;

  const Playing({
    required this.nextBreakpointIndex,
    required this.lastTick,
    required this.data,
  });
}

final class AtBreakpoint implements State {
  final int currentBreakpointIndex;
  final Data data;

  const AtBreakpoint({
    required this.currentBreakpointIndex,
    required this.data,
  });
}
