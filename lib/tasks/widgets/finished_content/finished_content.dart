import 'package:flutter/widgets.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';

class FinishedContent extends StatelessWidget {
  const FinishedContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;

    return Container(
      color: theme.colors.surface,
      alignment: Alignment.center,
      child: Text(
        "Task Finished",
        style: theme.textStyle(
          size: 32,
          color: theme.colors.primary,
          weight: FontWeight.normal,
        )
      )
    );
  }
}