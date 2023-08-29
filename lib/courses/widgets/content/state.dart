import 'package:teaching_platform/common/monads/optional.dart';

sealed class State {}

final class Loading implements State {
  const Loading();
}

final class Paused implements State {
  final Duration duration;
  final Duration position;
  final bool atBreakpoint;

  const Paused({
    required this.duration,
    required this.position,
    required this.atBreakpoint,
  });
}

typedef PlayingAnimationData = ({
  Duration startTime,
  Duration currentPosition,
});
final class Playing implements State {
  final Duration duration;
  final Duration startPosition;
  final Optional<PlayingAnimationData> animationData;

  const Playing({
    required this.duration,
    required this.startPosition,
    this.animationData = const None(),
  });

  Playing copy({
    Duration? duration,
    Duration? startPosition,
    Optional<PlayingAnimationData>? animationData,
  }) => Playing(
    duration: duration ?? this.duration,
    startPosition: startPosition ?? this.startPosition,
    animationData: animationData ?? this.animationData,
  );
}
