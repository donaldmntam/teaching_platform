import 'package:flutter/material.dart';
import 'package:teaching_platform/common/models/task/question.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/services.dart/services.dart';

class TextQuestionWidget extends StatelessWidget {
  final TextQuestion question;

  const TextQuestionWidget(
    this.question,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;

    return Column(
      children: [
        Text(
          question.title,
          style: theme.textStyle(
            size: 14,
            weight: FontWeight.bold,
            color: theme.colors.onSurface,
          ),
        ),
        Material(
          child: TextField(
            decoration: InputDecoration(
              fillColor: theme.colors.background,
              filled: true,
            ),
            style: theme.textStyle(
              size: 12,
              weight: FontWeight.bold,
              color: theme.colors.onSurface,
            ),
          ),
        )
      ]
    );
  }
}
