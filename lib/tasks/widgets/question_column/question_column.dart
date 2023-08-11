import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:teaching_platform/common/models/task/question.dart';
import 'package:teaching_platform/tasks/widgets/question_column/text_question.dart';

class QuestionColumn extends StatelessWidget {
  final IList<Question> questions;

  const QuestionColumn(
    this.questions,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: questions.length,
      itemBuilder: (_, index) {
        final question = questions[index];
        return switch (question) {
          TextQuestion() => TextQuestionWidget(question),
          McQuestion() => throw "",
        };
      },
      separatorBuilder: (_, __) => const SizedBox(height: 8),
    );
  }
}