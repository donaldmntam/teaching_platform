import 'package:teaching_platform/courses/widgets/video_bar/video_bar.dart';

abstract interface class VideoBarControllerListener {
  void shouldInitialize();
  void shouldPlay();
  void shouldPause();
}

class VideoBarController  {
  late final VideoBarControllerListener listener;

  final State initialState;

  VideoBarController({
    this.initialState = const Uninitialized(),
  });

  void initialize(Data data) {
    listener.shouldInitialize();
  }

  void play() {
    listener.shouldPlay();
  }

  void pause() {
    listener.shouldPause();
  }
}