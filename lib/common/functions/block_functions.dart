R run<R>(R Function() block) {
  return block();
}

extension ExtendedNullableAny<T> on T? {
  R? let<R>(R Function(T it) block) {
    final localThis = this;
    if (localThis == null) {
      return null;
    }
    return block(localThis);
  }
}