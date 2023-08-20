import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:teaching_platform/common/models/task/task.dart';

sealed class State {}

final class AwaitingStart implements State {
  const AwaitingStart();
}

final class Ready implements State {
  final Task task;
  final Duration? startTime;
  final Duration initialTimeRemaining;

  const Ready({
    required this.task,
    this.startTime,
    required this.initialTimeRemaining,
  });

  Ready copyBy({
    Task Function(Task)? task,
    Duration? Function(Duration?)? startTime,
    Duration Function(Duration)? timeAllowed,
    Duration Function(Duration)? timeRemaining,
    Duration Function(Duration)? initialTimeRemaining,
  }) => Ready(
    task: task?.call(this.task) ?? this.task,
    startTime: startTime?.call(this.startTime) ?? this.startTime,
    initialTimeRemaining: initialTimeRemaining?.call(this.initialTimeRemaining) ?? this.initialTimeRemaining,
  );
}

final class Finished implements State {
  const Finished();
}