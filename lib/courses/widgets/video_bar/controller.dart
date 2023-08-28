import 'package:teaching_platform/courses/widgets/video_bar/video_bar_old.dart';

abstract interface class VideoBarControllerListener {
  void shouldInitialize(Data data);
  void shouldPlay();
  void shouldPause();
  void shouldSeek(Duration position);
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

  void seek(Duration position) {
    listener.shouldSeek(position);
  }
}