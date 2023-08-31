import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide TextButton, State, Title;
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart' as widgets show State;
import 'package:teaching_platform/common/functions/block_functions.dart';
import 'package:teaching_platform/common/functions/duration_functions.dart';
import 'package:teaching_platform/common/functions/error_functions.dart';
import 'package:teaching_platform/common/models/course/course_inputs.dart';
import 'package:teaching_platform/common/models/course/lesson.dart';
import 'package:teaching_platform/common/models/course/question.dart';
import 'package:teaching_platform/common/monads/optional.dart';
import 'package:teaching_platform/common/models/course/course.dart';
import 'package:teaching_platform/courses/widgets/content/functions.dart';
import 'package:teaching_platform/courses/widgets/question_panel/question_panel.dart';
import 'package:video_player/video_player.dart';

import '../video_bar/video_bar.dart';
import 'state.dart';
import 'title.dart';
import 'lesson_selection.dart';

const _verticalSpacing = 16.0;

// TODO: video player flickering

class Content extends StatefulWidget {
  final int lessonIndex;
  final Course course;
  final CourseInputs initialInputs;
  final CourseInputs correctInputs;
  final void Function(int lessonIndex) didSelectLesson;

  Lesson get lesson => course.lessons[lessonIndex];

  const Content({
    super.key,
    required this.lessonIndex,
    required this.course,
    required this.initialInputs,
    required this.correctInputs,
    required this.didSelectLesson,
  });

  @override
  widgets.State<Content> createState() => _ContentState();

  Optional<int> nextQuestionIndex(int currentIndex) {
    if (currentIndex > lesson.questions.length - 1) {
      return const None();
    }
    return Some(currentIndex + 1);
  }
}

class _ContentState
  extends widgets.State<Content>
  with SingleTickerProviderStateMixin
{
  late final Ticker ticker;

  late VideoPlayerController playerController;
  State state = const Loading();

  late CourseInputs inputs;

  @override
  void initState() {
    ticker = createTicker(onTick);
    ticker.start();

    final playerController = VideoPlayerController.network(
      widget.course.lessons[widget.lessonIndex].videoUrl
    );
    playerController.initialize().then((_) {
      final Optional<int> nextQuestionIndex;
      if (widget.lesson.questions.isEmpty) {
        nextQuestionIndex = const None();
      } else {
        nextQuestionIndex = const Some(1);
      }
      state = Paused(
        duration: playerController.value.duration,
        position: playerController.value.position,
        nextQuestionIndex: nextQuestionIndex,
      );
    });
    this.playerController = playerController;

    inputs = widget.initialInputs;

    super.initState();
  }

  @override
  void dispose() {
    ticker.dispose();
    playerController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(Content oldWidget) {
    const newLessonIndex = 0;
    changeVideoUrl(
      widget.course.lessons[newLessonIndex].videoUrl,
      widget.lesson.questions,
    );
    
    super.didUpdateWidget(oldWidget);
  }

  void toggleVideoPlayer() {
    final state = this.state;
    switch (state) {
      case Loading():
      case AtBreakpoint():
        illegalState(state, "toggleVideoPlayer");
      case Paused():
        final newPosition = state.position >= state.duration
          ? Duration.zero
          : state.position;
        this.state = Playing(
          duration: state.duration,
          startPosition: newPosition,
          nextQuestionIndex: state.nextQuestionIndex,
        );
        setState(() {});
        playerController.seekTo(newPosition);
        playerController.play();
      case Playing():
        final position = state
          .animationData
          .map((it) => it.currentPosition)
          .fold(() => state.startPosition);
        this.state = Paused(
          duration: state.duration,
          position: position,
          nextQuestionIndex: state.nextQuestionIndex,
        );
        setState(() {});
        playerController.seekTo(position);
        playerController.pause();
    }
  }

  void slide(Duration newPosition) {
    final state = this.state;
    switch (state) {
      case Loading():
      case AtBreakpoint():
        illegalState(state, "slide");
      case Playing(
        duration: final duration,
        nextQuestionIndex: final nextQuestionIndex,
      ):
      case Paused(
        duration: final duration,
        nextQuestionIndex: final nextQuestionIndex,
      ):
        final nextBreakpoint = nextQuestionIndex
          .map((it) => widget.lesson.questions[it].timeStamp);
        this.state = Paused(
          duration: duration,
          position: switch (nextBreakpoint) {
            Some() => newPosition.coerceAtMost(nextBreakpoint.value),
            None() => newPosition,
          },
          nextQuestionIndex: nextQuestionIndex,
        );
        setState(() {});
        playerController.seekTo(newPosition);
        playerController.pause();
    }
  }

  void submitAnswerAtBreakpoint() {
    final state = this.state;
    if (state is! AtBreakpoint) {
      illegalState(state, "submitAnswerAtBreakpoint");
    }
    final inputState = state.inputState;
    if (inputState is! AwaitingSubmission) {
      illegalState(state, "submitAnswerAtBreakpoint");
    }
    final correct = inputs[state.questionIndex] == 
      widget.correctInputs[state.questionIndex];
    this.state = state.copy(
      inputState: ShowingResult(
        retryCount: inputState.retryCount,
        passed: correct,
      )
    );
    setState(() {});
  }

  void continueFromBreakpoint() {
    final state = this.state;
    if (state is! AtBreakpoint) {
      illegalState(state, "continueFromBreakpoint");
    }
    final inputState = state.inputState;
    if (inputState is! ShowingResult) {
      illegalState(state, "continueFromBreakpoint");
    }
    if (inputState.passed) {
      final nextQuestionIndex = widget.nextQuestionIndex(state.questionIndex);
      this.state = Playing(
        duration: state.duration,
        startPosition: state.position,
        nextQuestionIndex: nextQuestionIndex,
      );
      playerController.seekTo(state.position);
      playerController.play();
    } else {
      if (inputState.maxRetryCountReached) {
        final newPosition = widget
          .lesson
          .questions[state.questionIndex]
          .timeStamp;
        this.state = Playing(
          duration: state.duration,
          startPosition: newPosition,
          nextQuestionIndex: widget.nextQuestionIndex(state.questionIndex),
        );
        setState(() {});
        playerController.seekTo(newPosition);
        playerController.play();
      } else {
        final newPosition = widget
          .lesson
          .questions[state.questionIndex - 1]
          .timeStamp;
        this.state = Playing(
          duration: state.duration,
          startPosition: newPosition,
          nextQuestionIndex: Some(state.questionIndex),
          mode: Rewatching(retryCount: inputState.retryCount),
        );
        playerController.seekTo(newPosition);
        playerController.play();
      }
    }
  }

  void onTick(Duration duration) {
    final state = this.state;
    switch (state) {
      case Loading():
      case Paused():
      case AtBreakpoint():
        break;
      case Playing():
        final oldAnimationData = state.animationData;
        final PlayingAnimationData newAnimationData = 
          switch (oldAnimationData) {
            Some() => (
              startTime: oldAnimationData.value.startTime,
              currentPosition: (duration - oldAnimationData.value.startTime) + 
                state.startPosition,
            ),
            None() => (
              startTime: duration,
              currentPosition: state.startPosition,
            )
          };

        final questionIndex = state.nextQuestionIndex;
        if (questionIndex is Some<int>) {
          final nextQuestion = widget.lesson.questions[questionIndex.value];
          if (newAnimationData.currentPosition > nextQuestion.timeStamp) {
            this.state = AtBreakpoint(
              duration: state.duration,
              position: nextQuestion.timeStamp,
              questionIndex: questionIndex.value,
            );
            setState(() {});
            playerController.seekTo(newAnimationData.currentPosition);
            playerController.pause();
            break;
          }
        }

        final endReached = newAnimationData.currentPosition >= state.duration;
        if (endReached) {
          this.state = Paused(
            duration: state.duration,
            position: state.duration,
            nextQuestionIndex: const None(),
          );
          setState(() {});
          break;
        } 

        this.state = state.copy(
          animationData: Some(newAnimationData),
        );
        setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = this.state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Title(widget.course.title),
        LessonSelection(
          widget.course.lessons,
          selectedIndex: widget.lessonIndex,
          onSelect: widget.didSelectLesson,
        ),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6))
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: GestureDetector(
                  onTap: switch (state) {
                    AtBreakpoint() => null,
                    _ => toggleVideoPlayer,
                  },
                  child: Container(
                    color: Colors.black,
                    child: IgnorePointer(child: VideoPlayer(playerController)),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: VideoBar(
                  value: videoBarValue(state),
                  state: videoBarState(state),
                  onSlide: slide,
                  onToggle: toggleVideoPlayer,
                ),
              ),
            ]
          ),
        ),
        if (state is AtBreakpoint) QuestionPanel(
          lessonIndex: widget.lessonIndex,
          questionIndex: state.questionIndex,
          question: widget.lesson.questions[state.questionIndex],
          input: inputs.input(
            lessonIndex: widget.lessonIndex,
            questionIndex: state.questionIndex,
          ),
          onInputChange: ({
            required lessonIndex,
            required questionIndex,
            required input,
          }) => setState(() {
            inputs = inputs.copy(
              lessonIndex: lessonIndex,
              questionIndex: questionIndex,
              input: input,
            );
          }),
          onNext: continueFromBreakpoint,
        ),
      ].addBetween(const SizedBox(height: _verticalSpacing)),
    );
  }

  void changeVideoUrl(
    String url,
    IList<Question> questions,
  ) {
    this.playerController.dispose();
    final playerController = VideoPlayerController.network(url);
    playerController.initialize().then((_) {
      final Optional<int> nextQuestionIndex;
      if (questions.isEmpty) {
        nextQuestionIndex = const None();
      } else {
        nextQuestionIndex = const Some(0);
      }
      state = Paused(
        duration: playerController.value.duration,
        position: Duration.zero,
        nextQuestionIndex: nextQuestionIndex,
      );
      setState(() {});
    });
    this.playerController = playerController;

    state = const Loading();
    setState(() {});
  }
}
