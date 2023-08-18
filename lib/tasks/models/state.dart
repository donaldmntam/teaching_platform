import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:teaching_platform/common/models/task/task.dart';

sealed class State {}

final class AwaitingStart implements State {
  const AwaitingStart();
}

final class Ready implements State {
  final IList<Task> tasks;
  final Duration? startTime;
  final Duration timeAllowed;
  final Duration timeRemaining;

  const Ready({
    required this.tasks,
    this.startTime,
    required this.timeAllowed,
    required this.timeRemaining,
  });

  Ready copyBy({
    IList<Task> Function(IList<Task>)? tasks,
    Duration? Function(Duration?)? startTime,
    Duration Function(Duration)? timeAllowed,
    Duration Function(Duration)? timeRemaining,
  }) => Ready(
    tasks: tasks?.call(this.tasks) ?? this.tasks,
    startTime: startTime?.call(this.startTime) ?? this.startTime,
    timeAllowed: timeAllowed?.call(this.timeAllowed) ?? this.timeAllowed,
    timeRemaining: timeRemaining?.call(this.timeRemaining) ?? this.timeRemaining,
  );
}

final class Finished implements State {
  const Finished();
}