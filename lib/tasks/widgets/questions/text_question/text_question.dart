import 'package:flutter/material.dart' hide Title;
import 'package:teaching_platform/common/models/task/input.dart';
import 'package:teaching_platform/common/models/task/question.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/common/widgets/text_field/long_text_field.dart';
import 'package:teaching_platform/tasks/widgets/questions/values.dart';
import '../title.dart';

class TextQuestionWidget extends StatefulWidget {
  final int index;
  final TextQuestion question;
  final TextInput input;
  final void Function(int index, TextInput input) onInputChange;

  const TextQuestionWidget({
    super.key,
    required this.index,
    required this.question,
    required this.input,
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
    controller.text = widget.input.text;
    controller.addListener(() => 
      widget.onInputChange(widget.index, TextInput(controller.text))
    );
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
    controller.text = widget.input.text;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Title(widget.question.title),
        const SizedBox(height: spacing),
        LongTextField(
          onTextChange: (text) => widget.onInputChange(
            widget.index,
            TextInput(text),
          ),
        )
      ]
    );
  }
}
