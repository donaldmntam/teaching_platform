import 'package:flutter/material.dart' hide TextButton, State;
import 'package:flutter/widgets.dart' as widgets show State;
import 'package:flutter/scheduler.dart';
import 'package:teaching_platform/common/functions/error_functions.dart';
import 'package:teaching_platform/common/widgets/button/text_button.dart';
import 'package:teaching_platform/common/widgets/services.dart/clock.dart';
import 'package:teaching_platform/common/widgets/services.dart/services.dart';
import 'package:teaching_platform/courses/state.dart';
import 'package:teaching_platform/courses/widgets/video_bar/controller.dart';
import 'package:teaching_platform/courses/widgets/video_bar/video_bar.dart';
import 'package:video_player/video_player.dart';

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  widgets.State<Page> createState() => _State();
}

class _State extends widgets.State<Page> {
  late final VideoPlayerController playerController;
  late final VideoBarController barController;

  Duration position = Duration.zero;
  bool paused = true;

  @override
  void initState() {
    playerController = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
    playerController.dataSource;
    playerController.initialize();

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
        children: [
          SizedBox(
            height: 400,
            child: VideoPlayer(playerController)
          ),
          VideoBar(
            duration: playerController.value.duration,
            position: position,
            controller: barController,
            onChange: (_) {},
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