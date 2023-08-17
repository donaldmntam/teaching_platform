sealed class Input {}

final class TextInput implements Input {
  final String text;

  const TextInput(this.text);
  
  @override
  bool operator ==(Object? other) {
    if (other is! TextInput) return false;
    return text == other.text;
  }

  @override 
  int get hashCode => text.hashCode;

  @override
  String toString() => "TextInput { text: $text }";
}

final class McInput implements Input {
  final int? selectedIndex;
  
  const McInput(this.selectedIndex);

  @override
  bool operator ==(Object? other) {
    if (other is! McInput) return false;
    return selectedIndex == other.selectedIndex;
  }

  @override 
  int get hashCode => selectedIndex.hashCode;

  @override
  String toString() => "McInput { selectedIndex: $selectedIndex }";
}