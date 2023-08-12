import 'package:flutter/material.dart' hide ButtonStyle, Theme;
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/button/button.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';

import 'button_style.dart'; 

// TODO: text size?

class SelectableTextButton extends StatelessWidget {
  final String text;
  final bool selected;
  final ButtonStyle style;
  final void Function() onPressed;

  const SelectableTextButton(
    this.text,
    {super.key,
    required this.selected,
    this.style = ButtonStyle.primary,
    required this.onPressed}
  );

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Button(
      color: _background(theme, selected, style),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Text(
          text,
          style: theme.textStyle(
            size: 24,
            weight: FontWeight.bold,
            color: _foreground(theme, style),
          )
        ),
      )
    );
  }
}

const _selectedBackgroundAlpha = 100;
const _unselectedBackgroundAlpha = 30;

Color _background(
  Theme theme,
  bool selected,
  ButtonStyle style
) =>
  switch (style) {
    ButtonStyle.primary => theme.colors.primary.withAlpha(
      selected ? _selectedBackgroundAlpha : _unselectedBackgroundAlpha
    ),
    ButtonStyle.secondary => theme.colors.secondary.withAlpha(
      selected ? _selectedBackgroundAlpha : _unselectedBackgroundAlpha
    )
  };

Color _foreground(
  Theme theme,
  ButtonStyle style,
) => switch (style) {
  ButtonStyle.primary => theme.colors.primary,
  ButtonStyle.secondary => theme.colors.secondary,
};
