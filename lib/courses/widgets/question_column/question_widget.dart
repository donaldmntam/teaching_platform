import 'package:flutter/material.dart';
import 'package:teaching_platform/common/functions/duration_functions.dart';
import 'package:teaching_platform/common/models/course/question.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';

const _iconContainerSize = 24.0;
const _iconSize = 20.0;

class QuestionWidget extends StatelessWidget {
  final Question question;

  const QuestionWidget(
    this.question,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colors.onSurface.withAlpha(20),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.timeStamp.toTimeString(),
            style: theme.textStyle(
              size: 11,
              color: theme.colors.onSurface.withAlpha(125),
              weight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: _iconContainerSize,
                height: _iconContainerSize,
                decoration: BoxDecoration(
                  color: theme.colors.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  switch (question) {
                    McQuestion() => Icons.format_list_bulleted,
                    TextQuestion() => Icons.article_outlined,
                  },
                  color: theme.colors.onPrimary,
                  size: _iconSize,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                question.title,
                style: theme.textStyle(
                  size: 13,
                  color: theme.colors.onSurface,
                  weight: FontWeight.normal,
                )
              ),
            ]
          )
        ]
      ),
    );
  }
}


extension on Question {
  // TODO: translation
  String get title {
    return switch (this) {
      McQuestion() => "Multiple Choice",
      TextQuestion() => "Open Ended",
    };
  }
}