import 'package:flutter/material.dart' hide State;
import 'package:teaching_platform/common/functions/block_functions.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/common/widgets/tappable/tappable.dart';

import 'state.dart';

const _barHeight = 24.0;
const _thumbSize = (_playButtonSize / 2) * 0.5;
const _thumbOverlaySize = (_playButtonSize / 2) * 0.7;
const _playButtonSize = 36.0;

typedef VideoBarValue = ({
  Duration position,
  Duration duration,
});

class VideoBar extends StatelessWidget {
  final VideoBarValue value;
  final State state;
  final void Function() onToggle;
  final void Function(Duration newPosition) onSlide;

  const VideoBar({
    super.key,
    required this.value,
    required this.state,
    required this.onToggle,
    required this.onSlide,
  });

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
              State.atBreakpoint => null,
              State.loading => null,
              State.playing => onToggle,
              State.paused => onToggle,
            },
            child: SizedBox.square(
              dimension: _playButtonSize,
              child: Center(
                child: Icon(
                  size: _playButtonSize * 0.8,
                  switch (state) {
                    State.playing => Icons.pause,
                    State.paused => value.position >= value.duration
                      ? Icons.replay
                      : Icons.play_arrow,
                    State.loading => Icons.play_arrow,
                    State.atBreakpoint => value.position >= value.duration
                      ? Icons.replay
                      : Icons.play_arrow,
                  },
                ),
              ),
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
                    value: value.duration.inMilliseconds == 0
                      ? 0
                      : value.position.inMilliseconds / 
                        value.duration.inMilliseconds,
                    onChanged: sliderOnChangedCallback(
                      state,
                      value.duration,
                      onSlide,
                    ),
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

void Function(double)? sliderOnChangedCallback(
  State state,
  Duration duration,
  void Function(Duration newPosition) onSlide,
) {
  if (
    state == State.atBreakpoint || 
    state == State.loading
  ) {
    return null;
  }
  return (double value) => onSlide(
    Duration(
      milliseconds: (duration.inMilliseconds * value).toInt()
    )
  );
}
