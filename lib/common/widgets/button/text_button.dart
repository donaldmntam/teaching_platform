import 'package:flutter/material.dart' hide ButtonStyle;
import 'package:teaching_platform/common/functions/block_functions.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/button/button.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';

import 'button_style.dart';

class TextButton extends StatelessWidget {
  final String text;
  final ButtonStyle style;
  final void Function()? onPressed;

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
      color: run(() {
        if (onPressed == null) {
          return theme.colors.disabled;
        }
        return switch (style) {
          ButtonStyle.primary => theme.colors.primary,
          ButtonStyle.secondary => theme.colors.secondary,
        };
      }),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Text(
          text.toUpperCase(),
          style: theme.textStyle(
            size: 24,
            weight: FontWeight.bold,
            letterSpacing: 2,
            color: run(() {
              if (onPressed == null) {
                return theme.colors.onDisabled;
              }
              return switch (style) {
                ButtonStyle.primary => theme.colors.onPrimary,
                ButtonStyle.secondary => theme.colors.onSecondary,
              };
            })
          )
        ),
      )
    );
  }
}
