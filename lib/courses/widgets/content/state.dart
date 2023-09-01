import 'package:teaching_platform/common/monads/optional.dart';
import 'package:teaching_platform/courses/values.dart';

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
sealed class PlayingMode {}
final class Regular implements PlayingMode {
  const Regular();
}
final class Rewatching implements PlayingMode {
  final int retryCount;
  
  const Rewatching({
    required this.retryCount,
  });
}
final class Playing implements State {
  final Duration duration;
  final Duration startPosition;
  final Optional<PlayingAnimationData> animationData;
  final Optional<int> nextQuestionIndex;
  final PlayingMode mode;

  const Playing({
    required this.duration,
    required this.startPosition,
    this.animationData = const None(),
    required this.nextQuestionIndex,
    this.mode = const Regular(),
  });

  Playing copy({
    Duration? duration,
    Duration? startPosition,
    Optional<PlayingAnimationData>? animationData,
    Optional<int>? nextQuestionIndex,
    PlayingMode? mode,
  }) => Playing(
    duration: duration ?? this.duration,
    startPosition: startPosition ?? this.startPosition,
    animationData: animationData ?? this.animationData,
    nextQuestionIndex: nextQuestionIndex ?? this.nextQuestionIndex,
    mode: mode ?? this.mode,
  );
}

sealed class InputState {
  final int retryCount;
  
  bool get maxRetryCountReached => retryCount >= maxRetryCount;

  const InputState({required this.retryCount});
}

final class AwaitingSubmission extends InputState {
  const AwaitingSubmission({required super.retryCount});
}

final class ShowingResult extends InputState {
  final bool passed;

  const ShowingResult({
    required super.retryCount,
    required this.passed,
  });
}

final class AtBreakpoint implements State {
  final Duration duration;
  final Duration position;
  final int questionIndex;
  final InputState inputState;

  const AtBreakpoint({
    required this.duration,
    required this.position,
    required this.questionIndex,
    required this.inputState,
  });

  AtBreakpoint copy({
    InputState? inputState
  }) => AtBreakpoint(
    duration: duration,
    position: position,
    questionIndex: questionIndex,
    inputState: inputState ?? this.inputState,
  );
}

