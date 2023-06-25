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

class _State extends widgets.State<Page> with SingleTickerProviderStateMixin {
  late final VideoPlayerController controller;
  late final Ticker ticker;
  late final Clock clock;

  State state = const Paused();

  @override
  void initState() {
    controller = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
    controller.dataSource;
    controller.initialize().then((_) => controller.play());

    ticker = createTicker(onTick);

    clock = Services.of(context).clock;

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    ticker.dispose();
    super.dispose();
  }

  void onTick(Duration duration) {
    final state = this.state;
    switch (state) {
      case Playing(reference: final reference):
        this.state = Playing(
          reference: reference,
          now: clock.now(),
        );
        setState(() {});
      case Paused():
        break;
    }
  }

  void play() {
    final state = this.state;
    switch (state) {
      case Paused():
        final now = clock.now();
        this.state = Playing(
          reference: now,
          now: now,
        );
        setState(() {});
        ticker.start();
      case Playing():
        badTransition(state, "play");
    }
  }

  void pause() {
    final state = this.state;
    switch (state) {
      case Playing():
        this.state = const Paused();
        setState(() {});
        ticker.stop();
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
            position: controller.,
            onChange: (_) {},
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