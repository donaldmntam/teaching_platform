import 'package:flutter/material.dart' hide Title;
import 'package:teaching_platform/common/models/course/input.dart';
import 'package:teaching_platform/common/models/course/question.dart';
import 'package:teaching_platform/tasks/widgets/questions/mc_question/option.dart';
import 'package:teaching_platform/tasks/widgets/questions/values.dart';
import '../description.dart';

class McQuestionWidget extends StatefulWidget {
  final McQuestion question;
  final McInput initialInput;
  final void Function(McInput input) onInputChange;

  const McQuestionWidget({
    super.key,
    required this.question,
    required this.initialInput,
    required this.onInputChange,
  });

  @override
  State<McQuestionWidget> createState() => _McQuestionWidgetState();
}

class _McQuestionWidgetState extends State<McQuestionWidget> {
  late int? selectedIndex;

  @override
  void initState() {
    selectedIndex = widget.initialInput.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Description(widget.question.description),
        const SizedBox(height: spacing),
        for (var i = 0; i < widget.question.options.length; i++) Padding(
          padding: i == widget.question.options.length - 1
            ? const EdgeInsets.all(0)
            : const EdgeInsets.only(bottom: spacing),
          child: Option(
            option: widget.question.options[i],
            chosen: selectedIndex == i,
            onPressed: () {
              setState(() => selectedIndex = i);
              widget.onInputChange(McInput(i));
            }
          ),
        ),
      ]
    );
  }
}