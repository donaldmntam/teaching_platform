import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:teaching_platform/common/models/course/question.dart';
import 'package:teaching_platform/common/monads/optional.dart';
import 'package:teaching_platform/courses/widgets/video_bar/video_bar.dart';

import 'state.dart';
import '../video_bar/state.dart' as video_bar;

VideoBarValue videoBarValue(State state) {
  return switch (state) {
    Loading() => (duration: Duration.zero, position: Duration.zero),
    Playing() => (
      duration: state.duration,
      position: state.animationData
        .map((it) => it.currentPosition)
        .fold(() => state.startPosition)
    ),
    Paused() => (
      duration: state.duration,
      position: state.position,
    ),
    AtBreakpoint() => (
      duration: state.duration,
      position: state.position,
    ),
  };
}

video_bar.State videoBarState(State state) {
  return switch (state) {
    Loading() => video_bar.State.loading,
    Playing() => video_bar.State.playing,
    Paused() => video_bar.State.paused,
    AtBreakpoint() => video_bar.State.atBreakpoint,
  };
}

// Optional<int> nextQuestionIndex(
//   IList<Question> questions,
//   Duration position,
// ) {
//   for (var i = 0; i < questions.length; i++) {
//     final question = questions[i];
//     if (position < question.timeStamp) continue;
//     return Some(i);
//   }
//   return const None();
// }
