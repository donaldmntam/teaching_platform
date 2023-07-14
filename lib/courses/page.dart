import 'package:flutter/material.dart' hide TextButton, State, Theme;
import 'package:flutter/widgets.dart' as widgets show State;
import 'package:teaching_platform/common/functions/iterable_functions.dart';
import 'package:teaching_platform/common/functions/list_functions.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/button/selectable_text_button.dart';
import 'package:teaching_platform/common/widgets/button/text_button.dart';
import 'package:teaching_platform/common/widgets/services.dart/services.dart';
import 'package:teaching_platform/courses/widgets/video_bar/controller.dart';
import 'package:teaching_platform/courses/widgets/video_bar/video_bar.dart';
import 'package:video_player/video_player.dart';

const _verticalSpacing = 16.0;

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  widgets.State<Page> createState() => _State();
}

class _State extends widgets.State<Page> {
  late final VideoPlayerController playerController;
  late final VideoBarController barController;

  Data? data;

  bool paused = true;

  @override
  void initState() {
    playerController = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
    playerController.dataSource;
    playerController.initialize().then((_) =>
      setState(() => 
        barController.initialize((
          duration: playerController.value.duration,
          position: Duration.zero,
        ))
      )
    );

    barController = VideoBarController();

    super.initState();
  }

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Title("Leadership"),
          const SizedBox(height: _verticalSpacing),
          _LessonSelection(
            const ["Lesson 1", "Lesson 2", "Lesson 3"],
            selectedIndex: 0,
            onSelect: (_) {},
          ),
          const SizedBox(height: _verticalSpacing),
          AspectRatio(
            aspectRatio: 3.0,
            child: VideoPlayer(playerController)
          ),
          const SizedBox(height: _verticalSpacing),
          SizedBox(
            width: double.infinity,
            child: VideoBar(
              controller: barController,
              onChange: (position) {
                playerController.seekTo(position);
              },
              onToggle: () {
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
            ),
          ),
          const SizedBox(height: _verticalSpacing),
          TextButton(
            "check duration",
            onPressed: () async {
              print("duration: ${playerController.value.duration}");
            }
          )
        ],
      )
    );
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
  final List<String> lessons;
  final int selectedIndex;
  final void Function(int) onSelect;

  const _LessonSelection(
    this.lessons,
    {required this.selectedIndex,
    required this.onSelect}
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: lessons.mapIndexed<Widget>((i, lesson) =>
        SelectableTextButton(
          lesson,
          selected: selectedIndex == i,
          onPressed: () => onSelect(i), 
        )
      ).toList().insertInBetween((_) => const SizedBox(width: 16)),
    );
  }
}
