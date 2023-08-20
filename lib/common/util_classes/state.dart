sealed class State<T> {}

final class NotListening<T> implements State<T> {
  final Iterable<T> events;

  const NotListening({this.events = const []});
}

final class Listening<T> implements State<T> {
  final void Function(T event) listener;

  const Listening({required this.listener});
}
