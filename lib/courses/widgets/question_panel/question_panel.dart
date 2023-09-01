import 'dart:math';

import 'package:flutter/material.dart' hide TextButton;
import 'package:flutter/scheduler.dart';
import 'package:teaching_platform/common/functions/error_functions.dart';
import 'package:teaching_platform/common/models/course/input.dart';
import 'package:teaching_platform/common/models/course/question.dart';
import 'package:teaching_platform/common/widgets/button/text_button.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/courses/widgets/question_panel/mc_question/mc_question.dart';
import 'package:teaching_platform/courses/widgets/question_panel/text_question/text_question.dart';
import 'package:teaching_platform/courses/values.dart';

const _animationDuration = Duration(milliseconds: 600);

class QuestionPanel extends StatefulWidget {
  final int lessonIndex;
  final int questionIndex;
  final Question question;
  final Input input;
  final void Function({
    required int lessonIndex,
    required int questionIndex,
    required Input input,
  }) onInputChange;
  final void Function()? onNext;

  const QuestionPanel({
    super.key,
    required this.lessonIndex,
    required this.questionIndex,
    required this.question,
    required this.input,
    required this.onInputChange,
    required this.onNext,
  });

  @override
  State<QuestionPanel> createState() => _QuestionPanelState();
}

class _QuestionPanelState 
  extends State<QuestionPanel> 
  with SingleTickerProviderStateMixin
{
  late final Ticker ticker;
  late Color startColor;
  late Color endColor;
  double animationValue = 0;

  @override
  void initState() {
    ticker = createTicker(onTick);
    ticker.start();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final theme = Services.of(context).theme;
    startColor = theme.colors.primary;
    endColor = theme.colors.surface;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  void onTick(Duration duration) {
    final animationValue = 
      duration.inMilliseconds / _animationDuration.inMilliseconds;
    if (animationValue >= 1) ticker.stop();
    setState(() => this.animationValue = min(animationValue, 1));
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.question;
    final input = widget.input;
    final theme = Services.of(context).theme;

    final Widget child;
    switch (question) {
      case TextQuestion():
        if (input is! TextInput) badType(input, TextInput);
        child = TextQuestionWidget(
          question: question,
          initialInput: input,
          onInputChange: (input) => widget.onInputChange(
            lessonIndex: widget.lessonIndex,
            questionIndex: widget.questionIndex,
            input: input,
          ),
        );
      case McQuestion():
        if (input is! McInput) badType(input, McInput);
        child = McQuestionWidget(
          question: question,
          initialInput: input,
          onInputChange: (input) => widget.onInputChange(
            lessonIndex: widget.lessonIndex,
            questionIndex: widget.questionIndex,
            input: input,
          ),
        );
    }
     
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(panelSpacing),
          decoration: panelDecoration(theme).copyWith(
            color: Color.lerp(startColor, endColor, animationValue),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              child,
              const SizedBox(height: panelSpacing),
              TextButton(
                "Next",
                onPressed: widget.onNext,
              ),
            ],
          )
        ),
      ],
    );
  }
}
