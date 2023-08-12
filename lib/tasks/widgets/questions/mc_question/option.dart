import 'package:flutter/material.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';

class Option extends StatelessWidget {
  final String option;
  final bool chosen;

  const Option({
    super.key,
    required this.option,
    required this.chosen,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;

    return Row(
      children: [
        Icon(
          chosen 
            ? Icons.radio_button_checked
            : Icons.radio_button_unchecked,
          color: theme.colors.onSurface,
        ),
        const SizedBox(width: 8),
        Text(
          option,
          style: theme.textStyle(
            size: 14, 
            weight: FontWeight.normal,
            color: theme.colors.onSurface,
          )
        ),
      ]
    );
  }
}