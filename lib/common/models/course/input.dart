sealed class Input {
  const Input();

  @override
  int get hashCode {
    final input = this;
    switch (input) {
      case TextInput():
        return input.text.hashCode;
      case McInput():
        return input.selectedIndex.hashCode;
    }
  }

  @override
  bool operator ==(Object? other) {
    if (other is! Input) return false;
    final thisInput = this;
    switch (thisInput) {
      case TextInput():
        if (other is! TextInput) return false;
        return thisInput.text.trim().toLowerCase() ==
          other.text.trim().toLowerCase();
      case McInput():
        if (other is! McInput) return false;
        return thisInput.selectedIndex == 
          other.selectedIndex;
    }
  }

  @override
  String toString() {
    final localThis = this;
    return switch (localThis) {
      TextInput() => "TextInput { text: ${localThis.text} }",
      McInput() => "McInput { selectedIndex: ${localThis.selectedIndex} }",
    };
  }
}

final class TextInput extends Input {
  final String text;

  const TextInput(this.text);
}

final class McInput extends Input {
  final int? selectedIndex;

  const McInput(this.selectedIndex);
}

