import 'package:flutter/material.dart';

import 'package:flutter/material.dart' hide Theme;
import 'package:teaching_platform/common/functions/iterable_functions.dart';
import 'package:teaching_platform/common/models/course/question.dart';
import 'package:teaching_platform/common/widgets/services.dart/services.dart';
import 'package:teaching_platform/courses/widgets/course_column/typedefs.dart';
import 'package:teaching_platform/courses/widgets/question_column/question_widget.dart';

class QuestionColumn extends StatelessWidget {
  final List<Question> questions;

  const QuestionColumn(
    this.questions,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return SingleChildScrollView(
      child: Container(
        color: theme.colors.surface,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: questions.map((question) =>
            QuestionWidget(question),
          ).toList()
        ),
      ),
    );
  }
}
