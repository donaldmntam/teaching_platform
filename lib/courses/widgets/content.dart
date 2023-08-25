import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide TextButton;
import 'package:teaching_platform/common/functions/block_functions.dart';
import 'package:teaching_platform/common/functions/iterable_functions.dart';
import 'package:teaching_platform/common/functions/list_functions.dart';
import 'package:teaching_platform/common/models/course/course_group.dart';
import 'package:teaching_platform/common/models/course/course_inputs.dart';
import 'package:teaching_platform/common/models/course/input.dart';
import 'package:teaching_platform/common/models/course/question.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/button/selectable_text_button.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/common/models/course/course.dart';
import 'package:teaching_platform/common/models/course/lesson.dart';
import 'package:teaching_platform/courses/widgets/question_panel/question_panel.dart';
import 'package:video_player/video_player.dart';

import 'video_bar/controller.dart';
import 'video_bar/video_bar.dart' hide State;

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
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  late VideoPlayerController playerController;
  late final VideoBarController barController;

  bool paused = true;
  late CourseInputs inputs;
  late int? questionIndex;

  @override
  void initState() {
    final playerController = VideoPlayerController.network(
      widget.course.lessons[widget.lessonIndex].videoUrl
    );
    playerController.initialize().then((_) =>
      setState(() => 
        barController.initialize((
          duration: playerController.value.duration,
          position: Duration.zero,
        ))
      )
    );
    this.playerController = playerController;

    barController = VideoBarController();

    inputs = widget.initialInputs;
    questionIndex = widget.course.lessons[widget.lessonIndex].questions.isEmpty
      ? null
      : 0;

    super.initState();
  }

  @override
  void dispose() {
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
    if (paused) {
      playerController.play();
      barController.play();
      paused = false;
    } else {
      playerController.pause();
      barController.pause();
      paused = true;
    }
  }

  void stopVideoPlayerOnBreakpoint() {
    playerController.pause();
    paused = true;
  }

  // void didSelectLesson(int index) {
  //   if (lessonIndex == index) return;
  //   changeVideoUrl(widget.course.lessons[index].videoUrl);
  //   setState(() => lessonIndex = index);
  // }

  @override
  Widget build(BuildContext context) {
    final questionIndex = this.questionIndex;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Title(widget.course.title),
        _LessonSelection(
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
                  onTap:toggleVideoPlayer,
                  child: Container(
                    color: Colors.black,
                    child: IgnorePointer(child: VideoPlayer(playerController)),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: VideoBar(
                  breakpoints: 
                    widget.course.lessons[widget.lessonIndex].questions
                    .map((question) => question.timeStamp).toIList(),
                  controller: barController,
                  onChange: (position) {
                    playerController.seekTo(position);
                  },
                  onToggle: toggleVideoPlayer,
                  onBreakpointReached: stopVideoPlayerOnBreakpoint,
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
          onNext: () => barController.play(),
        ),
      ].addBetween(const SizedBox(height: _verticalSpacing)),
    );
  }

  void changeVideoUrl(String url) {
    this.playerController.dispose();
    final playerController = VideoPlayerController.network(url);
    playerController.initialize().then((_) =>
      setState(() => 
        barController.initialize((
          duration: playerController.value.duration,
          position: Duration.zero,
        ))
      )
    );
    this.playerController = playerController;

    barController.seek(Duration.zero);
  }
}

class _Title extends StatelessWidget {
  final String text;

  const _Title(this.text);

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Text(
      text,
      style: theme.textStyle(
        color: theme.colors.primary,
        size: 24,
        weight: FontWeight.bold,
      )
    );
  }
}

class _LessonSelection extends StatelessWidget {
  final List<Lesson> lessons;
  final int selectedIndex;
  final void Function(int) onSelect;

  const _LessonSelection(
    this.lessons,
    {required this.selectedIndex,
    required this.onSelect}
  );

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: lessons.mapIndexed<Widget>((i, lesson) =>
        SelectableTextButton(
          lesson.title,
          selected: selectedIndex == i,
          onPressed: () => onSelect(i), 
        )
      ).toList()
    );
  }
}
