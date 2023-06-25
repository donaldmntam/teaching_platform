sealed class State {}

final class Paused implements State {
  const Paused();
}

final class Playing implements State {
  final DateTime reference;
  final DateTime now;

  const Playing({
    required this.reference,
    required this.now,
  });
}