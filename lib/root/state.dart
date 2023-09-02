sealed class State {}

final class NotLoggedIn implements State {
  const NotLoggedIn();
}

final class Ready implements State {
  const Ready();
}

