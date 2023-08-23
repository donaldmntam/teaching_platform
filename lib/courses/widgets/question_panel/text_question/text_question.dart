import 'package:flutter/material.dart' hide Title;
import 'package:teaching_platform/common/models/course/input.dart';
import 'package:teaching_platform/common/models/course/question.dart';
import 'package:teaching_platform/common/widgets/text_field/long_text_field.dart';
import 'package:teaching_platform/tasks/widgets/questions/values.dart';
import '../description.dart';

class TextQuestionWidget extends StatefulWidget {
  final TextQuestion question;
  final TextInput initialInput;
  final void Function(TextInput input) onInputChange;

  const TextQuestionWidget({
    super.key,
    required this.question,
    required this.initialInput,
    required this.onInputChange,
  });

  @override
  State<TextQuestionWidget> createState() => _TextQuestionWidgetState();
}

class _TextQuestionWidgetState extends State<TextQuestionWidget> {
  late final TextEditingController controller;


  @override
  void initState() {
    final controller = TextEditingController();
    controller.text = widget.initialInput.text;
    this.controller = controller;

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(TextQuestionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Description(widget.question.description),
        const SizedBox(height: spacing),
        LongTextField(
          controller: controller,
          onTextChange: (text) => 
            widget.onInputChange(TextInput(text)),
        )
      ]
    );
  }
}
