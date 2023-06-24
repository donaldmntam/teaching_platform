import 'package:flutter/material.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/button/selectable_text_button.dart';
import 'package:teaching_platform/common/widgets/services.dart/services.dart';

class Selector extends StatelessWidget {
  const Selector({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "I'm a",
          style: theme.textStyle(
            size: 24,
            weight: FontWeight.bold,
            color: theme.colors.primary,
          )
        ),
        const SizedBox(width: 24),
        SelectableTextButton(
          "Teacher",
          selected: true,
          onPressed: () {}
        ),
        const SizedBox(width: 24),
        SelectableTextButton(
          "Student",
          selected: false,
          onPressed: () {}
        ),
      ]
    );
  }
}