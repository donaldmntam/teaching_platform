import 'package:flutter/material.dart' hide TextButton;
import 'package:teaching_platform/common/widgets/button/text_button.dart';
import 'package:video_player/video_player.dart';

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _State();
}

class _State extends State<Page> {
  late final VideoPlayerController controller;

  @override
  void initState() {
    controller = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
    controller.dataSource;
    controller.initialize().then((_) => controller.play());
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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