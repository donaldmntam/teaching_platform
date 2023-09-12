sealed class Input {}

final class TextInput implements Input {
  static const TextInput empty = TextInput("");

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
  static const McInput empty = McInput(null);

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

Input? jsonToInput(Object? json) {
  if (
    json case {
      "type": String type,
    }
  ) {
    return switch (type) {
      "mc" => jsonToMcInput(json),
      "text" => jsonToTextInput(json),
      _ => null
    };
  }
  return null;
}

McInput? jsonToMcInput(Object? json) {
  if (
    json case {
      "selectedIndex": int selectedIndex,
    }
  ) {
    return McInput(selectedIndex);
  }
  return null;
}

TextInput? jsonToTextInput(Object? json) {
  if (
    json case {
      "text": String text,
    }
  ) {
    return TextInput(text);
  }
  return null;
}
