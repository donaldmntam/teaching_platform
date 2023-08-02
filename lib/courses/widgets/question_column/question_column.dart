import 'package:flutter/material.dart';

import 'package:flutter/material.dart' hide Theme;
import 'package:teaching_platform/common/functions/iterable_functions.dart';
import 'package:teaching_platform/common/functions/list_functions.dart';
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
    final builders = _widgetBuilders(questions);
    return Container(
      color: theme.colors.surface,
      child: ListView.builder(
        itemCount: builders.length,
        itemBuilder: (_, i) => builders[i](),
      ),
    );
  }
}

Widget _spacerBuilder() => const SizedBox(height: 8);

List<Widget Function()> _widgetBuilders(List<Question> questions) {
  final builders = List<Widget Function()>.empty(growable: true);
  builders.add(_spacerBuilder);
  for (var i = 0; i < questions.length; i++) {
    builders.add(() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: QuestionWidget(questions[i]))
    );
  }
  builders.insertInBetween((_) => _spacerBuilder);
  builders.add(_spacerBuilder);
  return builders;
}
