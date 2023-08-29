sealed class Optional<T> {}

final class Some<T> implements Optional<T> {
  final T value;

  const Some(this.value);
}

final class None implements Optional<Never> {
  const None();
}

extension ExtendedOptional<T> on Optional<T> {
  T fold(T Function() onNone) {
    return switch (this) {
      Some(value: final value) => value,
      None() => onNone(),
    };
  }

  Optional<R> map<R>(R Function(T it) transform) {
    switch (this) {
      case Some(value: final value):
        return Some(transform(value));
      case None():
        return const None();
    }
  }
}