import 'package:flutter/material.dart' hide Title;
import 'package:teaching_platform/common/models/task/question.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/common/widgets/text_field/long_text_field.dart';
import 'package:teaching_platform/tasks/widgets/questions/values.dart';
import '../title.dart';

class TextQuestionWidget extends StatelessWidget {
  final int index;
  final TextQuestion question;
  final void Function(int index, String text) onAnswerChange;

  const TextQuestionWidget({
    super.key,
    required this.index,
    required this.question,
    required this.onAnswerChange,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Title(question.title),
        const SizedBox(height: spacing),
        LongTextField(
          onTextChange: (text) => onAnswerChange(index, text),
        )
      ]
    );
  }
}
