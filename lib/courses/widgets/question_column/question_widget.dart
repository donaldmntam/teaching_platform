import 'package:flutter/material.dart';
import 'package:teaching_platform/common/models/course/question.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/services.dart/services.dart';

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
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colors.onSurface.withAlpha(30),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Text(
            question.location.toString(),
            style: theme.textStyle(
              size: 12,
              color: theme.colors.onSurface.withAlpha(125),
              weight: FontWeight.normal,
            ),
          ),
          Row(
            children: [
              Container(color: Colors.blue, width: 64, height: 64),
              Text(
                question.title,
                style: theme.textStyle(
                  size: 14,
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