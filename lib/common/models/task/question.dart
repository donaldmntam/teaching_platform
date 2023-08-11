import 'package:fast_immutable_collections/fast_immutable_collections.dart';

sealed class Question {
  final String title;

  const Question({required this.title});
}

final class TextQuestion extends Question {
  final String answer;

  const TextQuestion({
    required super.title,
    required this.answer,
  });
}

final class McQuestion extends Question {
  final IList<String> options;
  final int selectedIndex;

  const McQuestion({
    required super.title,
    required this.options,
    required this.selectedIndex
  });
}
