import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';
import 'package:teaching_platform/common/models/task/question.dart';
import 'package:teaching_platform/tasks/widgets/question_column/question_column.dart';

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: QuestionColumn(
        questions: [
          TextQuestion(
            title: "title",
            answer: "answer",
          ),
          McQuestion(
            title: "title",
            options: [
              "option 1",
              "option 2",
              "option 3",
            ].lock,
            selectedIndex: 1,
          ),
        ].lock,
        onAnswerChange: (_, __) => {},
      ),
    );
  }
}