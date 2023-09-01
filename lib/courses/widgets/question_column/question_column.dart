import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:teaching_platform/common/functions/list_functions.dart';
import 'package:teaching_platform/common/models/course/question.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/courses/widgets/question_column/question_widget.dart' hide State;
import 'package:teaching_platform/courses/widgets/question_column/question_widget.dart' as question_widget;
import 'package:teaching_platform/common/functions/block_functions.dart';
import 'package:teaching_platform/common/monads/optional.dart';

import '../content/state.dart' as content;

class QuestionColumn extends StatelessWidget {
  final content.State state;
  final IList<Question> questions;

  const QuestionColumn({
    super.key,
    required this.state,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    final builders = _widgetBuilders(state, questions);
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

List<Widget Function()> _widgetBuilders(
  content.State state,
  IList<Question> questions,
) {
  final builders = List<Widget Function()>.empty(growable: true);
  builders.add(_spacerBuilder);
  for (var i = 0; i < questions.length; i++) {
    builders.add(() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: QuestionWidget(
        state: run(() {
          switch (state) {
            case content.Loading():
              return question_widget.State.incoming;
            case content.Paused():
              final indexOpt = state.nextQuestionIndex;
              if (indexOpt is None) return question_widget.State.finished;
              final index = indexOpt.unwrap();
              if (i < index) return question_widget.State.finished;
              return question_widget.State.incoming;
            case content.Playing():
              final indexOpt = state.nextQuestionIndex;
              if (indexOpt is None) return question_widget.State.finished;
              final index = indexOpt.unwrap();
              if (i < index) return question_widget.State.finished;
              return question_widget.State.incoming;
            case content.AtBreakpoint():
              final index = state.questionIndex;
              if (i < index) return question_widget.State.finished;
              if (i == index) return question_widget.State.current;
              return question_widget.State.incoming;
          }
        }),
        question: questions[i]
      ),
    ));
  }
  builders.insertInBetween((_) => _spacerBuilder);
  builders.add(_spacerBuilder);
  return builders;
}
