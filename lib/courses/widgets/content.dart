import 'package:flutter/material.dart' hide TextButton;
import 'package:teaching_platform/common/functions/iterable_functions.dart';
import 'package:teaching_platform/common/functions/list_functions.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/button/selectable_text_button.dart';
import 'package:teaching_platform/common/widgets/services.dart/services.dart';
import 'package:teaching_platform/courses/models/course.dart';
import 'package:teaching_platform/courses/models/lesson.dart';
import 'package:video_player/video_player.dart';

import 'video_bar/controller.dart';
import 'video_bar/video_bar.dart' hide State;

const _verticalSpacing = 16.0;

// TODO: video player flickering

class Content extends StatefulWidget {
  final Course course;

  const Content({
    super.key,
    required this.course,
  });

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  late VideoPlayerController playerController;
  late final VideoBarController barController;

  bool paused = true;
  int lessonIndex = 0;

  @override
  void initState() {
    final playerController = VideoPlayerController.network(
      widget.course.lessons[lessonIndex].videoUrl
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

  void didSelectLesson(int index) {
    if (lessonIndex == index) return;
    changeVideoUrl(widget.course.lessons[index].videoUrl);
    setState(() => lessonIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Title(widget.course.title),
        const SizedBox(height: _verticalSpacing),
        _LessonSelection(
          widget.course.lessons,
          selectedIndex: lessonIndex,
          onSelect: didSelectLesson,
        ),
        const SizedBox(height: _verticalSpacing),
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
                  controller: barController,
                  onChange: (position) {
                    playerController.seekTo(position);
                  },
                  onToggle: toggleVideoPlayer,
                ),
              ),
            ]
          ),
        ),
        const SizedBox(height: _verticalSpacing),
      ],
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
      runSpacing: 12,
      children: lessons.mapIndexed<Widget>((i, lesson) =>
        SelectableTextButton(
          lesson.title,
          selected: selectedIndex == i,
          onPressed: () => onSelect(i), 
        )
      ).toList().insertInBetween((_) => const SizedBox(width: 16)),
    );
  }
}
