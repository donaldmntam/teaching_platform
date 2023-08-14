import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:teaching_platform/common/functions/block_functions.dart';
import 'package:teaching_platform/common/functions/error_functions.dart';
import 'package:teaching_platform/common/models/task/input.dart';
import 'package:teaching_platform/common/models/task/question.dart';
import 'package:teaching_platform/tasks/widgets/questions/mc_question/mc_question.dart';
import 'package:teaching_platform/tasks/widgets/questions/text_question/text_question.dart';

const _padding = 12.0;

class QuestionColumn extends StatelessWidget {
  final IList<Question> questions;
  final IList<Input> inputs;
  final void Function(int index, Input input) onInputChange;

  const QuestionColumn({
    super.key,
    required this.questions,
    required this.inputs,
    required this.onInputChange,
  });

  @override
  Widget build(BuildContext context) {
    final widgets = _widgets(
      questions: questions,
      inputs: inputs,
      onInputChange: onInputChange,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _padding),
      child: ListView.separated(
        itemCount: widgets.length,
        itemBuilder: (_, index) => widgets[index],
        separatorBuilder: (_, __) => const SizedBox(height: 8),
      ),
    );
  }
}

List<Widget> _widgets({
  required IList<Question> questions,
  required IList<Input> inputs,
  required void Function(int index, Input input) onInputChange,
}) {
  final list = List<Widget>.empty(growable: true);
  
  list.add(const SizedBox(height: _padding));

  for (var i = 0; i < questions.length; i++) {
    final question = questions[i];
    final input = inputs[i];
    list.add(
      run(() {
        switch (question) {
          case TextQuestion():
            if (input is! TextInput) badType(input, TextInput);
            return TextQuestionWidget(
              index: i,
              question: question,
              input: input,
              onInputChange: onInputChange,
            );
          case McQuestion():
            if (input is! McInput) badType(input, McInput);
            return McQuestionWidget(
              index: i,
              question: question,
              input: input,
              onInputChange: onInputChange,
            );
        }
      }),
    );
  }

  list.add(const SizedBox(height: _padding));

  return list;
}
