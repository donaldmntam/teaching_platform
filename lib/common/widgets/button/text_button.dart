import 'package:flutter/material.dart' hide ButtonStyle;
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/button/button.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';

import 'button_style.dart';

class TextButton extends StatelessWidget {
  final String text;
  final ButtonStyle style;
  final void Function() onPressed;

  const TextButton(
    this.text,
    {super.key,
    this.style = ButtonStyle.primary,
    required this.onPressed}
  );

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Button(
      color: switch (style) {
        ButtonStyle.primary => theme.colors.primary,
        ButtonStyle.secondary => theme.colors.secondary,
      },
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Text(
          text,
          style: theme.textStyle(
            size: 24,
            weight: FontWeight.bold,
            color: switch (style) {
              ButtonStyle.primary => theme.colors.onPrimary,
              ButtonStyle.secondary => theme.colors.onSecondary,
            }
          )
        ),
      )
    );
  }
}