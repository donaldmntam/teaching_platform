import 'package:flutter/material.dart' hide State;
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart' as widgets show State;
import 'package:teaching_platform/common/functions/error_functions.dart';
import 'package:teaching_platform/common/functions/math_functions.dart';
import 'package:teaching_platform/common/monads/optional.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/common/widgets/tappable/tappable.dart';
import 'package:teaching_platform/courses/widgets/video_bar/state.dart';

const _barHeight = 24.0;
const _thumbSize = (_playButtonSize / 2) * 0.5;
const _thumbOverlaySize = (_playButtonSize / 2) * 0.7;
const _playButtonSize = 36.0;

class VideoBar extends StatefulWidget {
  final State state;
  final void Function() onToggle;
  final void Function(double) onSlide;

  const VideoBar({
    super.key,
    required this.state,
    required this.onToggle,
    required this.onSlide,
  });

  @override
  widgets.State<VideoBar> createState() => _VideoBarState();
}

class _VideoBarState extends widgets.State<VideoBar> 
  with SingleTickerProviderStateMixin {
  late State state;
  late final Ticker ticker;

  @override
  void initState() {
    state = widget.state;

    ticker = createTicker(onTick);
    ticker.start();

    super.initState();
  }

  @override
  void dispose() {
    ticker.dispose();

    super.dispose();
  }

  void onTick(Duration duration) {
    final state = this.state;
    switch (state) {
      case Loading():
      case Paused():      
        break;
      case Playing():
        final startTime = state.startTime.fold(() => duration);
        this.state = state.copy(
          startTime: Some(startTime),
          currentPosition: Some(duration - startTime),
        );
        setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    final state = this.state;
    return Container(
      color: theme.colors.background,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(width: 12),
          Tappable( 
            onTap: switch (state) {
              Paused() => state.atBreakpoint ? null : widget.onToggle,
              _ => null,
            },
            child: Icon(
              size: _playButtonSize,
              switch (state) {
                Loading() => Icons.play_arrow,
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
                    value: sliderValue(state),
                    onChanged: switch (state) {
                      Paused() => state.atBreakpoint ? null : widget.onSlide,
                      _ => widget.onSlide
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

double sliderValue(State state) {
  return switch (state) {
    Loading() => 0,
    Paused() => state.position.inMilliseconds /
      state.duration.inMilliseconds,
    Playing() => state.currentPosition.fold(() => state.startPosition)
      .inMilliseconds / state.duration.inMilliseconds,
  };
}
