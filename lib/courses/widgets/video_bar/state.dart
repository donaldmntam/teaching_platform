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

final class Playing implements State {
  final Duration duration;
  final Duration startPosition;
  final Optional<Duration> startTime;
  final Optional<Duration> currentPosition;

  const Playing({
    required this.duration,
    required this.startPosition,
    this.startTime = const None(),
    this.currentPosition = const None(),
  });

  Playing copy({
    Duration? duration,
    Duration? startPosition,
    Optional<Duration>? startTime,
    Optional<Duration>? currentPosition,
  }) => Playing(
    duration: duration ?? this.duration,
    startPosition: startPosition ?? this.startPosition,
    startTime: startTime ?? this.startTime,
    currentPosition: currentPosition ?? this.currentPosition,
  );
}
