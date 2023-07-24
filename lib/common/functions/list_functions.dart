extension ExtendedList<T> on List<T> {
  List<T> insertInBetween(T Function(int i) elementBuilder) {
    final list = List<T>.empty(growable: true);
    for (var i = 0; i < length; i++) {
      list.add(this[i]);
      if (i != length - 1) {
        list.add(elementBuilder(i));
      }
    }
    return list;
  }
}

List<T> repeat<T>(List<T> list, int count) {
  final newList = List<T>.empty(growable: true);
  for (var i = 0; i < count; i++) {
    newList.addAll(list);
  }
  return newList;
}
