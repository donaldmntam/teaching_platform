import 'package:teaching_platform/common/monads/optional.dart';

sealed class State {}

final class Loading implements State {
  const Loading();
}

final class Paused implements State {
  final Duration duration;
  final Duration position;
  final Optional<int> nextQuestionIndex;

  const Paused({
    required this.duration,
    required this.position,
    required this.nextQuestionIndex,
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
  final Optional<int> nextQuestionIndex;

  const Playing({
    required this.duration,
    required this.startPosition,
    this.animationData = const None(),
    required this.nextQuestionIndex,
  });

  Playing copy({
    Duration? duration,
    Duration? startPosition,
    Optional<PlayingAnimationData>? animationData,
    Optional<int>? nextQuestionIndex,
  }) => Playing(
    duration: duration ?? this.duration,
    startPosition: startPosition ?? this.startPosition,
    animationData: animationData ?? this.animationData,
    nextQuestionIndex: nextQuestionIndex ?? this.nextQuestionIndex,
  );
}

final class AtBreakpoint implements State {
  final Duration duration;
  final Duration position;
  final int questionIndex;

  const AtBreakpoint({
    required this.duration,
    required this.position,
    required this.questionIndex,
  });
}
