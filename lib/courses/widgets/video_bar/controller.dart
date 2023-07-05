import 'package:teaching_platform/courses/widgets/video_bar/video_bar.dart';

abstract interface class VideoBarControllerListener {
  void shouldInitialize(Data data);
  void shouldPlay();
  void shouldPause();
}

class VideoBarController  {
  late final VideoBarControllerListener listener;

  VideoBarController();

  void initialize(Data data) {
    listener.shouldInitialize(data);
  }

  void play() {
    listener.shouldPlay();
  }

  void pause() {
    listener.shouldPause();
  }
}