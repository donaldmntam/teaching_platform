import 'package:flutter/material.dart' hide State;
import 'package:flutter/widgets.dart' as widgets show State;

class VideoBar extends StatefulWidget {
  const VideoBar({super.key});

  @override
  widgets.State<VideoBar> createState() => _WidgetState();
}

class _WidgetState extends widgets.State<VideoBar> {


  @override
  Widget build(BuildContext context) {
    throw "";
  }
}

sealed class State {}

final class Paused {
  final Duration position;

  const Paused(this.position);
}

// final class 