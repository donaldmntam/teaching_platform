import 'package:flutter/material.dart' hide Title;
import 'package:teaching_platform/common/models/task/question.dart';
import 'package:teaching_platform/tasks/widgets/questions/mc_question/option.dart';
import 'package:teaching_platform/tasks/widgets/questions/values.dart';
import '../title.dart';

class McQuestionWidget extends StatelessWidget {
  final McQuestion question;

  const McQuestionWidget({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Title(question.title),
        const SizedBox(height: spacing),
        for (var i = 0; i < question.options.length; i++) Padding(
          padding: i == question.options.length
            ? const EdgeInsets.all(0)
            : const EdgeInsets.only(bottom: spacing),
          child: Option(
            option: question.options[i],
            chosen: question.selectedIndex == i,
          ),
        ),
      ]
    );
  }
}