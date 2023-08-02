extension ExtendedList<T> on List<T> {
  void insertInBetween(T Function(int i) elementBuilder) {
    final length = this.length;
    var i = 0;
    while (i < length) {
      insert((i * 2) + 1, elementBuilder(i));
      i++;
    }
  }
}

List<T> repeat<T>(List<T> list, int count) {
  final newList = List<T>.empty(growable: true);
  for (var i = 0; i < count; i++) {
    newList.addAll(list);
  }
  return newList;
}
