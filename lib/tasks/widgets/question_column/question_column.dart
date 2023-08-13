import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:teaching_platform/common/models/task/input.dart';
import 'package:teaching_platform/common/models/task/question.dart';
import 'package:teaching_platform/tasks/widgets/questions/mc_question/mc_question.dart';
import 'package:teaching_platform/tasks/widgets/questions/text_question/text_question.dart';

class QuestionColumn extends StatelessWidget {
  final IList<Question> questions;
  final void Function(int index, Input input) onInputChange;

  const QuestionColumn({
    super.key,
    required this.questions,
    required this.onInputChange,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: questions.length,
      itemBuilder: (_, index) {
        final question = questions[index];
        return switch (question) {
          TextQuestion() => TextQuestionWidget(
            index: index,
            question: question,
            onInputChange: onInputChange,
          ),
          McQuestion() => McQuestionWidget(
            index: index,
            question: question,
            onInputChange: onInputChange,
          ),
        };
      },
      separatorBuilder: (_, __) => const SizedBox(height: 8),
    );
  }
}