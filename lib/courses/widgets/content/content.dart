import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide TextButton, State, Title;
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart' as widgets show State;
import 'package:teaching_platform/common/functions/error_functions.dart';
import 'package:teaching_platform/common/models/course/course_inputs.dart';
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
  final void Function(int lessonIndex) didSelectLesson;

  const Content({
    super.key,
    required this.lessonIndex,
    required this.course,
    required this.initialInputs,
    required this.didSelectLesson,
  });

  @override
  widgets.State<Content> createState() => _ContentState();
}

class _ContentState
  extends widgets.State<Content>
  with SingleTickerProviderStateMixin
{
  late final Ticker ticker;

  late VideoPlayerController playerController;
  State state = const Loading();

  late CourseInputs inputs;
  late int? questionIndex;

  @override
  void initState() {
    ticker = createTicker(onTick);
    ticker.start();

    final playerController = VideoPlayerController.network(
      widget.course.lessons[widget.lessonIndex].videoUrl
    );
    playerController.initialize().then((_) {
      state = Paused(
        duration: playerController.value.duration,
        position: playerController.value.position,
        atBreakpoint: false,
      );
    });
    this.playerController = playerController;

    inputs = widget.initialInputs;
    questionIndex = widget.course.lessons[widget.lessonIndex].questions.isEmpty
      ? null
      : 0;

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
    changeVideoUrl(widget.course.lessons[newLessonIndex].videoUrl);
    
    super.didUpdateWidget(oldWidget);
  }

  void toggleVideoPlayer() {
    final state = this.state;
    switch (state) {
      case Loading():
        illegalState(state, "toggleVideoPlayer");
      case Paused():
        if (state.atBreakpoint) illegalState(state, "toggleVideoPlayer");
        this.state = Playing(
          duration: state.duration,
          startPosition: state.position,
        );
        setState(() {});
        playerController.seekTo(state.position);
        playerController.play();
      case Playing():
        final position = state
          .animationData
          .map((it) => it.currentPosition)
          .fold(() => state.startPosition);
        this.state = Paused(
          duration: state.duration,
          position: position,
          atBreakpoint: false,
        );
        setState(() {});
        playerController.seekTo(position);
        playerController.pause();
    }
  }

  void slide(double value) {
    final state = this.state;
    switch (state) {
      case Loading():
        illegalState(state, "slide");
      case Paused():
        if (state.atBreakpoint) illegalState(state, "slide");
        final newPosition = Duration(
          milliseconds: (state.duration.inMilliseconds * value).toInt()
        );
        this.state = Paused(
          duration: state.duration,
          position: newPosition,
          atBreakpoint: false,
        );
        setState(() {});
        playerController.seekTo(newPosition);
      case Playing():
        final newPosition = Duration(
          milliseconds: (state.duration.inMilliseconds * value).toInt()
        );
        this.state = Paused(
          duration: state.duration,
          position: newPosition,
          atBreakpoint: false,
        );
        setState(() {});
        playerController.seekTo(newPosition);
    }
  }

  void continueFromBreakpoint() {

  }

  void onTick(Duration duration) {
    final state = this.state;
    switch (state) {
      case Loading():
      case Paused():      
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
        if (newAnimationData.currentPosition >= state.duration) {
          this.state = Paused(
            duration: state.duration,
            position: state.duration,
            atBreakpoint: false,
          );
        } else {
          this.state = state.copy(
            animationData: Some(newAnimationData),
          );
        }
        setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = this.state;
    final questionIndex = this.questionIndex;    
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
                  onTap: toggleVideoPlayer,
                  child: Container(
                    color: Colors.black,
                    child: IgnorePointer(child: VideoPlayer(playerController)),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: VideoBar(
                  value: sliderValue(state),
                  state: videoBarState(state),
                  onSlide: slide,
                  onToggle: toggleVideoPlayer,
                ),
              ),
            ]
          ),
        ),
        if (questionIndex != null) QuestionPanel(
          lessonIndex: widget.lessonIndex,
          questionIndex: questionIndex,
          question: 
            widget.course.lessons[widget.lessonIndex].questions[questionIndex],
          input: inputs.input(
            lessonIndex: widget.lessonIndex,
            questionIndex: questionIndex,
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

  void changeVideoUrl(String url) {
    this.playerController.dispose();
    final playerController = VideoPlayerController.network(url);
    playerController.initialize().then((_) {
      state = Paused(
        duration: playerController.value.duration,
        position: Duration.zero,
        atBreakpoint: false,
      );
      setState(() {});
    });
    this.playerController = playerController;

    state = const Loading();
    setState(() {});
  }
}
