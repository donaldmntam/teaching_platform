import 'package:flutter/material.dart' hide TextButton;
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/common/widgets/text_field/long_text_field.dart';
import 'package:teaching_platform/common/widgets/button/text_button.dart';

class CommentDialog extends StatefulWidget {
  const CommentDialog({
    super.key,
  });

  @override
  State<CommentDialog> createState() => _State();
}

class _State extends State<CommentDialog> {
  String comment = "";

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Center(child: LayoutBuilder(
      builder: (context, constraints) => Container(
        width: constraints.maxWidth * 0.5,
        height: constraints.maxHeight * 0.3,
        decoration: BoxDecoration(
          color: theme.colors.surface,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: LongTextField(
                singleLine: false,
                onTextChange: (value) => setState(() => comment = value),
              )
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
             child: TextButton(
                "Confirm",
                onPressed: comment.isNotEmpty
                  ? () => Navigator.of(context).pop(comment)
                  : null,
              )
            ),
          ],
        ),
      ),
    ));
  }
}

