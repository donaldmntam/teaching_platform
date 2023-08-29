import 'package:teaching_platform/common/monads/optional.dart';

import 'state.dart';
import '../video_bar/state.dart' as video_bar;

double sliderValue(State state) {
  return switch (state) {
    Loading() => 0,
    Playing() => state
      .animationData
      .map((it) => it.currentPosition)
      .fold(() => state.startPosition)
      .inMilliseconds / state.duration.inMilliseconds,
    Paused() => state.position.inMilliseconds /
      state.duration.inMilliseconds,
  };
}

video_bar.State videoBarState(State state) {
  return switch (state) {
    Loading() => video_bar.State.loading,
    Playing() => video_bar.State.playing,
    Paused() => state.atBreakpoint
      ? video_bar.State.atBreakpoint
      : video_bar.State.paused,
  };
}
