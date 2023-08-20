import 'package:flutter/material.dart' hide TextButton;
import 'package:teaching_platform/common/widgets/button/text_button.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/common/widgets/tappable/tappable.dart';
import 'package:teaching_platform/social_media/widgets/values.dart';

class ButtonRow extends StatelessWidget {
  final void Function() onAddImagePressed;
  final void Function() onSubmitPressed;

  const ButtonRow({
    super.key,
    required this.onAddImagePressed,
    required this.onSubmitPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;

    return LayoutBuilder(
      builder: (_, constraints) {
        return Row(
          children: [
            Tappable(
              onTap: onAddImagePressed,
              child: Container(
                width: buttonRowHeight,
                height: buttonRowHeight,
                decoration: ShapeDecoration(
                  shape: const CircleBorder(),
                  color: theme.colors.primary,
                ),
                child: Icon(
                  Icons.image,
                  color: theme.colors.onPrimary,
                  size: buttonRowHeight * 0.6,
                )
              ),
            ),
            const Spacer(),
            TextButton(
              "Submit",
              onPressed: onSubmitPressed,
            ),
          ]
        );
      }
    );
  } 
}