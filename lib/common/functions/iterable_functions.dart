extension ExtendedIterable<T> on Iterable<T> {
  Iterable<R> mapIndexed<R>(R Function(int i, T e) transform) {
    var i = 0;
    return map((e) {
      final index = i;
      i++;
      return transform(index, e);
    });
  }
}