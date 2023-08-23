sealed class Input {}

final class TextInput implements Input {
  final String text;

  const TextInput(this.text);
}

final class McInput implements Input {
  final int? selectedIndex;

  const McInput(this.selectedIndex);
}
