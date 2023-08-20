import 'package:teaching_platform/common/functions/error_functions.dart';

import 'state.dart';

class Channel<T> {
  State<T> state = const NotListening();

  Channel();

  void listen(void Function(T event) listener) {
    final state = this.state;
    if (state is! NotListening<T>) illegalState(state, "listen");
    this.state = Listening(listener: listener);
    for (final event in state.events) {
      listener(event);
    }
  }

  void stopListening() {
    final state = this.state;
    if (state is! Listening<T>) illegalState(state, "listen");
    this.state = const NotListening();
  }

  void add(T event) {
    final state = this.state;
    switch (state) {
      case NotListening():
        this.state = NotListening(events: [...state.events, event]);
      case Listening():
        state.listener(event);
    }
  }
}