extension ExtendedDuration on Duration {
  String toTimeString() { 
    final totalSeconds = inSeconds;
    final seconds = totalSeconds % 60;
    final minutes = (totalSeconds ~/ 60) % 60;
    final hours = totalSeconds ~/ 3600;
    final s = seconds.toString().padLeft(2, '0');
    final m = switch (hours > 0) {
      true => minutes.toString().padLeft(2, '0'),
      false => minutes.toString(),
    };
    return switch (hours) {
      0 => "$m:$s",
      _ => "${hours.toString()}:$m:$s",
    };
  }
}