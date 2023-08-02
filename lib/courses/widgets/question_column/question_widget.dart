import 'package:flutter/material.dart';
import 'package:teaching_platform/common/functions/duration_functions.dart';
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
          color: theme.colors.onSurface.withAlpha(20),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Text(
            question.timeStamp.toTimeString(),
            style: theme.textStyle(
              size: 11,
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