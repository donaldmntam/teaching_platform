import 'package:teaching_platform/courses/widgets/video_bar/video_bar.dart';

abstract interface class VideoBarControllerListener {
  void shouldPlay();
  void shouldPause();
}

class VideoBarController  {
  late final VideoBarControllerListener listener;

  final State initialState;

  VideoBarController({
    this.initialState = const Paused(),
  });

  void play() {
    listener.shouldPlay();
  }

  void pause() {
    listener.shouldPause();
  }
}