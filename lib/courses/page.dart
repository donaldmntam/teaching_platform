import 'package:flutter/material.dart' hide TextButton, State;
import 'package:flutter/widgets.dart' as widgets show State;
import 'package:flutter/scheduler.dart';
import 'package:teaching_platform/common/functions/error_functions.dart';
import 'package:teaching_platform/common/widgets/button/text_button.dart';
import 'package:teaching_platform/common/widgets/services.dart/clock.dart';
import 'package:teaching_platform/common/widgets/services.dart/services.dart';
import 'package:teaching_platform/courses/state.dart';
import 'package:teaching_platform/courses/widgets/video_bar.dart';
import 'package:video_player/video_player.dart';

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  widgets.State<Page> createState() => _State();
}

class _State extends widgets.State<Page> {
  late final VideoPlayerController controller;

  Duration position = Duration.zero;
  State state = const Paused();

  @override
  void initState() {
    controller = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
    controller.dataSource;
    controller.initialize().then((_) {
      play();
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void play() {
    final now = Services.of(context).clock.now();
    final state = this.state;
    switch (state) {
      case Paused():
        setState(() {
          this.state = Playing(reference: now);
        });
        controller.play();
      case Playing():
        badTransition(state, "play");
    }
  }

  void pause() {
    final now = Services.of(context).clock.now();
    final state = this.state;
    switch (state) {
      case Playing(reference: final reference):
        setState(() {
          position = position + now.difference(reference);
          this.state = const Paused();
        });
        controller.pause();
      case Paused():
        badTransition(state, "pause");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 400,
            child: VideoPlayer(controller)
          ),
          VideoBar(
            duration: controller.value.duration,
            position: position,
            state: state,
            onChange: (_) {},
            onToggle: () {
              switch (state) {
                case Paused():
                  play();
                case Playing():
                  pause();
              }
            }
          ),
          TextButton(
            "check duration",
            onPressed: () async {
              print("duration: ${controller.value.duration}");
            }
          )
        ],
      )
    );
  }
}