import 'package:flutter/material.dart' hide State;
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/common/widgets/tappable/tappable.dart';

import 'state.dart';

const _barHeight = 24.0;
const _thumbSize = (_playButtonSize / 2) * 0.5;
const _thumbOverlaySize = (_playButtonSize / 2) * 0.7;
const _playButtonSize = 36.0;

class VideoBar extends StatelessWidget {
  final double value;
  final State state;
  final void Function() onToggle;
  final void Function(double) onSlide;

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
            child: Icon(
              size: _playButtonSize,
              switch (state) {
                State.playing => Icons.pause,
                State.paused => Icons.play_arrow,
                State.loading => Icons.play_arrow,
                State.atBreakpoint => Icons.play_arrow,
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
                    value: value,
                    onChanged: switch (state) {
                      State.atBreakpoint => null,
                      State.loading => null,
                      State.playing => onSlide,
                      State.paused => onSlide,
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
