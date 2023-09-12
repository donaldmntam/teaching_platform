sealed class Try<T> {  
  const Try();

  T unwrap() => switch (this) {
    Ok(value: final value) => value,
    Err(value: final value) => 
      throw "Try unwrapped when it is an error! The error was $value",
  };
}

final class Ok<T> extends Try<T> {
  final T value;

  const Ok(this.value);

  T get() => value;
}

final class Err extends Try<Never> {
  final Object? value;

  const Err(this.value);

  Object? get() => value;
}

extension ExtendedTry<T> on Try<T> {
}
