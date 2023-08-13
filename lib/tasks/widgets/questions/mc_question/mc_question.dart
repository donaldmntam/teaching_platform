import 'package:flutter/material.dart' hide Title;
import 'package:teaching_platform/common/models/task/input.dart';
import 'package:teaching_platform/common/models/task/question.dart';
import 'package:teaching_platform/tasks/widgets/questions/mc_question/option.dart';
import 'package:teaching_platform/tasks/widgets/questions/values.dart';
import '../title.dart';

class McQuestionWidget extends StatefulWidget {
  final int index;
  final McQuestion question;
  final void Function(int index, McInput input) onInputChange;

  const McQuestionWidget({
    super.key,
    required this.index,
    required this.question,
    required this.onInputChange,
  });

  @override
  State<McQuestionWidget> createState() => _McQuestionWidgetState();
}

class _McQuestionWidgetState extends State<McQuestionWidget> {
  late int selectedIndex;

  @override
  void initState() {
    selectedIndex = widget.question.input.selectedIndex;
    super.initState();
  }

  @override
  void didUpdateWidget(McQuestionWidget oldWidget) {
    selectedIndex = widget.question.input.selectedIndex;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Title(widget.question.title),
        const SizedBox(height: spacing),
        for (var i = 0; i < widget.question.options.length; i++) Padding(
          padding: i == widget.question.options.length
            ? const EdgeInsets.all(0)
            : const EdgeInsets.only(bottom: spacing),
          child: Option(
            option: widget.question.options[i],
            chosen: selectedIndex == i,
            onPressed: () {
              setState(() => selectedIndex = i);
              widget.onInputChange(widget.index, McInput(i));
            }
          ),
        ),
      ]
    );
  }
}