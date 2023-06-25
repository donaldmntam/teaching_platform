import 'package:flutter/material.dart';

class VideoBar extends StatelessWidget {
  final Duration duration;
  final Duration position;
  final void Function(Duration) onChange;

  const VideoBar({
    super.key,
    required this.duration,
    required this.position,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 0,
      max: duration.inMilliseconds.toDouble(),
      value: position.inMilliseconds.toDouble(),
      onChanged: (value) => onChange(Duration(milliseconds: value.toInt())),
    );
  }
}